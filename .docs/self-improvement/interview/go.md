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

    一般来说，局部变量会在函数返回后被销毁，因此被返回的引用就成了“无所指”的引用，程序会进入未知状态。

    但这在Go中是安全的，Go编译器会对每个局部变量进行逃逸分析。如果发现局部变量的作用域超出该函数，则不会将内存分配到栈上，而是分配在堆上，因为他们不在栈区，即使释放函数，其内容也不会受影响。

    ```go
    func add(x, y int) *int {
        res := 0
        res = x + y
        return &res
    }

    func main() {
    fmt.Println(add(1, 2))
    }
    ```

    上述例子中，函数 **add** 的局部变量 **res** 发生了逃逸。 **res** 作为返回值，在 **main** 函数中使用，因此 **res** 指向的内存不能够分配在栈上，随着函数结束而收回，只能分配在堆上。

    便编译时可以借助 **-gcflags=-m** ，查看变量逃逸情况

    ```go
    ./main.go:6:2: res escapes to heap:
    ./main.go:6:2:   flow: ~r2 = &res:
    ./main.go:6:2:     from &res (address-of) at ./main.go:8:9
    ./main.go:6:2:     from return &res (return) at ./main.go:8:2
    ./main.go:6:2: moved to heap: res
    ./main.go:12:13: ... argument does not escape
    0xc0000ae008
    ```

    **res escapes to heap** 即表示 **res** 逃逸到堆上了。

### 函数参数传递到底是值传递还是引用传递

=== "函数参数传递到底是值传递还是引用传递"

    这一章可以结合 <a href="#方法值接收者和指针接收者区别">方法值接收者和指针接收者区别</a> 一起看

    Go语言中所有的传参都是值传递（传值），都是一个副本，一个拷贝。

    参数如果是非引用类型（int、string、struct等这些），这样就在函数中就无法修改原内容数据；如果是引用类型（指针、map、slice、chan等这些），这样就可以修改原内容数据。

    是否可以修改原内容数据，和传值、传引用没有必然的关系。在C++中，传引用肯定是可以修改原内容数据的，在Go语言里，虽然只有传值，但是我们也可以修改原内容数据，因为参数是引用类型

    **引用类型和引用传递是2个概念，切记！！！**

    **什么是值传递？**

    将实参的值传递给形参，形参是实参的一份拷贝，实参和形参的内存地址不同。函数内对形参值内容的修改，是否会影响实参的值内容，取决于参数是否是引用类型

    **什么是引用传递？**

    将实参的地址传递给形参，函数内对形参值内容的修改，将会影响实参的值内容。Go语言是没有引用传递的，在C++中，函数参数的传递方式有引用传递。

    下面分别针对Go的值类型（int、struct等）、引用类型（指针、slice、map、channel），验证是否是值传递，以及函数内对形参的修改是否会修改原内容数据

=== "int类型"

    形参和实际参数内存地址不一样，证明是指传递；参数是值类型，所以函数内对形参的修改，不会修改原内容数据

    ```go
    func main() {
        var i int64 = 1
        fmt.Printf("原始int内存地址是 %p\n", &i)
        modifyInt(i) // args就是实际参数
        fmt.Printf("改动后的值是: %v\n", i)
    }

    func modifyInt(i int64) { //这里定义的args就是形式参数
        fmt.Printf("函数里接收到int的内存地址是：%p\n", &i)
        i = 10
    }

    // 原始int内存地址是 0xc0000180b8
    // 函数里接收到int的内存地址是：0xc0000180c0
    // 改动后的值是: 1
    ```

    形参和实际参数内存地址不一样，证明是指传递，由于形参和实参是指针，指向同一个变量。函数内对指针指向变量的修改，会修改原内容数据

    ```go
    func main() {
        var args int64 = 1                  // int类型变量
        p := &args                          // 指针类型变量
        fmt.Printf("原始指针的内存地址是 %p\n", &p)   // 存放指针类型变量
        fmt.Printf("原始指针指向变量的内存地址 %p\n", p) // 存放int变量
        modifyPointer(p)                    // args就是实际参数
        fmt.Printf("改动后的值是: %v\n", *p)
    }

    func modifyPointer(p *int64) { //这里定义的args就是形式参数
        fmt.Printf("函数里接收到指针的内存地址是 %p \n", &p)
        fmt.Printf("函数里接收到指针指向变量的内存地址 %p\n", p)
        *p = 10
    }
    // 原始指针的内存地址是 0xc000110018
    // 原始指针指向变量的内存地址 0xc00010c008
    // 函数里接收到指针的内存地址是 0xc000110028 
    // 函数里接收到指针指向变量的内存地址 0xc00010c008
    // 改动后的值是: 10
    ```

