# 自然语言处理

### Transformer

[Transformer](https://www.yuque.com/office/yuque/0/2022/pdf/358780/1647322266078-36ab9bfa-33fa-4cf3-9509-e26621e0ca21.pdf?from=https%3A%2F%2Fwww.yuque.com%2Fleesamoyed%2Fbvsayi%2Flt69v8)

### Seq2Seq

最早的任务：
语言翻译任务：中文英文互相翻译，给定一个原句子，自动翻译为目标语言的句子（两个句子可以长度不同）
架构：
encoder、decoder架构
简单说：给定一个句子，对其信息进行压缩，在解压的一个过程
具体：
- 编码器是一个RNN，解码器使用另一个RNN。
  1. 首先第一个RNN对状态进行记录，并将最后一个隐藏状态传递给解码器。
    * 注意：双向RNN经常用于encoder，因为可以encoder基本可以看完整个句子，这使得在encoder的时候既可以正向看，也可以反向看
    * 注意：在语言里面之所以可以保持长度不一样，是因为他有一个标注作为停止，例如 我在学习。 这个"。"其实就是一个停止，RNN有一个特点就是最后一个状态（当然其他的也有，这里只是举例RNN），那么当最后一个状态是"。"时，这个句子就会停止翻译或者停止encoder。因为长度可以不唯一。（输入也是）按着时刻走到停就行。
  2. encoder把最后时刻的隐藏状态和输入句子的embedding进行组合作为decoder的输入，既（编码器其实不需要输出，对于Seq2Seq模型，它只要拿到RNN最后一个状态即可）
  3. 在decoder的时候，记得它是有真实的输入的，因此并不担心前一个翻译错误。（注意观察训练和推理时encoder的不同之处）
    ![natural-language-processing-seq2seq-endocer-decoder](/assets/images/machine-deep-learning/deep-learning/natural-language-processing-seq2seq-endocer-decoder.png)
  4. BLEU
    ![natural-language-processing-seq2seq-bleu](/assets/images/machine-deep-learning/deep-learning/natural-language-processing-seq2seq-bleu.png)

***

学习资料:
- [李沐Transformer](https://www.bilibili.com/video/BV1pu411o7BE/?spm_id_from=333.337.search-card.all.click)
- [李沐Seq2Seq](https://www.bilibili.com/video/BV16g411L7FG/?spm_id_from=333.999.0.0&vd_source=a56307ef6c7054461a8406ad95b5014e)