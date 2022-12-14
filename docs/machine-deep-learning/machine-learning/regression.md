# 回归

## 回归综述

### 什么是回归分析：

在统计学中，回归分析（regression analysis)指的是确定两种或两种以上变量间相互依赖的定量关系的一种统计分析方法。回归分析按照涉及的变量的多少，分为一元回归和多元回归分析；按照因变量的多少，可分为简单回归分析和多重回归分析；按照自变量和因变量之间的关系类型，可分为线性回归分析和非线性回归分析。
在大数据分析中，回归分析是一种预测性的建模技术，它研究的是因变量（目标）和自变量（预测器）之间的关系。这种技术通常用于预测分析，时间序列模型以及发现变量之间的因果关系。例如，司机的鲁莽驾驶与道路交通事故数量之间的关系，最好的研究方法就是回归。

### 回归分析主要内容：

- 从一组数据出发，确定某些变量之间的定量关系式，即建立数学模型并估计其中的未知参数。估计参数的常用方法是最小二乘法。
- 对这些关系式的可信程度进行检验。
- 在许多自变量共同影响着一个因变量的关系中，判断哪个（或哪些）自变量的影响是显著的，哪些自变量的影响是不显著的，将影响显著的自变量加入模型中，而剔除影响不显著的变量，通常用逐步回归、向前回归和向后回归等方法。
- 利用所求的关系式对某一生产过程进行预测或控制。回归分析的应用是非常广泛的，统计软件包使各种回归方法计算十分方便。

在回归分析中，把变量分为两类。一类是因变量，它们通常是实际问题中所关心的一类指标，通常用Y表示；而影响因变量取值的的另一类变量称为自变量，用X来表示。

### 回归分析主要研究问题：

- 确定Y与X间的定量关系表达式，这种表达式称为回归方程；
- 对求得的回归方程的可信度进行检验；
- 判断自变量X对因变量Y有无影响；
- 利用所求得的回归方程进行预测和控制。

### 应用层面：

相关分析研究的是现象之间是否相关、相关的方向和密切程度，一般不区别自变量或因变量。而回归分析则要分析现象之间相关的具体形式，确定其因果关系，并用数学模型来表现其具体关系。比如说，从相关分析中可以得知“质量”和“用户满意度”变量密切相关，但是这两个变量之间到底是哪个变量受哪个变量的影响，影响程度如何，则需要通过回归分析方法来确定。
一般来说，回归分析是通过规定因变量和自变量来确定变量之间的因果关系，建立回归模型，并根据实测数据来求解模型的各个参数，然后评价回归模型是否能够很好的拟合实测数据；如果能够很好的拟合，则可以根据自变量作进一步预测。

例如:

如果要研究质量和用户满意度之间的因果关系，从实践意义上讲，产品质量会影响用户的满意情况，因此设用户满意度为因变量，记为Y；质量为自变量，记为X。通常可以建立下面的线性关系： Y=A+BX+§
式中：A和B为待定参数，A为回归直线的截距；B为回归直线的斜率，表示X变化一个单位时，Y的平均变化情况；§为依赖于用户满意度的随机误差项。
对于经验回归方程： y=0.857+0.836x
回归直线在y轴上的截距为0.857、斜率0.836，即质量每提高一分，用户满意度平均上升0.836分；或者说质量每提高1分对用户满意度的贡献是0.836分。

上面所示的例子是简单的一个自变量的线性回归问题，在数据分析的时候，也可以将此推广到多个自变量的多元回归，具体的回归过程和意义请参考相关的统计学书籍。此外，在SPSS的结果输出里，还可以汇报R2，F检验值和T检验值。R2又称为方程的确定性系数（coefficient of determination），表示方程中变量X对Y的解释程度。R2取值在0到1之间，越接近1，表明方程中X对Y的解释能力越强。通常将R2乘以100%来表示回归方程解释Y变化的百分比。F检验是通过方差分析表输出的，通过显著性水平（significance level）检验回归方程的线性关系是否显著。一般来说，显著性水平在0.05以上，均有意义。当F检验通过时，意味着方程中至少有一个回归系数是显著的，但是并不一定所有的回归系数都是显著的，这样就需要通过T检验来验证回归系数的显著性。同样地，T检验可以通过显著性水平或查表来确定。在上面所示的例子中，各参数的意义如下表所示。

