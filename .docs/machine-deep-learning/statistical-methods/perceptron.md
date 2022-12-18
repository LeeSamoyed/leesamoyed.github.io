# 感知机

### 感激之模型：

1. 寻找一个分离超平面能够将正实例点和负实例点完全正确分开


### 损失函数：

- 函数：$f(x)=sign(w \cdot x+b)$
- 损失函数：$-\frac{1}{||w||} \mathop \Sigma \limits_{x_i \epsilon M}y_i(w\cdot x_i+b)$


### 原理：

- 采用随机梯度下降方法，化解为最优化问题

