# Go面经

## Go基础

### 程序的基本结构

=== "Go程序的基本结构"

    - 关键字
    - 包声明
    - 注释
    - 函数
    - 变量和常量声明
    - 类型
    - 语句
        * 赋值语句
        * 条件语句
        * 循环语句
        * 跳转语句
    - 运算符
        * 算数运算符
        * 逻辑运算符
        * 位运算符

=== "代码理解"

    ```go
    // 包声明
    package main

    // 引入包（标准库）
    import "fmt"

    // 函数
    func main(){
        // 变量类型声明
        var name string
        // 语句（赋值语句、条件语句、循环语句、跳转语句）
        name = "yamlee"
        // 运算符（算数运算符、位运算符、逻辑运算）
        fmt.Println("hello world, " + name)
    }
    ```

### 关键字

=== "关键字"

    - package: 包声明
    - import: 引入包
    - func: 定义函数和方法
    - return: 从函数返回
    - defer: 在函数退出之前执行
    - var: 变量声明
    - const: 常量类型
    - interface: 声明接口类型
    - struct: 声明结构体类型
    - chan: 声明channel类型
    - map: 声明map类型数据
    - type: 声明自定义类型
    - break, case, continue, for, fallthrough, else, if, switch, goto, default: 流程控制
    - range: 读取slice, map, channel数据
    - go: 创建goroutine

### 数据类型

=== "数据类型"

    - 布尔类
        * bool
    - 数字类型
        * unit
        * int
        * float32
        * float64
        * byte
        * rune
    - 字符串类型
        * string
    - 复合类型
        * 数组类型(array)
        * 切片类型(slice)
        * 字典类型(map)
        * 管道类型(channel)
        * 结构化类型(struct)
    - 指针类型(pointer)
    - 接口类型(interface)
    - 函数类型(func)
    - 方法类型(method)

### 方法与函数区别

=== "方法与函数区别"

    方法是一个特殊的函数，函数是指不属于任何结构体、类型的方法，也就是说函数是没有接收者的；而方法是有接收者的

    

=== "代码"

    ```go
    // 方法
    // T是自定义类型或者结构体，不能是基础类型int等
    func (t *T) add(a, b int) int {
        return a+b
    }

    // 函数
    func add(a, b int) int {
        return a+b
    }
    ```

    注意方法中还区分值接收者和指针接收者，在下面一个问题中进行阐述

### 方法值接收者和指针接收者区别

=== "方法值接收者和指针接收者区别"

    !!! tip "注意点一：本身和副本"

        如果方法的接收者是指针类型，无论调用者是对象还是对象指针，修改的都是对象本身，会影响调用者

        如果方法的接收者是值类型，无论调用者是对象还是对象指针，修改的都是对象的副本，不影响调用者

    ```go
    //值接收者
    type person struct{
        name string
    }
    func (p person) String() string {
        return "the person name is " + p.name
    }

    // 指针接收者
    // 下述例子，打印出来的值还是Test，对其进行的修改无效。如果我们使用一个指针作为接收者，那么就会其作用了，因为指针接收者传递的是一个指向原值指针的副本，指针的副本，指向的还是原来类型的值，所以修改时，同时也会影响原来类型变量的值。
    type person struct{
        name string
    }
    func (p person) String() string {
        return "the person name is " + p.name
    }
    func (p person) modify(){
        p.name = "YamLee"
    }
    func main(){
        p := person{name:"Test"}
        p.modify()
        fmt.Println(p.String())
    }
    
    // 在调用方法的时候，传递的接收者本质上都是副本，只不过一个是这个值副本，一是指向这个值指针的副本。指针具有指向原有值的特性，所以修改了指针指向的值，也就修改了原有的值。我们可以简单的理解为值接收者使用的是值的副本来调用方法，而指针接收者使用实际的值来调用方法。
    type person struct {
        name string
    }
    func (p person) String() string{
        return "the person name is "+p.name
    }
    func (p *person) modify(){
        p.name = "YamLee"
    }
    func main() {
        p := person{name:"Test"}
        p.modify() //指针接收者，修改有效
        fmt.Println(p.String())
    }

    // 在上面的例子中，有没有发现，我们在调用指针接收者方法的时候，使用的也是一个值的变量，并不是一个指针，如果我们使用下面的也是可以的。
    p := person{name:"Test"}
    (&p).modify() //指针接收者，修改有效

    // 下述方法也是可以的。如果我们没有这么强制使用指针进行调用，Go的编译器自动会帮我们取指针，以满足接收者的要求。同样的，如果是一个值接收者的方法，使用指针也是可以调用的，Go编译器自动会解引用，以满足接收者的要求，比如例子中定义的String()方法，也可以这么调用：
    p:=person{name:"Test"}
    fmt.Println((&p).String())
    ```

    !!! tip "注意点二：方法的隐含实现"

        Go的语法糖

        1. 如果实现了接收者是指针类型的方法，会隐含地也实现了接收者是值类型的方法
        2. 如果实现了接收者是值类型的方法，会隐含地也实现了接收者是指针类型的方法

    ```go
    type Person struct {
        age int
    }

    // 如果实现了接收者是指针类型的方法，会隐含地也实现了接收者是值类型的IncrAge1方法。
    // 会修改age的值
    func (p *Person) IncrAge1() {
        p.age += 1
    }
    // 如果实现了接收者是值类型的方法，会隐含地也实现了接收者是指针类型的IncrAge2方法。
    // 不会修改age的值
    func (p Person) IncrAge2() {
        p.age += 1
    }
    // 如果实现了接收者是值类型的方法，会隐含地也实现了接收者是指针类型的GetAge方法。
    func (p Person) GetAge() int {
        return p.age
    }

    func main() {
        
        // p1 是值类型
        p := Person{age: 10}
        // 值类型 调用接收者是指针类型的方法
        p.IncrAge1()
        fmt.Println(p.GetAge())
        // 值类型 调用接收者是值类型的方法
        p.IncrAge2()
        fmt.Println(p.GetAge())

        // ----------------------

        // p2 是指针类型
        p2 := &Person{age: 20}
        // 指针类型 调用接收者是指针类型的方法
        p2.IncrAge1()
        fmt.Println(p2.GetAge())
        // 指针类型 调用接收者是值类型的方法
        p2.IncrAge2()
        fmt.Println(p2.GetAge())
    }

    !!! note "注意点二：方法的隐含实现"

        1. 使用指针类型能够修改调用者的值。
        2. 使用指针类型可以避免在每次调用方法时复制该值，在值的类型为大型结构体时，这样做会更加高效。

    ```

