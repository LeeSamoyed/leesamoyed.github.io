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

### 方法值接收者和指针接收者区别

=== "方法值接收者和指针接收者区别"

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
