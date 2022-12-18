# 注意力机制

### 注意力机制介绍：

1. 注意力机制的任务是模拟人，投入更多的注意力到重点的地方，忽略一些不重要的地方；
   在计算机视觉中是对feature map进行加权；
2. 注意力机制用于很多领域（大多是分割）；


### 作用目标：

1. channel（通道）：是什么（关注点）
2. spacial（空间）：在哪里（关注点）
3. 举例：
   1. 假设现在有一个feature map：[1,512,100,100]通道学习过后分数：[1,512,1,1]（在乎通道信息）对当前层每一张特征图进行打分
   2. 空间学习过后分数：[1,1,100,100]（在乎空间信息）对当前层所有特征图每一个位置进行打分
4. 顺带一提：Attention有上下文语境的问题


### 相关Attention：

- SENet(Squeeze and Excitation Networks)
- Non-local
    基于图像非局部均值滤波
    $\frac{1}{f(x)} \cdot \Sigma f(x_i;x_j) \cdot g(x)$

- SKNet
    与SENet相比会进行通道划分（上面是重要特征图，下面是不重要特征图）（划分不止两个（其实是超参数））
    将重要和忽略的相加
    提升不多

- BiseNet
- Towards University Object Detection by Domain Attention
    SENet改进
    多域目标检测

- AUNet
    情景分割
    两个Attention模块

- DANet
- DFN
    两个网络：Border Network&Smooth Network
    解决两个问题：类内部一致（同一物品内部差距过大）（Smooth Network）&类间相似（两个物体放在一起，相似过高）（放在一起的PS4和主机）
    Attention模块（CAB）

- Spatial Group-wise Enhance
    当前特征分组 -> 平均池化 -> 和原本池化相乘 -> 归一化   -> Sigmoid -> 在和原本池化相乘

- GCNet
- LEDNet
    实时语义分割
    
- CCNet
- Fast Mask
- Bottleneck Attention Module


***

学习资料:

- [白博文的猫](https://www.bilibili.com/video/av54944893/?from=search&seid=1440515739969372076)

- [深度学习入门之注意力机制](https://zhuanlan.zhihu.com/p/76717921?utm_source=qq&utm_medium=social&utm_oi=697779883681538048)