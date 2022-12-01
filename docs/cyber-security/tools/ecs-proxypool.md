# ECS 代理池配置

## 代理池的配置前提：
- 代理池的原始代码位置：https://github.com/Python3WebSpider/ProxyPool
- 安装步骤
  1. 安装Download代码所需要的软件Git 
  2. 安装Redis
  3. 安装Python运行环境（本文采用Anaconda虚拟环境，方便后期进行其他开发）

## 安装：
### Git安装

```
yum install git
```

### 文件创建及代码拷贝

```
mkdir Proxypool
cd Proxypool
git clone https://github.com/Python3WebSpider/ProxyPool
```

到这里为止，安装代理池所需要的代码就算是准备完成了，下面开始对代理池所需要的Python运行环境和Redis数据库进行安装

### Anaconda
1. 通过国内镜像源下载anaconda
```
wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-2021.05-Linux-x86_64.sh
```

2. 运行命令对Anaconda进行安装（这里在安装的时候，有一些服务器需要使用chmod进行权限修改，但是并没有理解如果不进行相关操作会产生的问题，或者进行了会有何种方便，所以这里直接进行相关安装）
```
bash Anaconda3-2021.05-Linux-x86_64.sh
```

3. 使用Anaconda创建环境，并运行代码(参考Anaconda具体的使用方法)