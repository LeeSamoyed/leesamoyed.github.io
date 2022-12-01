# Python Crash Course

## 变量和简单的数据类型

！！！python安装和配置等步骤跳过  
！！！本文不是小白文，部分内容不会书写  

### 运行hello_world.py时发生了什么？  
- 末尾.py会指出这算是一个python程序，因此编译器将使用python解释器去运行它。python解释器读取整个程序，确定其中每个单词的含义；  


### 变量：  
- 变量的命名和使用：  
	- 变量名只能包含字母、数字和下划线。变量名可以字母或下划线打头，但不能以数字打头，例如，可以将变量命名为message_1，但是不能将其命名为1_message；  
	- 变量名不能包含空格，但可使用下划线来分隔其中的单词。例如，变量名greeting_message可行，但变量名greeting message会引发错误；  
	- 不要将python关键字和函数名用作变量名，即不要使用python保留用于特殊用途的单词，如print；  
	- 变量名应既简单又具有描述性。例如，name比n好，studenta_name比s_n好，name_length比length_of_person_name好；  
	- 慎用小写字母l和大写字母O，因为它们可能被人看错成数字1和0；  

- 使用变量时避免命名错误：  
	- python提供traceback（追溯），其实trackback也是我们寻找bug的有力武器；  


### 数据类型：  
-  字符串:
	- 字符串可以使用''（单引号）也可以使用""（双引号）；  
	- python可以使用'.'，让python对变量...执行方法...制定的操作。例如：text.title，变量text执行方法title；  
	- python可以使用'+'，对字符串直接进行拼接；  
	- 使用制表符或者换行符来添加空白，例如，'\t'，'\n'等；  
	- 删除空白等也有方法，例如，'.rsstrip‘；  
-  数字：  
	- 整形；  
	- 浮点数；  
	- str()方法；  


### 注释
- \#: 单行注释；  
- ''' ''':多行注释；  
- 注释编写注释事项不阐述

***

## 列表

### 概念：
-  列表由一系列按**特定顺序**排列的元素组成；
-  可以将任何东西加入列表；
-  元素之间可以没有任何关系；
-  ’[]‘（方括号）表示；

### 操作：
##### 访问
```
<list_name>[<list_index>]
# 注意计数是从0开始的
# book[0]
# python提供特殊的语法。计数可以从-1（倒数第一个）开始
```

##### 修改、添加和删除
- 修改：访问+赋值
```
book[0] = 'book_0'
```
- 添加：insert方法
```
book.insert(0,'book_0')
# 在第0个位置插入'book_0'
```
- 添加：删除：del方法、pop方法或remove方法
```
# del
del book[0]

# pop
# 列表相当于一个栈，pop可以删除列表末尾元素
# 也可以pop[0]

# remove方法（根据值删除）
book.remove('book_0')
```

### 组织
- sort方法（永久排序）
```
# 正向排序
book.sort()

# 倒序排序
book.sort(reverse=True)
```
- sorted临时排序
```
print(sorted(book))
# 临时排序也可以传递参数reverse=True进行倒序排序
```
- 长度
```
len(book)
```
- 反向打印
```
book.reverse()
# 注意reverse是反转列表元素排序
```

***

## 操作列表
### 遍历
```
for book in books:
	print(book)
# 用变量book存储从books中取得的书名，再打印
# 对于存储列表中每个值的临时变量，可指定任何名称
```

### python缩进问题
- 忘记缩进；
- 忘记缩进额外代码行；
- 不必要的缩进；
- 循环后不必要的缩进；
- 遗漏冒号；

### 数字列表
- range()函数
```
for value in range(1,5):
    print(value)
#1
#2
#3
#4

# 函数range()让python从你指定的第一个值开始数，并在到达你指定额第二个值后停止，
# 因此输出不包含第二个值（这里是5）

# 使用list创建数字列表
numbers = list(range(1,6))
print(numbers)
#[1,2,3,4,5]
```
- max()、min()、sum()函数
- 列表解析
```
squares = [value**2 for value in range(1,11)]
# 勤加练习才能写出列表解析！
```