=== "slice类型"

    形参和实际参数内存地址一样，不代表是引用类型；下面进行详细说明slice还是值传递，传递的是指针

    ```go
    func main() {
        var s = []int64{1, 2, 3}
        // &操作符打印出的地址是无效的，是fmt函数作了特殊处理
        fmt.Printf("直接对原始切片取地址%v \n", &s)
        // 打印slice的内存地址是可以直接通过%p打印的,不用使用&取地址符转换
        fmt.Printf("原始切片的内存地址： %p \n", s)
        fmt.Printf("原始切片第一个元素的内存地址： %p \n", &s[0])
        modifySlice(s)
        fmt.Printf("改动后的值是: %v\n", s)
    }

    func modifySlice(s []int64) {
        // &操作符打印出的地址是无效的，是fmt函数作了特殊处理
        fmt.Printf("直接对函数里接收到切片取地址%v\n", &s)
        // 打印slice的内存地址是可以直接通过%p打印的,不用使用&取地址符转换
        fmt.Printf("函数里接收到切片的内存地址是 %p \n", s)
        fmt.Printf("函数里接收到切片第一个元素的内存地址： %p \n", &s[0])
        s[0] = 10
    }

    // 直接对原始切片取地址&[1 2 3]
    // 原始切片的内存地址： 0xc0000b8000
    // 原始切片第一个元素的内存地址： 0xc0000b8000
    // 直接对函数里接收到切片取地址&[1 2 3]
    // 函数里接收到切片的内存地址是 0xc0000b8000
    // 函数里接收到切片第一个元素的内存地址： 0xc0000b8000
    // 改动后的值是: [10 2 3]
    ```

    **slice** 是一个结构体，他的第一个元素是一个指针类型，这个指针指向的是底层数组的第一个元素。当参数是 **slice** 类型的时候，fmt.printf通过%p打印的slice变量的地址其实就是内部存储数组元素的地址，所以打印出来形参和实参内存地址一样。

    ```go
    type slice struct {
        array unsafe.Pointer // 指针
        len   int
        cap   int
    }
    ```

    因为slice作为参数时本质是传递的指针，上面证明了指针也是值传递，所以参数为slice也是值传递，指针指向的是同一个变量，函数内对形参的修改，会修改原内容数据

    单纯的从slice这个结构体看，我们可以通过modify修改存储元素的内容，但是永远修改不了len和cap，因为他们只是一个拷贝，如果要修改，那就要传递&slice作为参数才可以。

=== "map类型"

    形参和实际参数内存地址不一样，证明是值传递

    ```go
    func main() {
        m := make(map[string]int)
        m["age"] = 8

        fmt.Printf("原始map的内存地址是：%p\n", &m)
        modifyMap(m)
        fmt.Printf("改动后的值是: %v\n", m)
    }

    func modifyMap(m map[string]int) {
        fmt.Printf("函数里接收到map的内存地址是：%p\n", &m)
        m["age"] = 9
    }

    // 原始map的内存地址是：0xc00000e028
    // 函数里接收到map的内存地址是：0xc00000e038
    // 改动后的值是: map[age:9]
    ```

    通过make函数创建的map变量本质是一个hmap类型的指针*hmap，所以函数内对形参的修改，会修改原内容数据

    ```go
    //src/runtime/map.go
    func makemap(t *maptype, hint int, h *hmap) *hmap {
        mem, overflow := math.MulUintptr(uintptr(hint), t.bucket.size)
        if overflow || mem > maxAlloc {
            hint = 0
        }

        // initialize Hmap
        if h == nil {
            h = new(hmap)
        }
        h.hash0 = fastrand()
    }
    ```

