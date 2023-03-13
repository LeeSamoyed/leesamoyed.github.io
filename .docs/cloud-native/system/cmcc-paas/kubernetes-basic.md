# Kubernetes

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

|核心层|Kubernetes最核心的功能，对外提供API构建高层的应用，对内提供插件式应用执行环境|
|应用层|部署（无状态应用、有状态应用、批处理任务、集群应用等）和路由（服务发现、DNS解析等）|
|管理层|系统度量（如基础设施、容器和网络的度量），自动化（如自动扩展、动态Provision等）以及策略管理（RBAC、Quota、PSP、NetworkPolicy等）|
|接口层|kubectl命令行工具、客户端SDK以及集群联邦|
|生态系统|在接口层之上的庞大容器集群管理调度的生态系统，可以划分为两个范畴|

- 生态系统

   - Kubernetes外部：日志、监控、配置管理、CI、CD、Workflow、FaaS、OTS应用、ChatOps等
   - Kubernetes内部：CRI、CNI、CVI、镜像仓库、Cloud Provider、集群自身的配置和管理等

