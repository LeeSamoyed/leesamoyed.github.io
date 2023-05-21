# K8S源代码解读

源代码下载

```sh
# 代码下载
git clone https://github.com/kubernetes/kubernetes.git

# 回退first commit
git reset --hard 2c4b3a562ce34cddc3f8218a2c4d11c7310e6d56
```

## 2014-06-06 first commit

### 源码路径解析

```sh
# 看得时候可以结合README看

|-- kubernetes
    |-- api                      
        |-- doc (schema)            # 用于验证
        |-- examples            
    |-- cmd                         # 二进制命令入口文件
        |-- apiserver               # main, httpserver, 依赖, ...
        |-- cloudcfg                # kubectl前身
        |-- controller-manager      # k8s组件: ControllerManager
        |-- kubelet                 # k8s组件: Kubelet (Docker的封装，每个机器都有，用于删除启动容器等)
        |-- proxy                   # k8s组件: Network相关
    |-- examples                    # 和上面的examples差不多有启动前后端+Redis服务
    |-- hooks                       # Github信息, 提交前的事儿
    |-- pkg                         # ⭐️⭐️⭐️重要学习部分
        |-- registry
            |-- etcd_registry.go    # 最基础的Registry, 其余都是他的分层封装
    |-- src
        |-- release                 # 脚本文件 [启动K8S(gcloud gutils)等]
    |-- third_party                 # 依赖文件
    |-- .gitignore                  # 忽略上传文本文件
    |-- LICENSE                     # 开源协议
    |-- README.md                   # 说明文档
```

### apiserver

用于接受客户端请求，并将请求保存于ETCD

apiserver做了两个事儿:

    - Storage Interface
    - ServeHTTP

##### Registry

对存储的抽象

```go
var (
    taskRegistry       registry.TaskRegistry
    controllerRegistry registry.ControllerRegistry
    serviceRegistry    registry.ServiceRegistry
)
```

##### RESTStorage interface (存储)

实现的统一接口, 使得开发人员可以在Handle层进行统一抽象

```go
storage := map[string]apiserver.RESTStorage{
    "tasks":                  registry.MakeTaskRegistryStorage(taskRegistry, containerInfo, registry.MakeFirstFitScheduler(machineList, taskRegistry)),
    "replicationControllers": registry.MakeControllerRegistryStorage(controllerRegistry),
    "services":               registry.MakeServiceRegistryStorage(serviceRegistry),
}
```

##### SyncServiceEndpoints

这个Endpoints

=== "SyncServiceEndpoints apiserver接口" 

    cmd/apiserver/apiserver.go

    ```go
    endpoints := registry.MakeEndpointController(serviceRegistry, taskRegistry)
    go util.Forever(func() { endpoints.SyncServiceEndpoints() }, time.Second*10)
    ```

=== "SyncServiceEndpoints实现"

    pkg/registry/endpoints.go

    ```go
    func (e *EndpointController) SyncServiceEndpoints() error {
        // 获取ETCD中service列表
        services, err := e.serviceRegistry.ListServices()
        if err != nil {
            return err
        }
        var resultErr error
        for _, service := range services.Items {
            // 对ETCD中service列表查task
            tasks, err := e.taskRegistry.ListTasks(&service.Labels)
            if err != nil {
                log.Printf("Error syncing service: %#v, skipping.", service)
                resultErr = err
                continue
            }
            // 找到task中endpoints
            endpoints := make([]string, len(tasks))
            for ix, task := range tasks {
                // TODO: Use port names in the service object, don't just use port #0
                endpoints[ix] = fmt.Sprintf("%s:%d", task.CurrentState.Host, task.DesiredState.Manifest.Containers[0].Ports[0].HostPort)
            }
            // 更新service (kube-proxy做负载均衡等, kube-proxy需要知道哪些需要映射)
            // 目前可能已经拆除去了，但是第一版中是耦合的，现在的代码应该在endpoint controller在做
            err = e.serviceRegistry.UpdateEndpoints(Endpoints{
                Name:      service.ID,
                Endpoints: endpoints,
            })
            if err != nil {
                log.Printf("Error updating endpoints: %#v", err)
                continue
            }
        }
        return resultErr
    }
    ```

