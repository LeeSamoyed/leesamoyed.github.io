# Docker

由于是在线文档导致pdf,png等资料无法看清，建议直接下载相关文件

如果存在资料过期、资料过时，建议通过首页邮箱联系

***

## Docker基础命令

### 查看docker版本信息

```
$ docker --version
```

### 查看docker安装信息

```
$ docker info
```

### 查看本机Docker中存在哪些镜像

```
$ docker images
```

### 检索images

```
$ docker search images
```

### 拉images

```
$ docker pull images
```

### 显示一个镜像的历史操作

```
$ docker history images
```

### 列出一个容器里面被改变的文件或者目录

```
$ docker diff container
```

### 列出当前所有正在运行的容器

```
$ docker ps
```

### 列出所有的容器

```
$ docker ps -a
```

### 列出最近一次启动的容器

```
$ docker ps -f
```

### 查看容器的相关信息

```
$ docker inspect $CONTAINER_ID
```

### 显示容器IP地址和端口号，如果输出是空的说明没有配置IP地址（不同的Docker容器可以通过此IP地址互相访问）

```
$ docker inspect --format='{{.NetworkSettings.IPAddress}}' $CONTAINER_ID
```

### 通过容器生成新的镜像

```
$ docker commit -m "Added ssh from centos" -a "xiaoming" 4a4de4cf223d1 xiaoming/centos:v1

参数：
-m参数用来来指定提交的说明信息；
-a可以指定用户信息的；
4a4de4cf223d1代表的时容器的id；
birdben/ubuntu:v1指定目标镜像的用户名、仓库名和 tag 信息。
```

### 构建一个容器

```
$ docker build -t="centos:v1" .

参数：
-t为构建的镜像制定一个标签，便于记忆/索引等
. 指定Dockerfile文件在当前目录下，也可以替换为一个具体的 Dockerfile 的路径。
```

### 在docker中运行centos镜像

```
$ docker run <相关参数> <镜像 ID> <初始命令>
```

### 守护模式启动

```
$ docker run -it centos:v1
```

### 指定端口号启动

```
$ docker run -p 80:80 centos:v1
```

### 指定配置启动

```
$ sudo docker run -d -p 10.211.55.4:9999:22 birdben/ubuntu:v1 '/usr/sbin/sshd' -D

参数：
-d：表示以“守护模式”执行，日志不会出现在输出终端上。
-i：表示以“交互模式”运行容器，-i 则让容器的标准输入保持打开
-t：表示容器启动后会进入其命令行，-t 选项让Docker分配一个伪终端（pseudo-tty）并绑定到容器的标准输入上
-v：表示需要将本地哪个目录挂载到容器中，格式：-v <宿主机目录>:<容器目录>，-v 标记来创建一个数据卷并挂载到容器里。在一次 run 中多次使用可以挂载多个数据卷。
-p：表示宿主机与容器的端口映射，此时将容器内部的 22 端口映射为宿主机的 9999 端口，这样就向外界暴露了 9999 端口，可通过 Docker 网桥来访问容器内部的 22 端口了。
注意：这里使用的是宿主机的 IP 地址：10.211.55.4，与对外暴露的端口号 9999，它映射容器内部的端口号 22。ssh外部需要访问：ssh root@10.211.55.4 -p 9999
不一定要使用“镜像 ID”，也可以使用“仓库名:标签名”
```

### start 启动容器

```
$ docker start 117843ade696117843ade696
```

### stop 停止正在运行的容器

```
$ docker stop 117843ade696117843ade696
```

### restart 重启容器

```
$ docker restart 117843ade696117843ade696
```

### rm 删除容器

```
$ docker rm 117843ade696117843ade696
```

### rmi 删除镜像

```
$ docker rmi ed9c93747fe1Deleted
```

### 登录Docker Hub中心

```
$ docker login
```

### 发布上传image（push）

```
$ docker push xiaoming/centos:v1
```

***

资料:

转自：[https://segmentfault.com/a/1190000010219967](https://segmentfault.com/a/1190000010219967)