### 使用列表的一部分
- 切片
```
players = [...]
# 定义players

print(players[0:3])
# 打印前0~3个元素

print(players[1:4])
# 打印第2~4个元素

print(players[:3])
# 未指定起始，从头开始打印到第3个元素

print(players[2:])
# 起始为第2个元素，打印后面的

# 倒序打印同理
```
- 遍历
```
for player in players[:3]：
	print(player.title())
```
- 复制
```
friend_foods = my_foods[:]
# 复制my_foods列表到一个新列表friend_foods
```

### 元组
- 不可变的列表；
- 元组单个值不可以改，可以修改整个元组

### 代码格式
- 缩进；
- 行长；
- 空行；
- 格式设置指南；

***

## if语句
### 条件测试
- 每条if语句的核心都是一个值为True或者False的表达式，这种表达式被成为条件测试；
- 如果条件测试的值为True，python就执行紧跟在if语句后面的代码；如果为False，python就忽略这些代码；
	- 检查规则：
	```
	检查是否相等或不相等
	# == & !=
	
	检查是否相等时考虑大小写
	
	数字比较
	# == & >= & <= & > & < & ...
	
	多个条件
	and & or
	
	是否包含
	in & not in
	```
- 布尔数据类型

### if语句
- if语句；
- if-else语句；
- if - elif -else语句；
- 多个elif代码块；
- 注意else没有可省略；

***

## 字典
### 使用字典
- 字典是一系列键-值对
- 访问
```
alien_0 = {'color' : 'green'}
print(alien_0['color'])
```
- 添加 & 修改
```
# 为什么添加和修改放在一起说呢
# 修改类似赋值的修改
# 如果字典中没有你赋值是的键(key)，就会添加
alien_0 = {'color' : 'green'}

# 修改
alien_0['color'] = 'red'

# 添加
# 因为没有'add_color'这个键，所以就会添加
alien_0['add_color'] = 'yellow'
```
- 创建空的
```
# []（方括号）是列表；{}（大括号）是字典
alien_0 = {}
```
- 删除
```
# 删除使用del语句，传给del语句的是键名
alien_0 = {'color' : 'green'}
del alien_0['color']
```
- 当然字典存储的是一个对象，也可以字典存储字典，字典存储列表

### 遍历
- 可以使用for循环，使用字典的items()
- 当然字典提供了专门的方法keys()
- 如果要按一定顺序（比如首字母排序等），在循环前可以进行排序
```
for name in sorted(class_name.keys()):
    print(name)
```
- 同样所有的值也有方法values()

***

## 用户输入和while循环
### 函数input()工作原理
- 函数input()让程序暂停运行，等待用户输入一些文本。获取用户输入后，python将其存储在一个变量中，以方便你使用
- 函数input()只接受一个参数，就是用户显示的提示或说明
```
message = input('你想输入什么呢？')
print(message)
```
- 用户看到或者说明，程序等待用户输入，用户输入完成后按回车，程序继续执行。输入内容存储在message变量中（这里是，可以修改名字）

### 强制转换
- int()
- str()
- ...
```
a = 12

# 强制抓换为字符串 
b = str(a)

# 强制转换为int数据类型
c = int(b)
```

### while循环
- while的条件若判断为True则会自行，反之则退出
- break语句会强制退出
- continue语句会忽略余下（循环内）代码，回到循环的开头继续执行
- break和continue在for循环等其他情况也可以使用

***

## 函数
### 定义函数
- def + 函数名 + 参数传入（没有的时候可以空着）
```
# 无参数
def function_one()

# 有一个参数
def function_two(name)

# 有多个参数
def function_three(name,pwd,id)
```

- 实参和形参
	- 实参：全称为"实际参数"是在调用时传递给函数的参数.。实参可以是常量、变量、表达式、函数等，无论实参是何种类型的量，在进行函数调用时，它们都必须具有确定的值，以便把这些值传送给形参。 因此应预先用赋值，输入等办法使实参获得确定值
	- 形参：全称为"形式参数" 由于它不是实际存在变量，所以又称虚拟变量。是在定义函数名和函数体的时候使用的参数，目的是用来接收调用该函数时传入的参数.在调用函数时，实参将赋值给形参。因而，必须注意实参的个数，类型应与形参一一对应，并且实参必须要有确定的值