##### ServeHttp

=== "ServeHttp实现"

    ```go
    // HTTP Handler interface
    func (server *ApiServer) ServeHTTP(w http.ResponseWriter, req *http.Request) {
        log.Printf("%s %s", req.Method, req.RequestURI)
        url, err := url.ParseRequestURI(req.RequestURI)
        if err != nil {
            server.error(err, w)
            return
        }
        //访问主页
        if url.Path == "/index.html" || url.Path == "/" || url.Path == "" {
            server.handleIndex(w)
            return
        }
        if !strings.HasPrefix(url.Path, server.prefix) {
            server.notFound(req, w)
            return
        }
        // 截取URL
        requestParts := strings.Split(url.Path[len(server.prefix):], "/")[1:]
        if len(requestParts) < 1 {
            server.notFound(req, w)
            return
        }
        // 获取操作的资源，从Map中找对应的Storage
        storage := server.storage[requestParts[0]]
        if storage == nil {
            server.notFound(req, w)
            return
        } else {
            // 做handleREST
            server.handleREST(requestParts, url, req, w, storage)
        }
    }
    ```

    ```go
    // handleREST主要是做运行时映射, 映射为storage方法 (后面是parts[1])
    func (server *ApiServer) handleREST(parts []string, url *url.URL, req *http.Request, w http.ResponseWriter, storage RESTStorage) {
        switch req.Method {
        case "GET":
            switch len(parts) {
            case 1:
                controllers, err := storage.List(url)
                if err != nil {
                    server.error(err, w)
                    return
                }
                server.write(200, controllers, w)
            case 2:
                task, err := storage.Get(parts[1])
                if err != nil {
                    server.error(err, w)
                    return
                }
                if task == nil {
                    server.notFound(req, w)
                    return
                }
                server.write(200, task, w)
            default:
                server.notFound(req, w)
            }
            return
        case "POST":
            if len(parts) != 1 {
                server.notFound(req, w)
                return
            }
            body, err := server.readBody(req)
            if err != nil {
                server.error(err, w)
                return
            }
            obj, err := storage.Extract(body)
            if err != nil {
                server.error(err, w)
                return
            }
            storage.Create(obj)
            server.write(200, obj, w)
            return
        case "DELETE":
            if len(parts) != 2 {
                server.notFound(req, w)
                return
            }
            err := storage.Delete(parts[1])
            if err != nil {
                server.error(err, w)
                return
            }
            server.write(200, Status{success: true}, w)
            return
        case "PUT":
            if len(parts) != 2 {
                server.notFound(req, w)
                return
            }
            body, err := server.readBody(req)
            if err != nil {
                server.error(err, w)
            }
            obj, err := storage.Extract(body)
            if err != nil {
                server.error(err, w)
                return
            }
            err = storage.Update(obj)
            if err != nil {
                server.error(err, w)
                return
            }
            server.write(200, obj, w)
            return
        default:
            server.notFound(req, w)
        }
    }
    ```

### LabelMatch (PR: 130)

