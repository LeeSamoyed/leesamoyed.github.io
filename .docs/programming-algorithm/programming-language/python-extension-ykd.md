# Python基础扩展 优课达

## Python基础

### print
##### 单行print

- print 双引号和单引号的使用规则
   - 普通字符串推荐使用单引号

```python
print('欢迎观看LeeSamoyed语雀')
```

- 如果内容有双引号，则外部使用单引号

```python
print('欢迎观看"LeeSamoyed语雀"')
```

- 如果内容又单引号，则外部使用双引号

```python
print("欢迎观看'LeeSamoyed语雀'")
```

- 如果内容既有单引号，又有双引号，为了和外面的引号区分，则需要用到转义字符反斜杠\

```python
print('欢迎\'观看\'LeeSamoyed"语雀"')
```

##### 多行print

```python
print('''

文字内容

''')

print('''
                    |
                    |
                    A
                  _/X\_
                  \/X\/
                   |V|
                   |A|
                   |V|
                  /XXX\\
                  |\/\|
                  |/\/|
                  |\/\|
                  |/\/|
                  |\/\|
                  |/\/|
                 IIIIIII
                 |\/_\/|
                /\// \\/\\
                |/|   |\|
               /\X/___\X/\\
              IIIIIIIIIIIII
             /`-\/XXXXX\/-`\\
           /`.-'/\|/I\|/\'-.`\\
          /`\-/_.-"` `"-._ \-/\\
         /.-'.'           '.'-.\\
       /`\-/                \-/`\\
     _/`-'/`_               _`\'-`\_
    `"""""""`                `""""""`