### 函数返回局部变量的指针是否安全

=== "函数返回局部变量的指针是否安全"

### 函数参数传递到底是值传递还是引用传递

=== "函数参数传递到底是值传递还是引用传递"

### defer关键字的实现原理

=== "defer关键字的实现原理"

### 内置函数make和new区别

=== "内置函数make和new区别"

## Slice

### slice的底层实现原理

=== "slice的底层实现原理"

### slice为什么不是线程安全

=== "slice为什么不是线程安全"

### slice深拷贝和浅拷贝

=== "slice深拷贝和浅拷贝"

### slice扩容机制

=== "slice扩容机制"

## Map

### map的底层实现原理

=== "map的底层实现原理"

### map遍历为什么是无序的

=== "map遍历为什么是无序的"

### map为什么是非线程安全的

=== "map为什么是非线程安全的"

### map如何查找

=== "map如何查找"

### map冲突的解决方法

=== "map冲突的解决方法"

### map的负载因子为什么是6.5

=== "map的负载因子为什么是6.5"

### map如何扩容

=== "map如何扩容"

### map和sync.Map谁的性能好，为什么

=== "map和sync.Map谁的性能好，为什么"

## Channel

### channel有什么特点

=== "channel有什么特点"

### channel的底层实现原理

=== "channel的底层实现原理"

### channel有无缓冲区别

=== "channel有无缓冲区别"

### channel为什么是线程安全的

=== "channel为什么是线程安全的"

### channel如何控制goroutine并发执行

=== "channel如何控制goroutine并发执行"

### channel共享内存有什么优劣势

=== "channel共享内存有什么优劣势"

### channel发送和接受什么情况下会死锁

=== "channel发送和接受什么情况下会死锁"

## Mutex

### 互斥锁实现原理

=== "互斥锁实现原理"

### 互斥锁正常模式和饥饿模式的区别

=== "互斥锁正常模式和饥饿模式的区别"

### 互斥锁允许自旋的条件

=== "互斥锁允许自旋的条件"

### 读写锁的实现原理

=== "读写锁的实现原理"


### 可重入锁如何实现

=== "可重入锁如何实现"


### 原子操作有哪些

=== "原子操作有哪些"


### 原子操作和锁的区别

=== "原子操作和锁的区别"


## Goroutine

### goroutine的底层实现原理

=== "goroutine的底层实现原理"


### goroutine和线程的区别

=== "goroutine和线程的区别"


### goroutine泄漏的场景

=== "goroutine泄漏的场景"


### 如何查看正在执行的goroutine数量

=== "如何查看正在执行的goroutine数量"


### 如何控制并发的goroutine数量

=== "如何控制并发的goroutine数量"


### 线程实现模型

=== "线程实现模型"


## 调度

### GMP和GM模型

=== "GMP和GM模型"


### 调度原理

=== "调度原理"


### work stealing机制

=== "work stealing机制"


### hand off机制

=== "hand off机制"


### 抢占式调度

=== "抢占式调度"


### 如何查看运行时调度信息

=== "如何查看运行时调度信息"


## 内存管理

### 内存分配机制

=== "内存分配机制"


### 内存逃逸

=== "内存逃逸"


### 内存对齐机制

=== "内存对齐机制"


### GC实现原理

=== "GC实现原理"


### GC如何调优

=== "GC如何调优"


### GC如何查看GC信息

=== "GC如何查看GC信息"


## 并发编程

### 常用的并发模型

=== "常用的并发模型"


### 有哪些并发同步原语

=== "有哪些并发同步原语"


### WaitGroup实现原理

=== "WaitGroup实现原理"


### Cond实现原理

=== "Cond实现原理"


### 有哪些方法安全读写共享变量

=== "有哪些方法安全读写共享变量"


### 如何排查数据竞争问题

=== "如何排查数据竞争问题"
