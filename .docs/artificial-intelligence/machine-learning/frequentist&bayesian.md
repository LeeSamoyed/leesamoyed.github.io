# 频率派&贝叶斯派

### 假设:

$X:data \rightarrow  X= (x_1,x_2,...,x_N)^T_{N*p} \quad\theta:parameter= \begin{gathered}\begin{pmatrix}x_{11} & x_{12} & ... & x_{1p} \\ x_{21} & x_{22} & ... & x_{2p}\\ ... & ... & ... & ...\\ x_{n1} & x_{n2} & ... & x_{np}\end{pmatrix}\end{gathered}$

$x \sim p(x|\theta)$

### 频率派：

$\theta$：未知变量，$X$：r.v，实际上关心的是数据，需要将未知常量$\theta$给估计出来，方法：$\theta_{MLE} = \arg\max\log P(X|\theta)$（其中l$\log$是为了简化计算）

### 贝叶斯派：

$\theta$：r.v，$\theta \sim p(\theta)$，其中$p(\theta)$称为先验，
利用贝叶斯定：$P(\theta | X) = \frac {P(X | \theta) \cdot P(\theta)} {P(X)}$，其中$P(\theta | X)$是后验，$P(X | \theta)$是似然，$P(\theta)$是先验，$P(X)$是一个积分（离散为连加）$\int_{\theta} P(X|\theta)P(\theta)d\theta$

MAP（最大后验概率估计）：$\theta_{MAP}=\arg\max _\theta P(\theta | X) = \arg\max_\theta P(X|\theta) \cdot p(\theta)$

![bayesian.png](/assets/images/artificial-intelligence/machine-learning/bayesian.png)
然而真正的贝叶斯估计：$p(\theta | X) = \frac {p(X|\theta) \cdot p(\theta)}{\int_{\theta} p(X|\theta)p(\theta)d\theta}$

求出最大后验概率->贝叶斯预测：$X$，假如来了新样本：$\mathop x \limits^ \sim$，预测问题就是求$p(\mathop x \limits^ \sim | X) = \int p(\mathop x \limits^ \sim , \theta | X)d\theta$（边缘概率）$= \int p(\mathop x \limits^ \sim | X)p(\theta | X)d\theta$（后验概率）

### 理解：

贝叶斯（求积分问题MCMC）->概率图模型：求积分：Monte、Carlo Method

频率派（优化问题）->统计机器学习：①模型 ②loss function ③算法 （解loss function）

***

[学习网址](https://www.bilibili.com/video/av70839977?p=1)