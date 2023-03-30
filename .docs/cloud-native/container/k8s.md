# Kubernetes-K8S

## 组件

|核心组件名称|描述|
|-|-|
|ETCD|保存整个集群的状态|
|APIServer|提供资源操作的唯一入口并提供认证、授权、访问控制、API注册和发现等机制|
|Controller Manager|负责维护集群的状态，故障检测、自动扩展、滚动更新等|
|Scheduler|负责资源的调度，按照预定的调度策略将Pod调度到对应的机器上|
|Kubelet|负责维护容器的生命周期，同时也负责Volume（CVI）和网络（CNI）管理|
|Container Runtime负责镜像管理以及Pod和容器的真正运行（CRI）|
|Kube-Proxy|负责为Service提供cluster内部的服务发现和负载均衡|

|Add-ons组件名称|描述|
|-|-|
|kube-dns|负责为整个集群提供dns服务|
|Ingress Controller|为服务提供外网入口|
|Heapster|提供资源监控|
|Dashboard|提供GUI|
|Federation|提供跨可用区的集群|
|Fluentd-elasticsearch|提供集群日志采集、存储与查询|

## 分层架构

|分层|描述|
|-|-|
|核心层|Kubernetes最核心的功能，对外提供API构建高层的应用，对内提供插件式应用执行环境|
|应用层|部署（无状态应用、有状态应用、批处理任务、集群应用等）和路由（服务发现、DNS解析等）|
|管理层|系统度量（如基础设施、容器和网络的度量），自动化（如自动扩展、动态Provision等）以及策略管理（RBAC、Quota、PSP、NetworkPolicy等）|
|接口层|kubectl命令行工具、客户端SDK以及集群联邦|
|生态系统|在接口层之上的庞大容器集群管理调度的生态系统，可以划分为两个范畴|

- 生态系统

   - Kubernetes外部：日志、监控、配置管理、CI、CD、Workflow、FaaS、OTS应用、ChatOps等
   - Kubernetes内部：CRI、CNI、CVI、镜像仓库、Cloud Provider、集群自身的配置和管理等

## K8S架构

## K8S部署(集群搭建)
- Docker基础知识
- 网络插件


## 核心使用

### 核心概念
- Namespace: 对集群资源进行隔离划分。默认只隔离资源，不隔离网络(可以用于区分两套完全一样的环境，例如区分prod和dev环境)
- Pod: Kubernetes应用的最小单位

### Deployment
- 多副本
- 扩缩容
- 自愈(能恢复)&故障转移(机器本身下线了，转移到另一个机器)
- 滚动更新
- 版本回退

### 工作负载
- Deployment: 无状态应用部署（微服务；提供多版本等功能）
- StatefulSet: 有状态应用部署服务（Redis；提供稳定的存储和网络等功能）
- DaemonSet: 守护型应用部署（日志收集组建；在每个机器都会运行一份）
- Job/CronJob: 定时任务部署（垃圾清理组建；在指定时间执行）

## Service-网络服务
本质是将一组 Pods 公开为网络服务的抽象方法

- 接口暴露
- 服务发现(当然这里需要注意，一旦重启，你在某一个Pod的修改就会消失，即虽然可以转发，但是是按着默认的Container，所以之前一旦进行了扩缩容，那么他就是真的把之前的container删除了)
- 服务暴露(主要是为了区分集群内和集群外的暴露)
  - ClusterIP
  - NodePort

## 网络模型
Ingress是Service的统一网关入口(本质其实是在套娃，不过很有效)

- Ingress层(负载均衡；反向代理；域名)
- Service层
- Pod层
- 高级配置(注解): 域名访问；域名重写；流量限制

## 存储对象
举一个例子，如果按照原本的Docker那样的挂在方式，如果Pod挂了之后，被K8S重启到另一个机器的话，那么挂载方面会有冲突？因此就诞生了一种解决方法，最终把数据的挂载交给K8S管理，形成存储层。即将存储层进行抽象

- NFS 网络文件系统(存储抽象)
- PV(Persident Volume, 持久卷, 将应用需要持久化的数据保存到指定位置)&PVC(President Volume Claim, 持久卷声明, 声明需要使用的持久卷规格)
- ConfigMap
- Secret(对象类型用来保存敏感信息, 便于统一是使用)
