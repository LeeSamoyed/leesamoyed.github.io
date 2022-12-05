# Decoupling - 解耦
### 为什么要解耦

思考一下这样的场景：

你需要设计了一个修改密码的方法，因此你写下了 **"find_account_by_userid"** 和 **"update_password_by_account"** 方法。

某一天你又发现你需要设计修改用户名的方法，因此你写下了 **"find_account_by_userid"** 和 **"update_username_by_account"** 方法。

长期完成这样的重复工作之后，你发现你每设计一个新的方法都需要完全重写代码。

现在，思考一下这样一个问题：这两个方法是否可以进行整合？

你只需要将接口进行原子化即可

原子化的意思就是指，将所有功能都会公用的方法写成原子接口，最后由数个原子接口构成你最后所需要的方法。

因此，耦合就是指每个 **“大方法”** 中所包含的非公用（本来应该是公共的）接口太多（且大多由于在一开始设计时候是自己使用，所以没有暴露出来）

这样的行为导致了如果你要修改某一个功能或者新增功能的时候没法调用之前的工作

同时如果 **“大方法”** 中的 **“小方法”** 也有同样的问题，就会导致整个系统相互依赖，无法修改

解耦，一方面是指重构，另一方面也是希望在设计系统开始的时候就避免上述的问题

***

Consider about this scenario.

You designed a function to change the password. And you write the code by sequence.

So, you write **"find_account_by_userid"** and **"update_password_by_account"**. (This is just a simplified process)

One day, you find that you have to write another function to change the username, so you do the same thing like before you have did. You write the **"find_account_by_userid"** and **"update_username_by_account"**.

One day, after you write many functions like above, you find that for every new requirement you have to completely rewrite the duplicated code. It's very troublesome.

Now, think about a question, Can the two function be integrated?

The answer is yes, you can just write common methods that may be used in the future as atomic interface.

Make all functions consist of many atomic interfaces. This is the system decoupling in my understanding.

### 详细资料补充：

[百度定义](https://baike.baidu.com/item/%E7%B3%BB%E7%BB%9F%E8%80%A6%E5%90%88/6230517)

[知乎解析](https://zhuanlan.zhihu.com/p/112580655)

### 八股文：
