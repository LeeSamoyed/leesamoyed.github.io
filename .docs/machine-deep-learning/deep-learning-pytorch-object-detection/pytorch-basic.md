# Pytorch基础

### 基本数据：Tensor

- Tensor数据类型：
   * 7种CPU、8种GPU
      - 32位浮点数
      - 64位浮点数
      - 16位半精度浮点数（CPU无）
      - 8位无符号整型
      - 8位有符号整型
      - 16位有符号整型
      - 32位有符号整型
      - 64位有符号整型
   * type(new type)、type_as()、int()
- Tensor的创建与维度查看：
   * torch.Tensor  ——  参数为Tensor维度大小
   * torch.ones()  ——  所有元素为1
   * torch.eye()  ——  对角元素为1
   * torch.zeros()  ——  所有元素为0
   * torch.randn()  ——  随机矩阵
   * torch.arange(start, end, step) ——  从start到end，间隔为step
   * torch.linspace(start, end, steps) ——  从start到end，份数为steps
- Tensor的组合与分块：
   * torch.cat()  ——  拼接  ——  2*2拼接2*2变成4*2
   * torch.stack()  ——  新增  ——  2*2拼接2*2变成2*2*2
   * torch.chunk()  ——  维度均分  ——  均分为...份
   * torch.split()  ——  维度大小  ——  均分为大小为...的...份
- Tensor的索引与变形：
   * 元素返回与坐标返回
   * torch.where()  ——  条件满足与否返回（满足为1，不满足为0）
   * torch.clamp()  ——  对Tensor进行加紧（小于min的变为min，大于max的变为max，其余保持原样）
   * 变形操作：
      - view()、resize()、reshape()  ——  不改变数据改变Tensor形状
      - transpose()、permute()  ——  指定的两个维度的元素转置
         * transpose()  ——  转置
         * permute()  ——  重新排序
      - squeeze()、unsqueeze()  ——  增减维度（去除为1的维度和指定的维度size变为1）
      - expand()、expand_as()  ——  将size为1的维度复制扩展为指定大小
- Tensor的排序与取极值：
   * torch.sort()
   * torch.abs()
   * ...
- Tensor的自动广播机制与向量化：
   * 自动广播机制：不同形状的Tensor进行计算时，可自动扩展到较大的相同形状，再进行计算
   * 向量化操作：是指可以在同一时间进行批量地并行运算
- Tensor内存共享：
   * 使用Tensor初始化Tensor
   * 原地操作符：对于一些操作通过加后缀"_"实现了原地操作，如add_()和resize_()等，这种操作只要被执行，本身的Tensor则会被改变
   * Tensor与Numpy转换

### Autograd与计算图

### 神经网络工具箱torch.nn

### 模型处理

### 数据处理