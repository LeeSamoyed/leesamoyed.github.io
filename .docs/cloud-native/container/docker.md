# Docker - 容器

## Docker简介

=== "Docker定义"
    Docker是go语言编写的开源的PaaS

=== "Docker实现"
    Docker基于Linux内核实现（基于LXC的高级封装后面变为自研的runc）

=== "Docker架构"
    Docker采用客户端服务端架构，使用API管理和创建Docker容器

    Docker理念：build（构建）、ship（运输）、run（运行）

=== "Docker组成"

    Docker主机(Host): 一个物理机或者虚拟机，用于运行Docker服务进程和容器

    Docker服务端(Server): Docker守护进程，运行Docker容器

    Docker客户端(Client): 客户端使用docker命令或其他工具调用dockerAPI

    Docker仓库(Registry): 保存镜像的仓库，类似git或svn这样的版本控制系统。[官方仓库](https://hub.docker.com)

    Docker镜像(Images): 镜像可以理解为创建实例用的模板

    Docker容器(Container): 容器是从镜像生成对外提供服务的一个或一组服务

=== "Docker优劣"

    优势：
    
    - 快速部署：短时间内可以部署成百上千个应用，更快速交付到线上
    - 高效虚拟化:不需要额外的 hypervisor 支持,直接基于 linux 实现应用虚拟化，相比虚拟机大幅提高性能和效率
    - 节省开支:提高服务器利用率，降低 IT 支出
    - 简化配置:将运行环境打包保存至容器，使用时直接启动即可
    - 快速迁移和扩展:可跨平台运行在物理机、虚拟机、公有云等环境，良好的兼容性可以方便从A宿主机迁移到B宿主机，甚至是A平台迁移到B平台
    
    劣势：

    - 各应用之间的隔离不如虚拟机彻底

## Linux Namespace

|隔离类型|功能|
|-|-|
|MNT Namespace|提供硬盘挂载点和文件系统隔离能力|
|IPC Namespace|提供进程间通信隔离能力|
|UTS Namespace|提供主机名隔离能力|
|PID Namespace|提供进程隔离能力|
|Net Namespace|提供网络隔离能力|
|User Namespace|提供用户隔离能力|

## CGroup简介；容器runtime；image规范

!!! note "学习"
    
    CoreOS

### CGroup

限制资源使用上限

### 容器规范

=== "runtime"
    
    版本信息、PID、创建过程、生命周期管理、容器的目录 ...

    - Lxc
    - runc
    - rkt

=== "镜像"

    文件系统（以layer保存，且只记录与上层的差异）。容器镜像也定义了layer应该保存那些文件；怎么表示增加、修改和删除的文件等操作

## 编排工具及依赖技术

### 容器定义工具

    - Docker Image
    - Dockerfile
    - ACI(Application Container Image, CoreOS RKT)

### Registry

    - Harbor: 带图形私有项目 https://github.com/goharbor/harbor
    - Docker Hub: 速度慢；安全性
    - Registry: 官方私有 https://github.com/docker/distribution

### 编排工具
    
    - Docker SWARM
    - K8S
    - Mesos + Marathon

### 容器依赖技术

    - 容器网络
        * alico
        * flannel

    - 服务发现
        * skydns -> kubedns -> **coredns**

    - 容器监控
        * heapster
        * Prometheus

    - 数据管理
        * NAS

    - 日志收集

## 存储引擎及镜像

[Docker Storage Driver](https://docs.docker.com/storage/storagedriver/select-storage-driver/)

如果要更换存储引擎

    - 镜像

    - 数据

    - 容器

## Docker镜像操作

## Docker命令

## Docker镜像制作

[Dockerfile](https://docs.docker.com/engine/reference/builder/)

### 分层构建

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
