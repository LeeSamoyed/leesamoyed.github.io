# AKS QDUOJ 部署方法

### Docker to K8S

将docker-compose.yml文件转化为k8s的yml部署文件

参考：[docker2K8S](https://kubernetes.io/zh-cn/docs/tasks/configure-pod-container/translate-compose-kubernetes/)

### deployment

难点在于：

- 如何对端口进行暴露
- 如何选择挂载的方式（这里如果使用的是Microsoft AKS服务，个人推荐使用Disk别使用azure file；其他的产品服务可能也涉及类似的问题请注意）

参考：[K8S-deployment](https://kubernetes.io/zh-cn/docs/concepts/workloads/controllers/deployment/) & [AKS-deployment](https://learn.microsoft.com/en-us/azure/aks/tutorial-kubernetes-deploy-cluster?tabs=azure-cli)

```
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    kompose.cmd: kompose convert
    kompose.version: 1.28.0 (c4137012e)
  creationTimestamp: null
  labels:
    io.kompose.service: judge-server
  name: judge-server
spec:
  replicas: 1
  selector:
    matchLabels:
      io.kompose.service: judge-server
  strategy: {}
  template:
    metadata:
      annotations:
        kompose.cmd: kompose convert
        kompose.version: 1.28.0 (c4137012e)
      creationTimestamp: null
      labels:
        io.kompose.network/yaml-default: "true"
        io.kompose.service: judge-server
    spec:
      containers:
        - env:
            - name: BACKEND_URL
              value: http://oj-backend:8000/api/judge_server_heartbeat/
            - name: SERVICE_URL
              value: http://judge-server:8080
            - name: TOKEN
              value: CHANGE_THIS
          image: registry.cn-hangzhou.aliyuncs.com/onlinejudge/judge_server
          name: judge-server
          ports:
            - containerPort: 8080
              hostIP: 0.0.0.0
          resources: {}
          securityContext:
            capabilities:
              drop:
                - SETPCAP
                - MKNOD
                - NET_BIND_SERVICE
                - SYS_CHROOT
                - SETFCAP
                - FSETID
          volumeMounts:
            - mountPath: /test_case
              name: judge-server-claim0
            - mountPath: /log
              name: judge-server-claim1
            - mountPath: /judger
              name: judge-server-claim2
      restartPolicy: Always
      volumes:
          - name: judge-server-claim0
            persistentVolumeClaim:
              claimName: judge-server-claim0
          - name: judge-server-claim1
            persistentVolumeClaim:
              claimName: judge-server-claim1
          - name: judge-server-claim2
            persistentVolumeClaim:
              claimName: judge-server-claim2
status: {}


---

apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    kompose.cmd: kompose convert
    kompose.version: 1.28.0 (c4137012e)
  creationTimestamp: null
  labels:
    io.kompose.service: oj-backend
  name: oj-backend
spec:
  replicas: 1
  selector:
    matchLabels:
      io.kompose.service: oj-backend
  strategy:
    type: Recreate
  template:
    metadata:
      annotations:
        kompose.cmd: kompose convert
        kompose.version: 1.28.0 (c4137012e)
      creationTimestamp: null
      labels:
        io.kompose.network/test-default: "true"
        io.kompose.service: oj-backend
    spec:
      containers:
        - env:
            - name: FORCE_HTTPS
              value: "1"
            - name: JUDGE_SERVER_TOKEN
              value: 
            - name: POSTGRES_DB
              value: 
            - name: POSTGRES_HOST
              value: 
            - name: POSTGRES_PASSWORD
              value: 
            - name: POSTGRES_USER
              value: 
          image: registry.cn-hangzhou.aliyuncs.com/onlinejudge/oj_backend
          name: oj-backend
          ports:
            - containerPort: 8000
              hostIP: 0.0.0.0
            - containerPort: 1443
              hostIP: 0.0.0.0
          resources: {}
          volumeMounts:
            - mountPath: /data
              name: oj-backend-claim0
            - mountPath: /app/dist
              name: oj-backend-claim1
      restartPolicy: Always
      volumes:
        - name: oj-backend-claim0
          persistentVolumeClaim:
            claimName: oj-backend-claim0
        - name: oj-backend-claim1
          persistentVolumeClaim:
            claimName: oj-backend-claim1
status: {}

---

apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    io.kompose.service: oj-postgres
  name: oj-postgres
spec:
  replicas: 1
  selector:
    matchLabels:
      io.kompose.service: oj-postgres
  strategy:
    type: Recreate
  template:
    metadata:
      creationTimestamp: null
      labels:
        io.kompose.network/k8s-yaml-default: "true"
        io.kompose.service: oj-postgres
    spec:
      containers:
        - env:
            - name: POSTGRES_DB
              value: 
            - name: POSTGRES_PASSWORD
              value: 
            - name: POSTGRES_USER
              value: 
            - name: POSTGRES_HOST
              value: 
          image: postgres:10-alpine
          name: oj-postgres
          ports:
            - containerPort: 5432
              hostIP: 0.0.0.0
          resources: {}
      restartPolicy: Always
status: {}

---

apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    io.kompose.service: oj-redis
  name: oj-redis
spec:
  replicas: 1
  selector:
    matchLabels:
      io.kompose.service: oj-redis
  strategy:
    type: Recreate
  template:
    metadata:
      creationTimestamp: null
      labels:
        io.kompose.network/k8s-yaml-default: "true"
        io.kompose.service: oj-redis
    spec:
      containers: 
        - image: redis:4.0-alpine
          name: oj-redis
          ports:
            - containerPort: 6379
              hostIP: 0.0.0.0
          resources: {}
      restartPolicy: Always
status: {}
```

### Service

难点：

- 请务必确保Service以及EndPoint都开启了
- loadBalancer的规则Azure会处理

```
kubectl get service

kubectl get ep
```

参考：[K8S-service](https://kubernetes.io/zh-cn/docs/concepts/services-networking/service/) & [AKS-service](https://learn.microsoft.com/en-us/azure/aks/)

```
apiVersion: v1
kind: Service
metadata:
  annotations:
    kompose.cmd: kompose convert
    kompose.version: 1.28.0 (c4137012e)
  creationTimestamp: null
  labels:
    io.kompose.service: oj-backend
  name: oj-backend
spec:
  ports:
    - name: "80"
      port: 80
      targetPort: 8000
    - name: "443"
      port: 443
      targetPort: 1443
  selector:
    io.kompose.service: oj-backend
  # type: LoadBalancer
status:
  loadBalancer: {}

---

apiVersion: v1
kind: Service
metadata:
  annotations:
    kompose.cmd: kompose convert
    kompose.version: 1.28.0 (c4137012e)
  creationTimestamp: null
  labels:
    io.kompose.service: oj-redis
  name: oj-redis
spec:
  ports:
    - name: "6379"
      port: 6379
      targetPort: 6379
  selector:
    io.kompose.service: oj-redis
status:
  loadBalancer: {}

---

apiVersion: v1
kind: Service
metadata:
  annotations:
    kompose.cmd: kompose convert
    kompose.version: 1.28.0 (c4137012e)
  creationTimestamp: null
  labels:
    io.kompose.service: judge-server
  name: judge-server
spec:
  ports:
    - name: "8080"
      port: 8080
      targetPort: 8080
  selector:
    io.kompose.service: judge-server
status:
  loadBalancer: {}
```


### PVC

难点：

- 其实大多数不需要挂载（如果数据不需要挪动的话，同时备份方式请参考官方）
- 比较值得挂载的有前端（/app/dist），因为比较少所以作者没有采用initContainer，本质上这个才是挂载和下载数据的最优解
- 值得一提的是，PVC的方式是持久化的，在K8S集群不删除的情况下，只用在初始化的时候拷贝一次数据即可。同时不论是K8S还是Docker的挂载方式都需要注意是否同步！！！

参考：[K8S-PV,PVC](https://kubernetes.io/zh-cn/docs/concepts/storage/persistent-volumes/) & [AKS-PV,PVC](https://learn.microsoft.com/en-us/azure/aks/azure-csi-disk-storage-provision) & [备份](https://opensource.qduoj.com/#/onlinejudge/guide/backup)

```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: judge-server-claim0
spec:
  accessModes:
  - ReadWriteOnce
  storageClassName: default
  resources:
    requests:
      storage: 500Mi

---

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: judge-server-claim1
spec:
  accessModes:
  - ReadWriteOnce
  storageClassName: default
  resources:
    requests:
      storage: 500Mi

---

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: judge-server-claim2
spec:
  accessModes:
  - ReadWriteOnce
  storageClassName: default
  resources:
    requests:
      storage: 500Mi

---

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: oj-backend-claim0
spec:
  accessModes:
  - ReadWriteOnce
  storageClassName: default
  resources:
    requests:
      storage: 500Mi

---

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: oj-backend-claim1
spec:
  accessModes:
  - ReadWriteOnce
  storageClassName: default
  resources:
    requests:
      storage: 500Mi
```

### Network Policy

直接上文件

```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  creationTimestamp: null
  name: yaml-default
spec:
  ingress:
    - from:
        - podSelector:
            matchLabels:
              io.kompose.network/yaml-default: "true"
  podSelector:
    matchLabels:
      io.kompose.network/yaml-default: "true"
```

### 问题解决

如果按照上述文件进行apply大概是没问题的，这里只是提供作者在进行部署的时候踩的雷，在看各种问题前，请读几次log文件，几乎都可以马上反应出来问题所在。

##### 挂载导致Pod无法启动

请仔细阅读官网。值得一提的是，K8S和PV、PVC的启动顺序，挂载顺序等（这就是为什么上问提到一定要用initContainer作为最优解，不过这个对于小型非重要项目就显得不是那么重要了）

##### 部署后访问前端server error

大概率是忘了QDUOJ的pg数据库backend也需要，详见deployment中的yaml文件 

##### 找不到oj-redis:6379或服务拒绝

这个问题是由于service没开，无法通过oj-redis找到服务，同时开了service之后请注意K8S是否自动打开了endpoint，如果没打开，大概率是connect refuse