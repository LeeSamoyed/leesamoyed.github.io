# 计算机视觉

## 论文研读

### Classification
##### AlexNet
- 论文发表时间：2010
- [论文](http://papers.nips.cc/paper/4824-imagenet-classification-with-deep-convolutional-neural-networks.pdf)
- [caffe复现](http://caffe.berkeleyvision.org/gathered/examples/imagenet.html)

##### VGG16
- 论文发布时间：2015.04.10
- [论文](https://arxiv.org/pdf/1409.1556.pdf)

##### ResNet
- [论文](https://arxiv.org/pdf/1512.03385.pdf)
- [解析-转载](https://zhuanlan.zhihu.com/p/352790748)

##### gMLP
- [解析](https://www.yuque.com/office/yuque/0/2022/pdf/358780/1670694899908-5fd22816-8253-462d-ac12-3c8a471e8cd7.pdf?from=https%3A%2F%2Fwww.yuque.com%2Fleesamoyed%2Faioqs5%2Fag615chlvdpac6b9)

##### ViT
- [解析](https://www.yuque.com/office/yuque/0/2022/pdf/358780/1670694903689-5e79cbb6-de6a-4f9f-97d4-706876c77902.pdf?from=https%3A%2F%2Fwww.yuque.com%2Fleesamoyed%2Faioqs5%2Fag615chlvdpac6b9)

##### CapsuleNet
- 论文发表时间：2017.11.07
- [论文](https://arxiv.org/pdf/1710.09829.pdf)
- [解析](https://www.yuque.com/office/yuque/0/2022/pdf/358780/1670694899411-651998e9-6f00-4433-ac4c-bc5cc5c9c13e.pdf?from=https%3A%2F%2Fwww.yuque.com%2Fleesamoyed%2Faioqs5%2Fag615chlvdpac6b9)

### Object Detection
##### SSD
- 论文发表时间：2016.12.29
- [论文](https://arxiv.org/pdf/1512.02325.pdf)
- [code](https://github.com/xiaohu2015/DeepLearning_tutorials/tree/master/ObjectDetections/SSD)
- [解析-转载](https://zhuanlan.zhihu.com/p/33544892)

##### Faster-RCNN
- 论文发表时间：2015.06.04
- [论文](https://arxiv.org/abs/1506.01497)
- [Tensorflow](https://github.com/endernewton/tf-faster-rcnn)
- [解析-转载](https://zhuanlan.zhihu.com/p/31426458)

##### RetinaNet
- 论文发表时间：2018.02.07
- [论文](https://arxiv.org/pdf/1708.02002.pdf)

##### YOLO V3
- YoloV3论文发表时间：2018.04.08
- [论文](https://arxiv.org/pdf/1804.02767.pdf)
- [Keras](https://github.com/qqwweee/keras-yolo3)
- [Yolo官网](https://pjreddie.com/darknet/yolo/)

##### FCOS
- 论文发表时间：2019.08.20
- [论文](https://arxiv.org/pdf/1904.01355.pdf)
- [code](https://github.com/tianzhi0549/FCOS)

### Semantic Segmentation
##### FCN
- 论文发表时间：2015.03.08
- [论文](https://arxiv.org/pdf/1411.4038.pdf)

##### U-Net
- 论文发表时间：2015.05.18
- [论文](https://arxiv.org/pdf/1505.04597.pdf)
- [Tensorflow](https://github.com/jakeret/tf_unet)
- [Keras](https://github.com/zhixuhao/unet)

### Instance Segmentation

##### Mask-RCNN
- 论文发表时间：2018.01.24
- [论文](https://arxiv.org/pdf/1703.06870.pdf)
- [Tensorflow](https://github.com/matterport/Mask_RCNN)

### GAN
##### CycleGAN
- 论文发布时间：2018.11.15
- [论文](https://arxiv.org/abs/1703.10593)
- [解析-转载](https://www.jianshu.com/p/64bf39804c80)

##### DualGAN
- [解析-转载](https://blog.csdn.net/Forlogen/article/details/89058139)

##优缺点总结

### GAN
  
- 优点：
    - 相比于FVBNs（全可见信念网络，Fully visible belief networks）模型，GANs能并行生成样本，不需要逐维产生。
    - 相比于玻尔兹曼机（Boltzmann machines）、非线性ICA（non-linear ICA）等生成模型，GANs对Generator的设计的限制很少。
    - 理论上保证了某些GANs能够收敛到纳什均衡。
    - 最重要的是，相比于其他生成模型，GANs产生的样本更好。（这一条是主观判断...）
  
- 缺点：
    - 训练GANs实际上是在找纳什均衡解，这比优化一个目标函数要困难。
    - GANs生成的图像比较sharp，也就是说，它倾向于生成相似的图像。作者在2016 NIPS tutorial中指出，这个缺陷与采用何种KL散度作为loss无关，而可能是与训练过程有关。详细的讨论可以参看参考文献2的3.2.5和5.1.1章节。PS：这是一个非常重要的问题，如果想深入理解GANs，请务必阅读原文详细了解。

##### AC-GAN
- 优点：
    - 在D的输出部分添加一个辅助的分类器来提高条件GAN的性能
    - 提出 Inception Accuracy 这种新的用于评判图像合成模型的标准
    - 引进MS-SSIM用于判断模型生成图片的多样性

- 缺点：部分类生成图像比较相似，可能是因为模型没有记忆，造成过拟合现象

##### CycleGAN
局限与讨论

虽然我们的方法在多种案例下，取得了令人信服的结果，但是这些结果并不都是一直那么好。图17 就展示了几个典型的失败案例。在包括了涉及颜色和纹理变形的任务上，与上面的许多报告提及的一样，我们的方法经常是成功的。我们还探索了需要几何变换的任务，但是收效甚微(limit success)。举例说明：狗→猫 转换的任务，对翻译的学习 退化为对输入的图片进行最小限度的转换。这可能是由于我们对生成器结构的选择造成的，我们生成器的架构是为了在外观更改上的任务上拥有更好的性能而量身定制的。处理更多和更加极端的变化，尤其是几何变换，是未来工作的重点问题。
训练集的分布特征也会造成一些案例的失败。例如，我们的方法在转换 马→斑马 的时候发生了错乱，因为我们的模型只在ImageNet 上训练了 野马和斑马 这两个类别，而没有包括人类骑马的图片。所以普京骑马的那一张，把普京变成斑马人了。
我们也发现在成对图片训练 和 非成对训练 之间存在无法消弭的差距。在一些案例里面，这个差距似乎特别难以消除，甚至不可能消除。为了消除（模型对数据理解上的）歧义，模型可能需要一些弱语义监督。集成的弱监督或者半监督数据也许能够造就更有力的翻译器，这些数据依然只会占完全监督系统中的一小部分。
尽管如此，在多种情况下，完全使用不成对的数据依然是足够可行的，我们应该使用。这篇论文拓展了“无监督”配置可能使用范围。

##### DCGAN
-优点：
    - 对于训练生成对抗网络，我们提出了一个更稳定的架构集合，并且我们给出证据，对于有监督学习和生成模型来说，对抗网络可以学习到好的图像表示。
-缺点：
    - 这里仍然存在一些模型不稳定的形式，我们注意到，随着模型训练的越长，他们有时会折叠一些滤波器的子集，造成单一震荡的模式。

##### DualGAN
- 优点：
    - 生成模型的收敛性好
    - 生成的样本质量高
    - 优化过程稳定性好
    - 任何地方都是可微的，方便求梯度
- 缺点
    - DualGAN可能会将像素映射到错误的标签，或将标签映射到错误的纹理/颜色上

##### InfoGAN
- 优点：
    -以无监督方式学习随机噪声空间下可解释的特征表示时，无需大量的额外计算成本

##### LSGAN
- 优点：
    - 生成图片质量比传统GAN高
    - 训练更稳定

##### SGAN
- 优点：
    - 提出将GANs进行拓展，允许其同时学习一个产生式模型和一个分类器。称为：Semi-Supervised GAN, or SGAN. 
    - 表明了 SGAN改善了分类性能。  
    - 表明 SGAN 可以明显的改善产生样本的质量和减少训练时间。 

***

学习资料:

- [深度学习中目标检测Object Detection的基础概念及常用方法](https://www.cnblogs.com/notesbyY/p/10986930.html) + [补充](https://blog.csdn.net/iwill323/article/details/126463487)

- [深度学习-图像-七重关卡](https://www.zhihu.com/question/41250817/answer/281946052)

- [One-stage object detection](https://machinethink.net/blog/object-detection/)

- [深入理解one-stage目标检测算法](https://zhuanlan.zhihu.com/p/61485202)

- [2018-GAN总结](https://blog.csdn.net/u010138055/article/details/94441812)