## 线性回归

### 最小二乘法（矩阵表达；几何意义）：

##### 线性拟合是用线去拟合样本点：

![least -square-method.png](/assets/images/machine-deep-learning/machine-learning/least -square-method.png)

假设：$D=\{(x_1,y_1),(x_2,y_2),...,(x_N,y_N)\}$

其中：$x_i \epsilon R^p$ ，$y_i \epsilon R$ ，$i \epsilon 1,2,...,N$

有：$X = (x_1,x_2,...,x_N)^T =\begin{gathered}\begin{pmatrix}x_1^T\\x_2^T\\...\\x_N^T\end{pmatrix}\end{gathered} =\begin{gathered}\begin{pmatrix} x_{11} & x_{12} & ... & x_{1p}\\x_{21} & x_{22} & ... & x_{2p}\\... & ... &... & ..\\x_{N1} & x_{N2} & ... & x_{Np}\end{pmatrix}_{N×p}\end{gathered}$

事实上要拟合的曲线：$f(w) = w^Tx+w_0x_0$

其中：$W=\begin{gathered}\begin{pmatrix} w_1\\w_2\\...\\w_p\end{pmatrix}\end{gathered}$（在这里 $x_0=1$ 所以我们更倾向于把它写入 $W^Tx$ ）

##### 最小二乘估计：

最小二乘法定义：$L(w)= \mathop\Sigma\limits_{i=1}\limits^{N}w^T||x_i-y_i||^2=\mathop\Sigma\limits_{i=1}\limits^{N}w^T(x_i-y_i)^2=(w^Tx_1-y_1,w^Tx_2-y_2,...,w^Tx_N-y_N)=\begin{gathered}\begin{pmatrix} w^Tx_1-y_1\\w^Tx_2-y_2\\...\\w^Tx_N-y_N\end{pmatrix}\end{gathered}$

其中：  

$(w^Tx_1-y_1,w^Tx_2-y_2,...,w^Tx_N-y_N)\\=(w^Tx_1,w^Tx_2,...,w^Tx_N)-(y_1,y_2,...,y_n)\\=w^T(x_1,x_2,...,x_N)-(y_1,y_2,...,y_N)\\=W^TX^T-Y^T$

得到：

$L(W)=(W^TX^T-Y^T)(WX-Y)\\=W^TX^TXW-W^TX^TY-Y^TXW+Y^TY\\=W^TX^TXW-2W^TX^TY+Y^TY$

得到：

$\hat w = \arg \min L(W)$

得到：

$\frac{\partial L(w)}{\partial w} = 2X^TXW - 2X^TY = 0$

所以：

$X^TXW=X^TY\\W=(X^TX)^{-1}X^TY$

注意：$(X^TX)^-1X^T$ 称为伪逆记为 $X^+$

---

第一个几何解释：距离和。

另一个几何解释：对于要拟合的直线我们从另一个角度看：$f(W)=W^Tx=x^T\beta$，把$x$想象为$p$维度的一个系数：$\begin{gathered}\begin{pmatrix} x_{11} & x_{12} & ... & x_{1N}\\x_{21} & x_{22} & ... & x_{2N}\\... & ... &... & ...\\x_{n1} & x_{n2} & ... & x_{NN}\end{pmatrix}_{N×p}\end{gathered}$，横着看就是 $N$ 样本点，竖着看就是一个 $p$ 维，由 $p$ 可以形成一个 $p$ 维空间（一般 $N>p$ ）， $Y$ 形成的向量一般不在 $p$ 维空间（存在噪声之类的），最小二乘法就是在 $p$ 维空间中找到一条线，让 $Y$ 距离线（平面最近），那么很显然就是投影。  
既然是投影就会垂直于 $p$ 维空间，就会垂直于每一个向量，就有 $X^T(Y-X\beta)=0$                 

