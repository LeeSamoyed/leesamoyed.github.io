# AKS Gitpod(Self-Hosted) 配置方法

## Gitpod

- [Gitpod](https://www.gitpod.io/)

- [Gitpod-Docs](https://www.gitpod.io/docs/introduction)

- [Gitpod-Self-Hosted](https://www.gitpod.io/docs/configure/self-hosted/latest)

## 安装流程

### Windows

- 安装docker

- 下载[gitpod-microsoft-aks-guide](https://github.com/gitpod-io/gitpod-microsoft-aks-guide)

- 配置 .env 文件 <- .env.example 修改之后改名为 .env

- make install

### Mac

预备阶段
- 
```
# 安装 azure-cli
brew update && brew install python@3.10 && brew upgrade python@3.10
brew link --overwrite python@3.10
brew update && brew install azure-cli
az upgrade

# 安装所需包
brew install helm
brew install jq

# 和windows方法一样配置 .env 文件

# 安装
sh setup.sh
```

## 问题

没有特别需要说明的，不过不要自己创建资源组、K8S环境等

配置好 .env 文件都能解决

sh运行时如果出现ERROR请不要手快就直接终止程序，这个是程序内的，正常现象！

## 歪路

### 通过虚拟机直接部署K8S + Gitpod等

这是一个比较麻烦的问题，如果要通过在Azure中创建虚拟机手动搭建K8S环境，然后搭建Gitpod等，首先需要强大的网络安全相关知识(解决防火墙和安全组等问题)，还需要理解K8S、Gitpod、Linux等各种环境知识

### 在Azure官方页面中用CLI部署

- Docker不存在

- sudo无法用，无法curl

这其实是因为页面的CLI功能有限

### 通过dashboard来操作

- 在K8S中安装dashboard，然后通过K8S的官方给的教程直接拉

正式部署的项目中，不应该出现K8S的dashboard

### 把gitpod打包，通过kubectl拉下来

神仙想法