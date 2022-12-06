### 概念名词和问题：

- 激活函数：非线性化
   * Sigmoid：两端的饱和效应，梯度消失（解决“ReLU）
- 局部最优：随着神经网络的加深容易进入局部最优解（解决：无监督学习和微调）
- 大数据、GPU
- 卷积神经网络、循环神经网络、生成式对抗网络

### 物体检测技术：

- 区域选取 -> 特征提取 -> 特征分类
- 历程：
   1. RCNN：深度学习实现物体检测
   2. Fast RCNN：端到端的检测与卷积共享
   3. Faster RCNN：Anchor
   4. YOLO v1：Anchor Free
   5. SSD：多特征图
   6. FPN：特征金字塔（特征提取网络）
   7. Mask RCNN：实例分割
- IoU：

```python
def iou(boxA,boxB):
    # 上下左右
    left_max = max(boxA[0],boxB[0])
    top_max = max(boxA[1],boxB[1])
    right_min = min(boxA[2],boxB[2])
    bottom_min = min(boxA[3],boxB[3])
    # 重合
    inter = max(0,(right_min-left_max) * max(0,(bottom_min-top_max)))
    Sa = (boxA[2]-boxA[0]) * (boxA[3]-boxA[1])
    Sb = (boxB[2]-boxB[0]) * (boxB[3]-boxB[1])
    # iou
    union = Sa+Sb-inter
    iou = inter/union
    return iou
```

- mAP计算过程
- AP计算过程$\begin{equation*}

\begin{matrix} \int_{0}^{1} PdR\end{matrix}

\end{equation*}$

```python
for c in classes:
    # 通过类别作为关键字，得到每个类别的预测、标签及总标签数
    dects = det_boxes[c]
    gt_class = gt_boxes[c]
    npos = num_pos[c]
    # 利用得分作为关键字，对预测框按照得分从高到低排序
    
```

### 深度学习框架：

- PyTorch：
- TensorFlow
- MXNet
- keras
- Caffe
- Theano

