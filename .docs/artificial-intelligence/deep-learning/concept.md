# 概念

## 名词解释

### 损失函数：
表示的是模型预测的值与样本真实值之间的差距


### 经验风险：
所有样本损失函数所得结果的累加的平均值


### 误差：
- 近似误差：对现有训练集的训练误差
- 训练误差：测试集的测试误差


### 激活函数：
激活函数：激活函数使线性的结果非线性化。


### 神经元：
神经元又可以称为感知器。下图中圆圈即是神经元。

![concept-neurons](../../assets/images/artificial-intelligence/deep-learning/concept-neurons.png)

神经网络主要工作在隐层元这一块。

### 池化层（pooling）


- 关于池化层，最初接触的时候我在想这不就是 ![](https://cdn.nlark.com/yuque/0/2021/svg/358780/1626059650803-eb3f3c92-eeb4-4a00-ad61-fe7648e61c9b.svg#crop=0&crop=0&crop=1&crop=1&height=23&id=CQnEs&originHeight=23&originWidth=104&originalType=binary&ratio=1&rotation=0&showTitle=false&size=0&status=done&style=none&title=&width=104) 么，实际上如果读者有印象，最基础的那一张LeNet的结构框图上池化层的标注就是 ![](https://cdn.nlark.com/yuque/0/2021/svg/358780/1626059650855-bc2f263a-dbce-4deb-83de-aa89723af7f8.svg#crop=0&crop=0&crop=1&crop=1&height=23&id=xiAtC&originHeight=23&originWidth=104&originalType=binary&ratio=1&rotation=0&showTitle=false&size=0&status=done&style=none&title=&width=104).回忆一下在图像处理中,我们会出于什么样的理由会去使用 ![](https://cdn.nlark.com/yuque/0/2021/svg/358780/1626059650840-ca7df22a-1c51-4060-a5ca-d456165c4550.svg#crop=0&crop=0&crop=1&crop=1&height=23&id=hOTRV&originHeight=23&originWidth=104&originalType=binary&ratio=1&rotation=0&showTitle=false&size=0&status=done&style=none&title=&width=104) ,最直接的原因，我们需要一个更小尺寸的图像。或者我们需要不同尺度的信息，例如 SIFT里面就通过不断的下采样（插值算法）构建一个多尺度空间从而寻找不同尺度下的特征。

![concept-maxpool](../../assets/images/artificial-intelligence/deep-learning/concept-maxpool.png)

- 在深度学习，卷积神经网络中，我们使用池化层的原因也是同上（可以理解为换个说法）：

    - 降维（通过更小的特征图，更少的神经元表示数据的特征）通过池化我们可以提高网络的统计效率。例如上图，16个神经元变成了4个。
    - 近似的平移不变性（更大尺度的特征），轻微的扰动对池化的输出不产生影响，特别是 ![](https://cdn.nlark.com/yuque/0/2021/svg/358780/1626059650812-8683688a-eb55-4f3e-98e2-29a9ade01d12.svg#crop=0&crop=0&crop=1&crop=1&height=23&id=EZaf1&originHeight=23&originWidth=117&originalType=binary&ratio=1&rotation=0&showTitle=false&size=0&status=done&style=none&title=&width=117) .增加了网络的鲁棒性。例如上图左上角1改成4 并不影响池化的输出
    - 对于处理不同输入大小的图片具有重要作用。例如比较流行的GAP,在我们介绍全连接层后，我们会知道分类层的输入特征个数往往是确定的，所以我们有些时候只关心图像特征在全局尺度上的相对位置。这种情况下池化就变得不可或缺了。例如我们上图的输入变成6x6的图片，输出依然只需要2 x 2，在maxpooling下我们可以做到相对只关心某一个象限的最大值。

值得注意的是池化层的反向传播，我们前面介绍过，一个操作的反向传播往往肩负两个使命，保证 ![](https://cdn.nlark.com/yuque/0/2021/svg/358780/1626059650825-72508b78-58c7-411b-bfcd-1a45dc21965a.svg#crop=0&crop=0&crop=1&crop=1&height=21&id=HrszQ&originHeight=21&originWidth=9&originalType=binary&ratio=1&rotation=0&showTitle=false&size=0&status=done&style=none&title=&width=9) 的回传，求导自身参数。实际上在 ![](https://cdn.nlark.com/yuque/0/2021/svg/358780/1626059650828-de927ce0-e2be-4f48-9201-3eb2b10d3480.svg#crop=0&crop=0&crop=1&crop=1&height=23&id=XtLwE&originHeight=23&originWidth=72&originalType=binary&ratio=1&rotation=0&showTitle=false&size=0&status=done&style=none&title=&width=72) 中，我们可以看到，它是没有参与前向计算的参数的，所以我们只需要实现 ![](https://cdn.nlark.com/yuque/0/2021/svg/358780/1626059650835-bd2fa64d-27de-46d5-810e-2695085a1bf9.svg#crop=0&crop=0&crop=1&crop=1&height=54&id=AabuM&originHeight=54&originWidth=465&originalType=binary&ratio=1&rotation=0&showTitle=false&size=0&status=done&style=none&title=&width=465)


#### 全连接层（FullyConnect）

深度学习网络的一大特点是学习过程是端到端的，也就是说输入是一张图片，输出则是一个表达的信息，常见的是一个列向量，表征需求的的结果，例如分类信息，相对位置坐标等等。

就我们已经实现的组件而言，无论是卷积层还是池化层都是图片（with channels）输入，图片(with channels)输出，全连接层实现的就是将所谓图片的特征表示转化为向量，然后通过 ![](https://cdn.nlark.com/yuque/0/2021/svg/358780/1626059697564-d6e31557-a922-408d-b471-24696a6e139d.svg#crop=0&crop=0&crop=1&crop=1&height=23&id=j0tQz&originHeight=23&originWidth=104&originalType=binary&ratio=1&rotation=0&showTitle=false&size=0&status=done&style=none&title=&width=104) 把转化后向量再一次transform到我们需要的特征空间，也就是样本标记空间。而这个图片到向量的过程就是单纯的展开，用 ![](https://cdn.nlark.com/yuque/0/2021/svg/358780/1626059697511-0afa1623-4973-4575-be99-afab399e52bb.svg#crop=0&crop=0&crop=1&crop=1&height=26&id=BoPot&originHeight=26&originWidth=121&originalType=binary&ratio=1&rotation=0&showTitle=false&size=0&status=done&style=none&title=&width=121) 实现。所以
![](https://cdn.nlark.com/yuque/0/2021/svg/358780/1626059697534-32501ae3-07f5-4723-99cf-29ade526286c.svg#crop=0&crop=0&crop=1&crop=1&height=23&id=fJFWs&originHeight=23&originWidth=352&originalType=binary&ratio=1&rotation=0&showTitle=false&size=0&status=done&style=none&title=&width=352)

```python
import numpy as np
class FullyConnect(object):
    def __init__(self, shape, output_num=2):
        self.input_shape = shape
        self.batchsize = shape[0]
        input_len = reduce(lambda x, y: x * y, shape[1:])
        self.weights = np.random.standard_normal((input_len, output_num))/100
        self.bias = np.random.standard_normal(output_num)/100
        self.output_shape = [self.batchsize, output_num]
        self.w_gradient = np.zeros(self.weights.shape)
        self.b_gradient = np.zeros(self.bias.shape)
```

我们可以看到通过计算 self.input_len 得到 flatten 之后的向量长度，其余的步骤就和MLP一模一样，如何用Numpy实现MLP，我想看过上一篇MLP的反向传播的公式的读者应该没有什么压力，都是用 ![](https://cdn.nlark.com/yuque/0/2021/svg/358780/1626059697550-369d6157-32a2-425d-ac38-ff636e3fc47d.svg#crop=0&crop=0&crop=1&crop=1&height=26&id=k62gw&originHeight=26&originWidth=77&originalType=binary&ratio=1&rotation=0&showTitle=false&size=0&status=done&style=none&title=&width=77) 实现的。（如果有压力，请自己画出来看一下每个节点的贡献。）

前向传播： ![](https://cdn.nlark.com/yuque/0/2021/svg/358780/1626059697612-3c748a44-aba0-40c1-80d5-9861d6410523.svg#crop=0&crop=0&crop=1&crop=1&height=21&id=t8IA4&originHeight=21&originWidth=138&originalType=binary&ratio=1&rotation=0&showTitle=false&size=0&status=done&style=none&title=&width=138)

反向传播： ![](https://cdn.nlark.com/yuque/0/2021/svg/358780/1626059697586-ede67bad-17db-438d-ae60-342ee4f72480.svg#crop=0&crop=0&crop=1&crop=1&height=27&id=kXc8g&originHeight=27&originWidth=132&originalType=binary&ratio=1&rotation=0&showTitle=false&size=0&status=done&style=none&title=&width=132)

参数求导：![](https://cdn.nlark.com/yuque/0/2021/svg/358780/1626059697640-c5186fe8-7f40-431d-89e2-f25afecf9b0b.svg#crop=0&crop=0&crop=1&crop=1&height=50&id=YGd12&originHeight=50&originWidth=152&originalType=binary&ratio=1&rotation=0&showTitle=false&size=0&status=done&style=none&title=&width=152) ,代码里实现时batch的形式， ![](https://cdn.nlark.com/yuque/0/2021/svg/358780/1626059698535-751e9063-3ccb-4933-b0c4-90193733ae0c.svg#crop=0&crop=0&crop=1&crop=1&height=60&id=FtJc4&originHeight=60&originWidth=233&originalType=binary&ratio=1&rotation=0&showTitle=false&size=0&status=done&style=none&title=&width=233)

```python
def forward(self, x):
        self.x = x.reshape([self.batchsize, -1])
        output = np.dot(self.x, self.weights)+self.bias
        return output
    def backward(self, eta):
        for i in range(eta.shape[0]):
            col_x = self.x[i][:, np.newaxis]
            eta_i = eta[i][:, np.newaxis].T
            self.w_gradient += np.dot(col_x, eta_i)
            self.b_gradient += eta_i.reshape(self.bias.shape)
        next_eta = np.dot(eta, self.weights.T)
        next_eta = np.reshape(next_eta, self.input_shape)
        return next_eta
```

值得提一下的是，现在全连接层实际上已经不是特别必须的了，比较流行的是用 ![](https://cdn.nlark.com/yuque/0/2021/svg/358780/1626059697569-8b484c72-3b77-46ac-a010-5435fd6f26bc.svg#crop=0&crop=0&crop=1&crop=1&height=23&id=MaSqX&originHeight=23&originWidth=212&originalType=binary&ratio=1&rotation=0&showTitle=false&size=0&status=done&style=none&title=&width=212) 取代 ![](https://cdn.nlark.com/yuque/0/2021/svg/358780/1626059697568-6e43511a-d7fb-46eb-be18-0d601282ef52.svg#crop=0&crop=0&crop=1&crop=1&height=23&id=jpnLB&originHeight=23&originWidth=66&originalType=binary&ratio=1&rotation=0&showTitle=false&size=0&status=done&style=none&title=&width=66) 的过程，因为早期这个 ![](https://cdn.nlark.com/yuque/0/2021/svg/358780/1626059697662-dbab4287-a83d-42e3-be4c-70ebc88ec0e2.svg#crop=0&crop=0&crop=1&crop=1&height=23&id=EbdQm&originHeight=23&originWidth=66&originalType=binary&ratio=1&rotation=0&showTitle=false&size=0&status=done&style=none&title=&width=66) 出来的向量太大，导致接下来的 ![](https://cdn.nlark.com/yuque/0/2021/svg/358780/1626059697584-b5f0dbb3-a243-4f12-aa15-afa4b6b5cc99.svg#crop=0&crop=0&crop=1&crop=1&height=23&id=o1LZN&originHeight=23&originWidth=104&originalType=binary&ratio=1&rotation=0&showTitle=false&size=0&status=done&style=none&title=&width=104) 参数太多，过于冗余。所以直接将每一个channel的feature map全局池化降维到一个点得到一个channels长度的列向量，再应用MLP进行维度变换。

## 人工神经网络和生物神经网络

### 生物神经网络
![concept-artificial&biological-0](../../assets/images/artificial-intelligence/deep-learning/concept-artificial&biological-0.png)

### 人工神经网络
![concept-artificial&biological-1](../../assets/images/artificial-intelligence/deep-learning/concept-artificial&biological-1.png)

- 主要区别：不会自行产生

- 概念:
    - 正向传播和误差反向传递（反向传播）

    ![concept-artificial&biological-2](../../assets/images/artificial-intelligence/deep-learning/concept-artificial&biological-2.png)

    - 生物神经网络会通过刺激产生新的连接，而人工神经网络则是通过训练修正的过程

## 什么是神经网络

### 理解
![concept-neural-networks-0](../../assets/images/artificial-intelligence/deep-learning/concept-neural-networks-0.png)

### 可视化神经网络
- 计算机主要以01区分（以数字加工处理获得另一串数字，通过这样获得数字含有的意义）

![concept-neural-networks-1](../../assets/images/artificial-intelligence/deep-learning/concept-neural-networks-1.png)

![concept-neural-networks-2](../../assets/images/artificial-intelligence/deep-learning/concept-neural-networks-2.png)

### 具体
- 大量数据进行学习和训练


## 反向传播算法BP
### 正向传播：

1. 我们拥有的是第一层的激活值
2. 我们通过权重（第一次是随机权重）、偏差和第一层激活值能够计算得到第二层激活值
3. 同理得到最后一层的激活值
4. 依据激活值判断我们应该激活哪一个结果


### 反向传播：

1. 我们通过正向传播能够最终获得最后一层的激活值，并于我们想要激活的结果进行比较（损失函数）
2. 当然由于激活值大小的不同，我们对于每一个前一层激活值对后一层激活值影响的性价比也就不同
3. 那么我们就希望通过某一个方法，算出针对每一个权重进行调整的数值（结果的每一个神经元都由前一个进行影响，我们统计好每一个结果神经元想要它前一层神经元调整的数值最后总和就是我们对前一层神经元调整的方向）
   1. 对于激活值的调整
   2. 对于权重的调整
   3. 对于偏差的调整
   4. 在我们的理解中我们对于激活值的调整一般不会进行实现（因为第一层给出的激活值一般是确定的），通常我们会考虑对于权重进行调整（偏差只是代表我们是否激活，调整偏差更多是调整激活的难易程度）
   5. 方法：**梯度下降（导数修正）**
4. 同理得到第一层权重的调整


### 如何修正：

1. 我们最终能够获得损失，利用损失对于某一个权重进行偏导数的计算，我们就可以获得，这个权重，或者说参数，“下降”的方向，利用这个方向进行修正；
2. 数学算式：$\frac{\partial C_0}{\partial w^{(L)}}$ 这里的 $L$ 指神经网络的层数
   1. $\partial w^{(L)}$ 看作对 $w$ 的微小扰动
   2. $\partial C_0$ 看作“改变 $w$ 对 $C$ 的值造成的变化”
3. 多元函数偏导的链式法则：
   1. $C_0 = (a^{(L)}-y)^2 \quad z^{(L)}=w^{(L)}a^{(L-1)}+b^{(L)} \quad a^{(L)}=\sigma(z^{(L)})$
   2. $\frac{\partial C_0}{\partial w^{(L)}} = \frac{\partial z^{(L)}}{\partial w^{(L)}}\frac{\partial a^{(L)}}{\partial z^{(L)}}\frac{\partial C_0}{\partial a^{(L)}}$
   3. 由上述式子可以计算出$C$对$w^{(L)}$的微小变化的敏感性
   4. $\frac{\partial C_0}{\partial a^{(L)}}=2(a^{(L)}-y)$    $\frac{\partial a^{(L)}}{\partial z^{(L)}} = \sigma'(z^{(L)})$    $\frac{\partial z^{(L)}}{\partial w^{(L)}}=a^{(L-1)}$
4. 当然除了对权重偏导也可以对偏置偏导（当然偏置的偏导就是1）
5. 直接上对于多层：（ $j$ 是当前层神经元； $k$ 是上一层神经元）
   $C_0 =\mathop \Sigma \limits_{j=0}\limits^{n_L-1}(a_j^{(L)}-y_i)^2$    $z^{(L)}_j=w^{(L)}_{j0}a^{(L-1)}_0+w^{(L)}_{j1}a^{(L-1)}_1+...+b^{(L)}_j$    $a^{(L)}_j=\sigma(z^{(L)}_j)$ $\frac{\partial C_0}{\partial w_{jk}^{(L)}} = \frac{\partial z_j^{(L)}}{\partial w_{jk}^{(L)}}\frac{\partial a_j^{(L)}}{\partial z_j^{(L)}}\frac{\partial C_0}{\partial a_j^{(L)}}$；对于上一层的某一个神经元：$\frac{\partial C_0}{\partial a_{k}^{(L)}} = \mathop \Sigma \limits_{j=0} \limits^{n_L-1} \frac{\partial z_j^{(L)}}{\partial a_{k}^{(L)}}\frac{\partial a_j^{(L)}}{\partial z_j^{(L)}}\frac{\partial C_0}{\partial a_j^{(L)}}$
6. 以此类推直到第一层神经元就能够更新权重（所有的神经元激活值都由上一层计算得来，那么一直传到第一层，在已知激活值的情况下就能更新权重，更改第二层激活值，再由第二层激活值继续更新权重，同理继续向下一层修正直到更改最后一层激活值，由能计算新的损失（更新完权重；这个时候就是前向了））

## 梯度下降法的理解：

- 公式：$f(x+1) = f(x) - f'(x)×lr$
- 其中$f(x)$是当前的值
- $lr$是给出的学习率

## 黑盒

### 理解

通俗理解：仍以黑盒一个东西，通过某个方式，获得另一个东西，那个方式不知道，就成为**黑盒**

# 神经网络拆分

1. 输入端（输入）
2. 黑盒（加工）
3. 输出端（输出）
4. 把黑盒理解为将一种代表特征变成另一种代表特征（黑盒开灯）

![concept-black-box-0](../../assets/images/artificial-intelligence/deep-learning/concept-black-box-0.png)

5. 举个例子：**（区域划分，代表特征，人类看不懂计算机能看懂）**

![concept-black-box-1](../../assets/images/artificial-intelligence/deep-learning/concept-black-box-1.png)

6. 黑盒开灯的理解：迁移学习

![concept-black-box-2](../../assets/images/artificial-intelligence/deep-learning/concept-black-box-2.png)

![concept-black-box-3](../../assets/images/artificial-intelligence/deep-learning/concept-black-box-3.png)

***

学习资料:

- [莫烦](https://space.bilibili.com/243821484?spm_id_from=333.337.0.0)