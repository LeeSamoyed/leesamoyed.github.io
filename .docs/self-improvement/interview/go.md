# Go面经

## Go基础

### Go程序的基本结构

=== "答案"

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

## Slice

## Map

## Channel

## Mutex

## Goroutine

## 调度

## 内存管理

## 并发编程