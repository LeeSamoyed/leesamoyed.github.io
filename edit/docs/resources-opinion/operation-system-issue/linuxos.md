# Linux OS

## Deepin

### 旧deepin卸载和新deepin安装
1. 删除卸载多余启动项（Windows版）：EasyUEFI_Free。
2. 控制面板-磁盘管理-删除卷。
3. Deepin系统安装
  a. 下载光盘映像文件
  b. 制作deepin启动盘
  c. 安装deepin

### deepin中无法找到TIM等软件
1. 更改系统时区：上海

### deepin安装nvidia驱动、cuda、cudnn
1. 先切N卡！！！
2. 禁止原本显卡驱动
```
sudo vim /etc/modprobe.d/blacklist.conf
#填入
blacklist nouveau
options nouveau modeset=0
#执行
reboot
lsmod | grep nouveaugu
```
3. 安装过debian仓库独显闭源驱动的首先需要卸载老驱动，不然之后安装新驱动时会无法安装
```
sudo apt-get remove ––purge nvidia*
```
4. 安装过版本nvidia的
```
sudo apt-get remove nvidia-driver nvidia-kernel-dkms glx-alternative-nvidia
#或者
sudo nvidia-uninstall
sudo nvidia-installer --uninstall
```
5. 安装nvidia显卡驱动
```
sudo apt update
sudo apt install nvidia-smi nvidia-driver
```
6. cuda9.0要求gcc和g++版本在4.9~6.0之间，而deepin自带的是7.+，需要降级：
```
#老版本5.0可能禁用换个源就好
sudo apt install g++-5 gcc-5.0
cd /usr/bin
sudo rm gcc g++
sudo ln -s g++-5 g++
sudo ln -s gcc-5 gcc
```
7. 重启
```
reboot
```
8. 验证nvidia显卡驱动是否安装成功
```
nvidia-smi
#nvidia显卡驱动安装完毕
```
9. 查看显卡是否支持cuda
```
lspci | grep -i nvidia
#上述语句可以查看显卡型号
#之后去官网查看自己的显卡是否支持cuda
```
10. 下载对应cuda安装包
11. 确认nouveau已经禁用
```
# 确认禁用语句
lsmod | grep nouveau
#如果不显示任何东西则禁用成功

# 禁用语句
sudo vim /etc/modprobe.d/blacklist.conf
blacklist nouveau
options nouveau modeset=0
#禁用nouveau第三方驱动
```
12. 验证是否安装gcc
```
gcc --version
```
13. 安装cuda
```
# 进入cuda文件夹，给cuda可执行权利
sudo chmod a+x cuda_9.0.176_384.81_linux.run
#可能会根据版本不同改变文件名

# 运行cuda文件
sudo ./cuda_9.0.176_384.81_linux.run --no-opengl-libs
#注意：显卡驱动driver不需要安装
```
14. 配置环境变量
```
vim ~/.bashrc
# add cuda
export PATH=/usr/local/cuda-9.0/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64:$LD_LIBRARY_PATH
```
15. 重启环境变量
```
source /etc/profile
```
16. 验证CUDA安装
```
nvcc -V
#cuda安装完毕
```

### chrome离线插件安装
1. 下载插件
2. 到安装目录将crx后缀变为rar或者zip
3. 双击进入将_metadata改为metadata
4. 解压
5. 进入 chrome://extensions/ 
6. 打开开发者模式
7. 加载已解压扩展程序