显而易见的是，结果和我们之前推导的结果是一样的，所以从这个角度就很好推证。   

这个就是把误差看成每个维度。


### 最小二乘法-概率角度：

概率视角：

假设：$D=\{(x_1,y_1),(x_2,y_2),...,(x_N,y_N)\}$

其中：$x_i \epsilon R^p$ ，$y_i \epsilon R$ ，$i \epsilon 1,2,...,N$

有：$X = (x_1,x_2,...,x_N)^T =\begin{gathered}\begin{pmatrix}x_1^T\\x_2^T\\...\\x_N^T\end{pmatrix}\end{gathered} =\begin{gathered}\begin{pmatrix} x_{11} & x_{12} & ... & x_{1p}\\x_{21} & x_{22} & ... & x_{2p}\\... & ... &... & ...\\x_{N1} & x_{N2} & ... & x_{Np}\end{pmatrix}_{N×p}\end{gathered}$, $Y=\begin{gathered}\begin{pmatrix}y_1^T\\y_2^T\\...\\y_N^T\end{pmatrix}\end{gathered}\quad$, $x$：样本    $y$：值

最小二乘估计：

$L(w)=\mathop \Sigma \limits_{i=1} \limits^{N}||w^Tx_i-y_i||^2_2$

$\hat{W}=\arg\min \limits_{w}L(W)$

$\hat{W}=(X^TX)^{-1}X^TY$ 

假设存在噪声：

$\varepsilon \sim (0,\sigma^2)$

$y=f(W)+\varepsilon$

$f(W)=W^Tx$

$y=W^Tx+\varepsilon$

$y|x;W \sim N(W^Tx,\sigma^2) \rightarrow P(y|x;w)=\frac{1}{\sqrt{2\pi}\sigma}\exp\{-\frac{(y-W^Tx)^2}{2\sigma^2}\}$

$MLE:\mathcal{L}(W)=\log P(Y|X;W)=\log \mathop\Pi\limits_{i=1}\limits^NP(y_i|x_i;W)=\mathop \Sigma \limits_{i=1}\limits^N\log P(y_i|x_i;W)\\=\mathop \Sigma \limits_{i=1}\limits^N\log \frac{1}{\sqrt{2\pi}\sigma}+\log \exp\{-\frac{(y-W^Tx)^2}{2\sigma^2}\}\\=\mathop \Sigma \limits_{i=1}\limits^N(\log \frac{1}{\sqrt{2\pi}\sigma}\cdot - \cdot -\frac{1}{2\sigma^2}(y-W^Tx)^2)$

$\hat{W}=\arg\max \limits_{W}\mathcal{L}(W)\\ =\arg\max\limits_{W}-\frac{1}{2\sigma^2}(y-W^Tx)^2\\ =\arg\min\limits_{W}(y_i-W^Tx_i)^2$

和最小二乘估计的$L(W)$一样

$LSE \Leftrightarrow MLE$（noise is Gaussian Dist）

### 正则化-岭回归-频率角度：

Loss Function：$L(w)=\mathop \Sigma \limits_{i=1} \limits^{N}||w^Tx_i-y_i||^2_2$  

$\hat{W}=(X^TX)^{-1}X^TY$

$X_{N×p}$，$N$个样本，$x_i \epsilon R^p$（一般$N \gg p$），如果样本纬度高，样本量少容易造成过拟合

过拟合$\rightarrow$
    - 加数据
    - 特征选择/特征提取
    - 正则化

正则化是对对目标函数的约束

正则化框架：$\arg\min[L(w)+\lambda P(w)]$（loss+惩罚）

L1（一范式）Lasso，$P(W)=||W||_1$

L2（二范式）：Ridge（岭回归），$P(W)=||W||_2=W^TW$（岭回归全称：权值衰减）

L2对应的函数：