[Code](https://github.com/kubernetes/kubernetes/pull/130/commits/3ab2f8a3a21e62638ff07a564164d2e60ae1a101?diff=unified&w=0#diff-41502f4ced9efc5419c6634702f8ca3c755737e66471ef87853b63a626224a5d)

给定一个Map的Label, 进行操作决策

=== "LabelMatch (新版)"

    ```go
    type Query interface {
        // Returns true if this query matches the given set of labels.
        Matches(Labels) bool

        // Prints a human readable version of this label query.
        String() string
    }
    
    // 有一个匹配
    type hasTerm struct {
        label, value string
    }
    func (t *hasTerm) Matches(ls Labels) bool {
        return ls.Get(t.label) == t.value
    }
    func (t *hasTerm) String() string {
        return fmt.Sprintf("%v=%v", t.label, t.value)
    }

    // 有一个不匹配
    type notHasTerm struct {
        label, value string
    }
    func (t *notHasTerm) Matches(ls Labels) bool {
        return ls.Get(t.label) != t.value
    }
    func (t *notHasTerm) String() string {
        return fmt.Sprintf("%v!=%v", t.label, t.value)
    }

    // 自包含
    type andTerm []Query
    ```

=== "方法详解 (新版)"

=== "LabelMatch (一版)"

    ```go
    // Represents a query.
    type LabelQuery interface {
        // Returns true if this query matches the given set of labels.
        Matches(Labels) bool

        // Prints a human readable version of this label query.
        String() string
    }

    // 反转标记
    // A single term of a label query.
    type labelQueryTerm struct {
        // Not inverts the meaning of the items in this term.
        not bool

        // Exactly one of the below three items should be used.

        // If non-nil, we match LabelSet l iff l[*label] == *value.
        label, value *string

        // 递归方式 (虽然不完全是)
        // A list of terms which must all match for this query term to return true.
        and []labelQueryTerm

        // 匹配任意一个
        // A list of terms, any one of which will cause this query term to return true.
        // Parsing/printing not implemented.
        or []labelQueryTerm
    }
    ```

=== "方法详解 (一版)"

    ```go
    func (l *labelQueryTerm) Matches(ls Labels) bool {
        // 反转
        matches := !l.not
        switch {
        // 判断自己的Label是否是nil (为了后面的精确匹配)
        case l.label != nil && l.value != nil:
            if ls.Get(*l.label) == *l.value {
                return matches
            }
            return !matches
        case len(l.and) > 0:
            for i := range l.and {
                if !l.and[i].Matches(ls) {
                    return !matches
                }
            }
            return matches
        case len(l.or) > 0:
            for i := range l.or {
                if l.or[i].Matches(ls) {
                    return matches
                }
            }
            return !matches
        }

        // Empty queries match everything
        return matches
    }

    func try(queryPiece, op string) (lhs, rhs string, ok bool) {
        pieces := strings.Split(queryPiece, op)
        if len(pieces) == 2 {
            return pieces[0], pieces[1], true
        }
        return "", "", false
    }

    // 解析query-string to label-query
    // Takes a string repsenting a label query and returns an object suitable for matching, or an error.
    func ParseLabelQuery(query string) (LabelQuery, error) {
        parts := strings.Split(query, ",")
        var items []labelQueryTerm
        for _, part := range parts {
            if part == "" {
                continue
            }
            if lhs, rhs, ok := try(part, "!="); ok {
                items = append(items, labelQueryTerm{not: true, label: &lhs, value: &rhs})
            } else if lhs, rhs, ok := try(part, "=="); ok {
                items = append(items, labelQueryTerm{label: &lhs, value: &rhs})
            } else if lhs, rhs, ok := try(part, "="); ok {
                items = append(items, labelQueryTerm{label: &lhs, value: &rhs})
            } else {
                return nil, fmt.Errorf("invalid label query: '%s'; can't understand '%s'", query, part)
            }
        }
        if len(items) == 1 {
            return &items[0], nil
        }
        return &labelQueryTerm{and: items}, nil
    }


    // ··· 省略很多代码

    func TestSimpleLabel(t *testing.T) {
        shouldMatch(t, "", LabelSet{"x": "y"})
        shouldMatch(t, "x=y", LabelSet{"x": "y"})
        shouldMatch(t, "x=y,z=w", LabelSet{"x": "y", "z": "w"})
        shouldMatch(t, "x!=y,z!=w", LabelSet{"x": "z", "z": "a"})
        shouldNotMatch(t, "x=y", LabelSet{"x": "z"})
        shouldNotMatch(t, "x=y,z=w", LabelSet{"x": "w", "z": "w"})
        shouldNotMatch(t, "x!=y,z!=w", LabelSet{"x": "z", "z": "w"})
    }   
    ```

### CloudConfig