=== "channel类型"

    形参和实际参数内存地址不一样，证明是值传递

    ```go
    func main() {
        p := make(chan bool)
        fmt.Printf("原始chan的内存地址是：%p\n", &p)
        go func(p chan bool) {
            fmt.Printf("函数里接收到chan的内存地址是：%p\n", &p)
            //模拟耗时
            time.Sleep(2 * time.Second)
            p <- true
        }(p)

        select {
        case l := <-p:
            fmt.Printf("接收到的值是: %v\n", l)
        }
    }

    // 原始chan的内存地址是：0xc00000e028
    // 函数里接收到chan的内存地址是：0xc00000e038
    // 接收到的值是: true
    ```

    通过make函数创建的chan变量本质是一个hchan类型的指针*hchan，所以函数内对形参的修改，会修改原内容数据

    ```go
    // src/runtime/chan.go
    func makechan(t *chantype, size int) *hchan {
        elem := t.elem

        // compiler checks this but be safe.
        if elem.size >= 1<<16 {
            throw("makechan: invalid channel element type")
        }
        if hchanSize%maxAlign != 0 || elem.align > maxAlign {
            throw("makechan: bad alignment")
        }

        mem, overflow := math.MulUintptr(elem.size, uintptr(size))
        if overflow || mem > maxAlloc-hchanSize || size < 0 {
            panic(plainError("makechan: size out of range"))
        }
    }
    ```

=== "struct类型"

    形参和实际参数内存地址不一样，证明是值传递。形参不是引用类型或者指针类型，所以函数内对形参的修改，不会修改原内容数据

    ```go
    type Person struct {
        Name string
        Age  int
    }

    func main() {
        per := Person{
            Name: "test",
            Age:  8,
        }
        fmt.Printf("原始struct的内存地址是：%p\n", &per)
        modifyStruct(per)
        fmt.Printf("改动后的值是: %v\n", per)
    }

    func modifyStruct(per Person) {
        fmt.Printf("函数里接收到struct的内存地址是：%p\n", &per)
        per.Age = 10
    }

    // 原始struct的内存地址是：0xc0000a6018
    // 函数里接收到struct的内存地址是：0xc0000a6030
    // 改动后的值是: {test 8}
    ```

### defer关键字的实现原理