''')
```

### 运算

##### 运算符号

x=20, y=10

| 运算符 | 描述 | 实例 |
|-|-|-|
| + | 加：两数相加 | x+y=30 |
| - | 减：两数相减 | x-y=10 |
| * | 乘：两数相乘 | x*y=200 |
| / | 除：两数相除 | x/y=2 |
| % | 取模：返回除法的余数 | x%y=0 |
| // | 取整除：返回商的整数部分 | x//y=2 |
| ** | 幂：返回x的y次幂 | x**y= |

##### 复合运算符号

- += 例子

```python
price += 10
#price = price + 10
```

- *= 例子

```python
price *= 10
#price = price * 10
```

等等


##### 在python语言中没有 ++ 和 --

##### 字符串在python语言中加法

### 布尔&if

- and运算和or运算
    - and运算：全真才为真，否则为假
    - or运算：全假才是假，否则为真

- if、if-elif、if-else嵌套


### 列表
##### 一维列表

```python
list = [第一个元素,第二个元素, ......]
#armours = ['红莲斗篷','反伤之甲','爆裂之甲','霸者重装','魔女斗篷' ]
```

##### 多维列表

```python
list = [ [ ... ] , [ ... ] , ... ]
#heroInfos = [['魏', '曹操', 160.3],['蜀', '刘备', 177.1],['吴', '周瑜', 188.6]]
```

##### 列表访问

- 访问列表第list_num个（0为第一个）

```python
list[list_num-1]
#0是第一个，所以这里是list_num-1
```

- 求解list长度

```python
len(list)
#len同时可以用来求解字符串长度
```

- 倒序访问

```python
list[-1]
#注意倒叙是从-1开始的
```

##### 列表新增

```python
list.append(<元素>)
#list.append('亚瑟')
list.insert(<位置>,<元素>)
#list.append(0，'亚瑟')
```

##### 列表删除

```python
list.pop()
#删除最后一个元素
list.pop(<位置>)
#删除索引位置元素
heros = ['牛魔', '妲己','亚瑟','兰陵王']
leave = heros.pop()
#print('死亡英雄：' + leave)
#print('存活英雄：' + str(heros))
#默认删除最后一个

heros = ['牛魔', '妲己','亚瑟','兰陵王']
leave = heros.pop(-1)
print('死亡英雄：' + leave)
print('存活英雄：' + str(heros))
#删除给的索引
```

```python
remove(<值>)
#heros.remove('')
```

##### 列表修改

```python
list[<位置>] = ...
#修改索引位置的值
```

##### 元组

- 元祖：tuple
- 元祖和列表的区别
   - 列表是动态的，长度可变的，可以随意增加、删减或改变元素。列表的存储空间略大于元组，性能略逊于元组。
   - 元组是静态的，长度大小固定，不可以对元素进行增加、删减或者改变操作。元组相对于列表更加轻量级，性能稍优。
- 元组和列表建立区别

```python
list = []
tuple = ()
```



### for&while&嵌套

##### for标准格式

- Python中for语句并不总是对算数进行递增的数值进行迭代，或是给予用户定义定义迭代步骤和暂停的能力，而是对于任意序列进行迭代（例如，字符串或者列表），条目的迭代顺序与它们在序列中出现的顺序一致

```python
words = ['cat', 'window', 'defenestrate']
for w in words:
    print(w, len(w))
```

- 在遍历同一个集合时修改该集合的代码可能很难获得正确的结果。通常，更直接的做法是循环遍历该集合的副本或创建新集合

```python
# Strategy:  Iterate over a copy
for user, status in users.copy().items():
    if status == 'inactive':
        del users[user]

# Strategy:  Create a new collection
active_users = {}
for user, status in users.items():
    if status == 'active':
        active_users[user] = status
```

##### range函数

- range函数生成算术级数

```python
for i in range(5):
     print(i)
```

- 给定的终止数值并不在要生成的序列里；`range(10)` 会生成10个值，并且是以合法的索引生成一个长度为10的序列。range也可以以另一个数字开头，或者以指定的幅度增加（甚至是负数；有时这也被叫做 '步进'）

```python
range(5, 10)
#   5, 6, 7, 8, 9
range(0, 10, 3)
#   0, 3, 6, 9
range(-10, -100, -30)
#  -10, -40, -70
```

- range格式

```python
range(<start>,<end>,<step>)
```

- 当然如果是枚举，更推荐使用enumerate()函数；

##### while函数

while的条件成立，则执行while的语句；

##### break

break：跳出循环；

##### continue

忽略本次循环；

##### 循环嵌套

### 字典

##### 简单理解字典

- **字典是一系列键-值对；**
- **可以将任何python对象用作字典中的键-值；**
- 字典用放在花括号{}中的一系列键-值对表示；
- 键-值对之间用逗号,隔开；
- 键值之间用冒号:隔开；
- 左边是key，右边是value；

```python
info ={
	<keyname> : <value>,
    ...
    <key> : <value>
}
'''
heroInfo = {
    'name': '刘备',
    'state': '蜀',
    'weapon': '雌雄双股剑',
    'mount': '的卢',
    'height': 177.1
}
'''
```

##### 字典访问

- 通过[]访问

```python
print(info['<keyname>'])
'''
heroInfo = {
    'name': '刘备',
    'state': '蜀',
    'weapon': '雌雄双股剑',
    'mount': '的卢',
    'height': 177.1
}
print(heroInfo['weapon'])  # 访问武器
'''
```

- in用法：寻找某个属性是否在字典中

```python
#if 'wife' in heroInfo:
#	print('wife在heroInfo中')
```

##### 字典增改

字典的修改和赋值一样，也是利用访问字典的方法
字典的增加同理，如果字典中没有对应的key-value则添加进去


```python
heroInfo = {
    'name': '关羽',
    'state': '蜀',
    'weapon': '青龙偃月刀',
    'mount': '可怜的小马',
    'height': 212.2
}
####修改
heroInfo['mount'] = '赤兔'

####增加
heroInfo['newcomer'] = '两位嫂嫂'
```

##### 字典删除

使用del方法

```python
####删除某个键-值对
del heroInfo['newcomer']

####删除字典
heroInfo.clear()
```

##### 字典遍历

使用for

```python
for key in heroInfo:
    print(key+'：'+str(heroInfo[key]))
```

##### 集合set

- 集合是列表；
- 集合中元素不重复；
- 集合中没有索引的概念，集合元素无序，集合无法通过索引进行访问；
- 集合有len()；
- 集合通常表示成员间关系、元素去重复等；

```python
heros=['曹操','夏侯惇','刘备','典韦','刘备','关羽','牛魔', '妲己','亚瑟','兰陵王','张飞','夏侯惇','关羽','诸葛亮','牛魔', '妲己','亚瑟','兰陵王','周瑜','孙策','大乔','小乔',]
set(heros)
```

##### 集合遍历、增、删

- 集合判断是否存在也用in；
- 遍历方法同理；
- 增加add

```python
heros = set(['周瑜', '孙策', '小乔', '孙策'])
heros.add('大乔')
```

- 删除.remove

```python
heros.remove('周瑜') 
```



### 自定义函数

- 在自定义函数中传入参数有'*'是动态变量

```bash
def average(*args):
  sum = 0
  for x in args:
    sum += x
  return sum/len(args)
  
print(average(1))
print(average(1, 2))
print(average(1, 2, 3, 4, 5))
```

- 注意递归和内置函数使用；

### 模块

- import文件有数字

```python
import importlib
fib = importlib.import_module('011_part_eleven.fib')
```

## Python网络

### 协议&URL

- http 和 https是协议，区别如下

|  | Http | Https |
| - | - | - |
| 端口 | 80 | 443 |
| 数据传输 | 明文传输 | 加密传输 |
| 真假网站识别 | 很容易被复制 | 使用证书，很难被复制 |
| 浏览器显示区别 | 浏览器显示问好，提示不安全 | 浏览器显示小锁，提示安全 |
| 门槛 | 不需要证书 | 需要Gworg颁发证书，需要一定成本 |
| 安全性 | 很容易被劫持，跳转到其他网站 | 加密安全，很难劫持，交易数据加密 |  

- URL：协议 + 域名 + 路径 + 参数

### get&post

- get方法无提交数据
- post第一个参数是网址，第二个参数是待提交数据

### Json数据

字典

### request&response
- request是请求对象
- response是返回对象
- [json格式化工具](http://www.bejson.com/jsonviewernew/)
- 解析字典和列表（和python字典和列表解析方法一样）

### header

##### User-Agent

User-Agent目的是，在指定URL发送请求的时候，告诉服务端当前用户额浏览器类型、版本，甚至操作系统、CPU等非隐私的技术信息

```python
response = requests.get(url, headers={'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.835.163 Safari/535.1'})
```


##### Referer:

- 一些网站不允许其他网站识别自家网站图片

```python
response = requests.get(url,{'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.835.163 Safari/535.1','Referer':'photo.yupoo.com'})
```

- 注意上面那样识别出来的url是有错误的（注意改成主站，体会两个区别）

```python
headers = {'Referer': 'http://photo.yupoo.com/'}
```


##### Host:

Host表示当前的请求域名

### 下载图片&文件

##### 下载文件

- 文件读写

```python
# 打开一个文件
fo = open("foo.txt", "w")
# 写入内容
fo.write("www.runoob.com!\nVery good site!")
# 关闭文件
fo.close()
```

- 二进制

```python
# 打开一个文件
fo = open("china-city-list.xlsx", "wb")
fo.write(response.content)
fo.close()
```


##### 下载图片

用二进制方法下载文件，修改后缀；

##### 解析excel

xlrd（其实不如用panda）

### cookie&session

##### cookie

- 网站、文件等内容要求登录才能访问，使用cookie相关知识

```python
# 浏览器使用相关知识：
https://www.cnblogs.com/yaoyaojing/p/9530728.html
```

- cookie使用

```python
  for line in f.read().split(';'):
    # 其设置为1就会把字符串拆分成2份
    name, value = line.strip().split('=', 1)
    # 为字典cookies添加内容
    cookies[name] = value
  return cookies
```


##### session

session和cookie区别是，cookie放在浏览器里面的


##### 复用session

重复使用session


## 正则表达式

### 正则表达式基础
##### 正则表达式介绍

- 正则表达式（Regular Expression，代码中简写regex、regexp或者re），通常对文本进行检索、进一步替换或者提取等操作（将正则表达式理解为一种公式）
- r让反斜杠不在表示转义字符

```python
'\\w\\.'

r'\w\.'
```


##### 回车、换行与制表符

非打印字符，有时也叫做“空白字符”。表示在计算机中存在，具备含义和作用，但是通常无法显示出来或打印出来，肉眼看不见

- 换行符

```python
\n
```

- 回车符

```python
# windows
\r\n
# 其他操作系统
\n
#因此windows操作系统多了回车符
```

- 制表符

```python
# tab键
\t
# 长度可能有2、4或者8个字符宽度
```

- 其他符号

当然还有其他的这里暂不举例

| 表达式 | 含义 |
|-|-|
| \\f | 匹配一个换页符 |
| \\v | 匹配一个垂直制表符 |

##### 空白与非空白字符

```python
# \s（小写）是匹配任何空白字符，包括空格、制表符、换页符等等
# \S（大写）是匹配任何非空白符
```


##### 开头与结尾

```python
# ^表示字符串的开头
# $表示字符串的结尾
```


##### 单词、数字、点

```python
# \w 是匹配包括下划线在内任何一个单词字符（A-Z、a-z、0-9、_）
# \W 是匹配任何一个非单词字符
```

```python
# \d 匹配一个数字字符
# \D 匹配一个非数字字符
```

```python
# . 匹配除了换行符（\n、\r）之外的任何单个字符
```

### 特殊字符

##### 原义字符

```python
# 怎么表示 \w 本身
regex = r'\\w'
# 正则表达式前面多加一个反斜杠 \ ，表示原义字符
```


##### 逻辑或条件

```python
# | 逻辑或 
regex = r^'15|16'
```


##### 子表达式

子表达式作用通常是把多个表达式组合起来，作为部分的逻辑规则使用。子表达式被放在()（圆括号）中

```python
regex = r'(X|0|1|2|3|4|5|6|7|8|9|x)$'
```


##### 中括号表达式

正则表达式中范围通常用[]（中括号）表示

```python
# 区间
regex = r'^[a-zA-Z0-9]'
# 可枚举
# [2,3]数字枚举要用 , 隔开
regex = r'^[a-zA-Z0-9_-┊]'
# 排除
# [^a4j7]表示除了a4j7以外的任何字符
# 下面两个 ^ 含义不同
regex = r'^[^0-9_-┊]'
```


##### 限定表达式

限定符，允许特定字符、表达式或子表达式重复出现的次数

- 一般限定符

```python
# ？ 一次或零次
# go?d 可以gd、god；不可以good
# + 大于等于一次
# * 任意次数
```

- 范围限定符

```python
# {n} 匹配确定的n次
# o{2} 能匹配good；不能匹配god
# {n,} 至少n次
# {n,m} 至少n次，至多m次
# {,m}最多m次
```


##### 贪婪与非贪婪

- 贪婪：尽量检索最多

```python
text = "I thought a thought. But the thought I thought wasn't the thought I thought I thought."
regex = r'thought(.+)thought'
```

- 非贪婪：尽量检索最少（在一般限定符和范围限定符后面加上 ？ 表示非贪婪模式）

```python
text = "I thought a thought. But the thought I thought wasn't the thought I thought I thought."
regex = r'thought(.+?)thought'
```



### 常用函数

##### 单次检索

- 检测第一个结果

```python
# search()方法
```

- 开头检索

```python
regex = r'Cats'
matchObj = re.match(regex, line)
# 注意区分
regex = r'^Cats'
matchObj = re.search(regex, line)
```


##### 索引方法

```python
# 起始位置 .start()
# 结束位置 .end()
# 起始和结束位置 .span()
```


##### 全量检索

```python
# 所有结果 .findall()
# 获取所有结果的位置等 .finditer()
```


##### 替换方法

```python
# 替换 re.sub(pattern, repl, sourceText, count) 参数：(正则表达式；替换后；源文本；次数)
import re
text = "2019-11-23"
## 替换所有的非数字的字符，兼容性好
regex = r'\D'
## 全部替换
targetText = re.sub(regex, '/', text)
print('日期：' + targetText)
## 仅替换一次
targetText = re.sub(regex, '/', text, 1)
print('日期：' + targetText)
```


##### 预编译

```python
regex = r''
re.compile(regex)
# 使用的时候去除原本正则表达式的参数就可以了

import re
text = "2019-11-23"
## 替换所有的非数字的字符，兼容性好
regex = r'\D'
## 编译一次
pattern = re.compile(regex)
# 去除参数
matchObjs = pattern.findall(text)
print(matchObjs)
targetText = pattern.sub('/', text)
print('日期：' + targetText)
```


##### 分组

我们把子表达式称为组，获取每个子表达式匹配结果的过程称为分组；

```python
# 整体结果 .group()
# 指定分组 .group(1) 
# 所有分组 .groups() 其中 .groups()[1]和.group(1)结果一致
```



## Python爬虫

### 爬虫介绍

浏览器和服务器请求机制

![python-extension-ykd-crawler-basic](../../assets/images/programming-algorithm/programming-language/python-extension-ykd-crawler-basic.png)

### HTML和Chrome开发者工具

##### 网页介绍
- html（HyperText Markup Language）：超文本标记语言
- css：层叠样式表（Cascading Style Sheets）
- JavaScript（JS）：高级的、解释型的编程语言

##### Chrome调试工具
- 查看源代码等工具
  - Ctrl + S（可以直接保存）

##### Elements
- 检查工具
  - F12（快捷键）
  - Crtl + F（检索）

##### DOM
- Document Object Model


*** 

- [资料](https://www.youkeda.com/)