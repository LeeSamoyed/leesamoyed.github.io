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