=== "defer关键字的实现原理"

    **定义：**

    defer能够让我们推迟执行某些函数调用，推迟到当前函数 **返回前** 才实际执行。defer与panic和recover结合，形成了Go语言风格的异常与捕获机制。

    **使用场景：**

    defer 语句经常被用于处理成对的操作，如文件句柄关闭、连接关闭、释放锁

    **优点：**

    方便开发者使用

    **缺点：**

    有性能损耗

    **实现原理：**

    Go1.14中编译器会将defer函数直接插入到函数的尾部，无需链表和栈上参数拷贝，性能大幅提升。把defer函数在当前函数内展开并直接调用，这种方式被称为open coded defer

    源代码：

    ```go
    func A(i int) {
        defer A1(i, 2*i)
        if(i > 1) {
            defer A2("Hello", "eggo")
        }
        // code to do something
        return
    }
    func A1(a,b int) {
        //......
    }
    func A2(m,n string) {
        //......
    }
    ```

    编译后（伪代码）：

    ```go
    func A(i int) {
        // code to do something
        if(i > 1){
            A2("Hello", "eggo")
        }
        A1(i, 2*i)
        return
    }
    ```

    **代码示例：**

    1. 函数退出前，按照先进后出的顺序，执行defer函数

    ```go
    // defer：延迟函数执行，先进后出
    func main() {
        defer fmt.Println("defer1")
        defer fmt.Println("defer2")
        defer fmt.Println("defer3")
        defer fmt.Println("defer4")
        fmt.Println("11111")
    }

    // 11111
    // defer4
    // defer3
    // defer2
    // defer1
    ```

    2. panic后的defer函数不会被执行（遇到panic，如果没有捕获错误，函数会立刻终止）

    ```go
    // panic后的defer函数不会被执行
    func main() {
        defer fmt.Println("panic before")
        panic("发生panic")
        defer func() {
            fmt.Println("panic after")
        }()
    }

    // panic before
    // panic: 发生panic
    ```

    3. panic没有被recover时，抛出的panic到当前goroutine最上层函数时，最上层程序直接异常终止

    ```go
    func F() {
        defer func() {
            fmt.Println("b")
        }()
        panic("a")
    }

    // 子函数抛出的panic没有recover时，上层函数时，程序直接异常终止
    func main() {
        defer func() {
            fmt.Println("c")
        }()
        F()
        fmt.Println("继续执行")
    }

    // b
    // c
    // panic: a
    ```

    4. panic有被recover时，当前goroutine最上层函数正常执行

    ```go
    func F() {
        defer func() {
            if err := recover(); err != nil {
                fmt.Println("捕获异常:", err)
            }
            fmt.Println("b")
        }()
        panic("a")
    }

    func main() {
        defer func() {
            fmt.Println("c")
        }()
        F()
        fmt.Println("继续执行")
    }

    // 捕获异常: a
    // b
    // 继续执行
    // c
    ```


### 内置函数make和new区别

=== "内置函数make和new区别"

    首先纠正下make和new是内置函数，不是关键字

    变量初始化，一般包括2步，变量声明 + 变量内存分配，var关键字就是用来声明变量的，new和make函数主要是用来分配内存的

    var声明 **值类型** 的变量时，系统会 **默认为他分配内存空间** ，并赋该类型的 **零值**

    比如布尔、数字、字符串、结构体

    如果 **指针类型** 或者 **引用类型** 的变量，系统不会为它分配内存，默认就是nil。此时如果你想 **直接使用，那么系统会抛异常** ，必须进行内存分配后，才能使用。

    new 和 make 两个内置函数，主要用来分配内存空间，有了内存，变量就能使用了，主要有以下2点区别：

    **使用场景区别：**

    make 只能用来分配及初始化类型为slice、map、chan 的数据。

    new 可以分配任意类型的数据，并且置零。

    **返回值区别：**

    make函数原型如下，返回的是slice、map、chan类型本身

    这3种类型是引用类型，就没有必要返回他们的指针

    ```go
    func make(t Type, size ...IntegerType) Type
    ```

    new函数原型如下，返回一个指向该类型内存地址的指针

    ```go
    func new(Type) *Type
    ```

## Slice

### slice的底层实现原理

=== "slice的底层实现原理"

    切片是基于数组实现的，它的底层是数组，可以理解为对 底层数组的抽象。

    源码包中src/runtime/slice.go 定义了slice的数据结构：

    ```go
    type slice struct {
        array unsafe.Pointer
        len   int
        cap   int
    }
    ```

    - slice占用24个字节
    - array: 指向底层数组的指针，占用8个字节
    - len: 切片的长度，占用8个字节
    - cap: 切片的容量，cap 总是大于等于 len 的，占用8个字节
    
    slice有4种初始化方式

    ```go
    // 初始化方式1：直接声明
    var slice1 []int

    // 初始化方式2：使用字面量
    slice2 := []int{1, 2, 3, 4}

    // 初始化方式3：使用make创建slice
    slice3 := make([]int, 3, 5)         

    // 初始化方式4: 从切片或数组“截取”
    slcie4 := arr[1:3]
    ```

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