### 传递实参

- 位置实参：调用函数时，python必须将函数调用中的每个实参都关联到函数定义中的一个形参。为此，最简单的关联方式是基于实参的顺序。这种关联方式称为位置实参
- 关键字实参：传递给函数的名称-值对（有点类似键-值对）
    注意：使用关键字实参时，务必准确地指定函数定义中的形参名
- 默认值：编写函数时，可以给每个形参指定的默认值；如果调用函数中给形参提供了实参，python使用指定实参；没有则使用默认值
```
# 给定name默认值'37'
def function_three(name,pwd,id=’37‘)

# 使用的时候注意id还是算是位置实参的!!!所以没有默认值和有默认值的顺序需要注意！！！
```

### 返回值
- 在函数中，可以使用return语句将值返回到调用函数的代码行；
- 可以返回各种类型的值（包括字典等）；

### 模块
- 将函数存储在模块中，就可以将主代码块和主程序分离
- 使用import语句进行模块的导入
- import as 可以取别名
- from import 可以只导入模块中部分函数
- 遇到模块名中有数字的
```
import importlib
fib = importlib.import_module('011_part_eleven.fib')
```

***

## 类
### 创建和使用类
- 创建Dog雷
```
# 创建Dog类
class Dog():
    # 方法__init()__是一个特殊的方法
    # 给予了self,name,age三个形参，并且self形参必不可少，并且放在第一个
    # 每当你根据Dog类创建新实例时，Python都会自动运行它
    def __init__(self, name, age):
        self.name = name
        self.age = age

    # 每一个与类相关联的方法调用都自动传递实参self
    # 它是一个指向实例本身的引用，让实力能够访问类中的属性和方法
    # 以self为前缀的变量都可供类中所有方法使用，我们还可以通过类的任何实例来访问这些变量
    def sit(self):
        print(self.name.title() + "sit!")

    def roll_over(self):
        print(self.name.title() + "roll over!")
    
    # 像上述那样通过实例进行访问的变量称为属性
```
你可按需求根据一个类创建任意数量的实例，条件将每个实例都存储在不同的变量中或占用列表或字典的不同位置；

- 根据类创建实例
```
my_dog = Dog('willie', 6)
```
- 访问属性
```
my_dog.name
```
- 调用方法
```
my_dog.roll_over()
```

### 使用类和实例
- 给属性指定默认值
```
# 直接修改属性的值
my_dog.name = 'dog'
my_dog.roll_over()

# 通过方法修改属性的值
# 向方法传入参数，在方法中进行赋值
class Dog():
    # 在之前的类中补充
    def update_name(self, name):
        self.name = name
        
my_dog.update_name('dog_one')
my_dog.roll_over()
```

### 继承
- 继承
```
# 注意是super()
class Samoyed(Dog):
    def __init__(self, name, age):
        super().__init__(name, age)
        
my_samoyed = Samoyed('samoyed', 20)
my_samoyed.roll_over()

# 让一个人继承另一个类后，可添加区分子类和父类所需的新属性和方法
```
- 重写父类方法
```
class Samoyed(Dog):
    def __init__(self, name, age):
        super().__init__(name, age)

    def roll_over(self):
        print(self.name.title() + "|||roll over!")
# 重写roll_over方法
```

- 实例用作属性

### 导入类
```
import

from import

import importlib
fib = importlib.import_module('011_part_eleven.fib')
```

***

## 文件&异常
### 从文件中读取数据
- 读取
```
with open ('...') as ...
```
- 路径
```
with open ('...') as ...

```
- 逐行读取&使用

### 写入文件
-  写入文件；
-   写入多行；
-   添加到文件；

### 异常
try-catch-else

### 数据存储

***

## 测试代码

书写测试类