$\begin{gathered} \begin{matrix} J(W)= \underbrace{ \mathop \Sigma \limits_{i=1} \limits^{N}||w^Tx_i-y_i||^2_2 } + \lambda W^TW \\ \begin{pmatrix} W^Tx_1-y_1 & W^Tx_2-y_2  & ... & W^Tx_N-y_N \end{pmatrix} \\ \begin{pmatrix} W^Tx_1 & W^Tx_2  & ... & W^Tx_N \end{pmatrix}- \begin{pmatrix} y_1 & y_2  & ... & y_N \end{pmatrix} \\ W^T\begin{pmatrix} x_1 & x_2  & ... & x_N \end{pmatrix}- \begin{pmatrix} y_1 & y_2  & ... & y_N \end{pmatrix} \end{matrix} \end{gathered} \\(W^T+X^T-Y^T)(XW-Y) \\ = (W^T+X^T-Y^T)(XW-Y)+\lambda W^TW \\ =W^TX^TXW-2W^TX^TY+Y^TY+\lambda W^TW \\ =W^T(X^TX+\lambda I)W-2W^TX^TY+Y^TY$

$\hat{W}=\arg\min J(W)$

$\frac{\partial J(W)}{\partial W}=2(X^TX+\lambda I)W - 2X^TY=0$

$\hat{W}=(X^TX+\lambda I)^{-1}X^TY$


### 正则化-岭回归-贝叶斯角度：

频率角度：

![ridge-regression-0.png](/assets/images/machine-deep-learning/machine-learning/ridge-regression-0.png)

贝叶斯角度：

先验：$W \sim N(0,\sigma_0^2)$（此时$W$不再是常数）

后验：$p(W|y)=\frac{p(y|W)\cdot p(W)}{p(y)}$

$p(y|W)=\frac{1}{\sqrt{2\pi}\sigma}\exp\{-\frac{(y-W^Tx)^2}{2\sigma^2}\}$    $p(W)=\frac{1}{\sqrt{2\pi}\sigma_0}\exp\{-\frac{||W||^2}{2\sigma_0^2}\}$

$p(y|W)\cdot p(W)=\frac{1}{\sqrt{2\pi}\sigma} \cdot \frac{1}{\sqrt{2\pi}\sigma_0} \cdot \exp\{-\frac{(y-W^Tx)^2}{2\sigma^2}-\frac{||W||^2}{2\sigma_0^2}\}$

$MAP:\hat{W}=\arg \max \limits_{W} p(w|y) =\arg \max p(y|W) \cdot p(W)\\ =\arg \max \log [p(y|W) \cdot p(W)] \\ =\arg \max \limits_{W} \log [\frac{1}{\sqrt{2\pi}\sigma} \cdot \frac{1}{\sqrt{2\pi \sigma_0}]+\log\exp\{-\frac{(y-W^Tx)^2}{2\sigma^2}-\frac{||W||^2}{2\sigma_0^2}\}$

这里$\sigma$和$\sigma_0$是我设置的，本质上是超参数，但是这里可以看做常数

$=\arg \min \limits_{W}(-\frac{(y-W^Tx)^2}{2\sigma^2}-\frac{||W||^2}{2\sigma_0^2})\\=\arg\min(\frac{1}{2}(y-W^Tx)^2+\frac{\sigma^2}{\sigma_0^2||w||^2_2})$

这里省略了$\mathop \Sigma \limits_{i=1} \limits^{N}$完全写出来如下：

$\hat{W}=\arg\min\mathop \Sigma \limits_{i=1} \limits^{N}(\frac{1}{2}(y_i -W^Tx_i)^2+\frac{\sigma^2}{\sigma_0^2||w||^2_2})$

和$J(W)$一样 

![ridge-regression-1.png](/assets/images/machine-deep-learning/machine-learning/ridge-regression-1.png)

Regularized$LSE \Leftrightarrow MAP$（noise为Gaussian Dist）（prior也是GD）

线性回归：
    - 线性    
    - 全局性    
    - 数据未加工

## 广义线性模型
- 目的：解决非线性问题。
- 在原始线性模型的基础上加入一个链接函数（Link Function，或者说联系函数），有点类似于嵌套，例如对等式先取对数（这样就造出来一个新的$Y$），这样就能使得模型拥有拟合非线性数据的能力。、
- $Y = g^{-1}(\hat W^{T} \cdot \hat x )$