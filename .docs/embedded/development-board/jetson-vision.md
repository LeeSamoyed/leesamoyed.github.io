### LINUX安装（host）

### 更新源（host）

```
sudo gedit /etc/apt/sources.list

----
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse
----

sudo apt-get update
```

### 安装sdkmanager（host）

```
https://developer.nvidia.com/nvidia-sdk-manager

# 先download再install
# 如果需要长时间安装是否继续，检查各个进程没有问题（网络等），默认继续；CUDA49%大概率会有
```

### 刷机（板子）

```
出现了板子账号密码输入，直接重启板子，不进入recovery模式，初始化板子系统，之后
```

### TX2换源（板子）

```
sudo gedit /etc/apt/sources.list

----
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ xenial main multiverse restricted universe
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ xenial-security main multiverse restricted universe
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ xenial-updates main multiverse restricted universe
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ xenial-backports main multiverse restricted universe
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ xenial main multiverse restricted universe
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ xenial-security main multiverse restricted universe
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ xenial-updates main multiverse restricted universe
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ xenial-backports main multiverse restricted universe
----

sudo apt-get update
```

### 切换python2到python3（板子）

```
cd /usr/bin # 在这个文件夹下
sudo ln -sf python3 python
```

### pip安装和换源（板子）

```
sudo apt-get install python3-pip
pip install pip -U
mkdir ~/.pip/
sudo touch ~/.pip/pip.conf
sudo gedit ~/.pip/pip.conf

####
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
####
```

### numpy安装（注意依赖）——1.18.1（板子）

```
pip install numpy==1.18.1
```

### setup换源（板子）

```
sudo gedit ~/.pydistutils.cfg
####
[easy_install]
index_url = https://pypi.tuna.tsinghua.edu.cn/simple
####
```

### torch1.4.0、torchvision0.5.0安装（板子）

```
https://forums.developer.nvidia.com/t/pytorch-for-jetson-version-1-8-0-now-available/72048
官网教程，记得安装git
```

### cocoapi+FCOS+regnet（板子）

```
直接安装
```

### 摄像头（板子）

```
usb接口 直接OPENCV安装
```

### LED灯带（板子）

```
gpio
```

### 风扇转动（板子）

```
sudo gedit /sys/devices/pwm-fan/target_pwm
# 255（最大）
```

### 最大功率（板子）

```
# 功率设置最大
sudo nvpmodel -m 0
# 功率查看
sudo nvpmodel --query
```

### 注：没有特别说明的缺啥装啥