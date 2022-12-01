# Docker - 容器

## 解决的问题

### 统一标准
- 应用构建(build)
- 应用分享
- 应用运行(run)
......

- 虚拟化
- 容器化

### 资源隔离
- cpu、memory资源隔离与限制
- 访问设备隔离与限制
- 网络隔离与限制
- 用户、用户组隔离限制
......

## 架构
- Docker host(主机)
- Docker daemon(主机上的后台进程)
- Client(客户端；命令行等)
- Registry(镜像仓库Docker Hub等)
- Images(镜像；打包好的环境，直接运行)
- Containers(由镜像启动的正在运行的程序)
