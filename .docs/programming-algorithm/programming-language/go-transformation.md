# Go快速转型

### 引言

### Golang开发环境

### Golang语言特性

##### Golang优势

##### Golang适合做什么

- 云计算基础设施领域（docker、kubernetes、etcd、consul、cloudflare CDN、七牛云存储等）
- 基础后端软件（tidb、influxdb、cockroachdb等）
- 微服务（go-kit、micro、monzo bank的typhon、bilibili等）
- 互联网基础设施（以太坊、hyperledger）

##### Golang产品

##### Golang不足

- 包管理，大部分包都在github上
- 无泛化类型
- 所有Excepiton都用Error来处理(比较有争议)。
- 对C的降级处理，并非无缝，没有C降级到asm那么完美(序列化问题)

### Golang语法新奇

##### 函数

!!! info "注意"
这里面go语言的语法，定义函数的时候，‘{’ 必须和函数名在同一行，不能另起一行。

> 注意：这里面go语言的语法，定义函数的时候，‘{’ 必须和函数名在同一行，不能另起一行。

##### 变量

> 注意：go语言类型写在变量名称后面。

##### unsafe

> unsafe包功能很强大，例如使用unsafe.Sizeof()统计字符串返回是16，意味着指针和长度各占用8字节
> Go语言中其实有很多都是结构，例如字符串（其余的要多再了解了解）

##### iota

> iota（自增）

```
type Allergen int


const (
    IgEggs Allergen = 1 << iota         // 1 << 0 which is 00000001
    IgChocolate                         // 1 << 1 which is 00000010
    IgNuts                              // 1 << 2 which is 00000100
    IgStrawberries                      // 1 << 3 which is 00001000
    IgShellfish                         // 1 << 4 which is 00010000
)
```

这个工作是因为当你在一个const组中仅仅有一个标示符在一行的时候，它将使用增长的iota取得前面的表达式并且再运用它，。在 Go 语言的spec中， 这就是所谓的隐性重复最后一个非空的表达式列表.

如果你对鸡蛋，巧克力和海鲜过敏，把这些 bits 翻转到 “on” 的位置（从左到右映射 bits）。然后你将得到一个 bit 值00010011，它对应十进制的 19。

```
fmt.Println(IgEggs | IgChocolate | IgShellfish)


// output:
// 19
type ByteSize float64


const (
    _           = iota                   // ignore first value by assigning to blank identifier
    KB ByteSize = 1 << (10 * iota)       // 1 << (10*1)
    MB                                   // 1 << (10*2)
    GB                                   // 1 << (10*3)
    TB                                   // 1 << (10*4)
    PB                                   // 1 << (10*5)
    EB                                   // 1 << (10*6)
    ZB                                   // 1 << (10*7)
    YB                                   // 1 << (10*8)
)
```

```
const (
    Apple, Banana = iota + 1, iota + 2
    Cherimoya, Durian
    Elderberry, Fig
)

// Apple: 1
// Banana: 2
// Cherimoya: 2
// Durian: 3
// Elderberry: 3
// Fig: 4

上面这个例子看上去iota是固定每行+1，注意理解这个东西
```

##### return
```
package main


import "fmt"


func swap(x, y string) (string, string) {
   return y, x
}


func main() {
   a, b := swap("Mahesh", "Kumar")
   fmt.Println(a, b)
}
```

##### init & main

> init 可选，有且仅一个

> main 必写，有且仅一个

##### 包的导入

> 导包的先会导入包中导入的包

##### defer

> 后进先出

##### recover & panic

> 感觉很想像try-catch，但是需要再理解理解

##### slice & map

```
language := make(map[string]map[string]string)
language["php"] = make(map[string]string, 2)
language["php"]["id"] = "1"
language["php"]["desc"] = "php是世界上最美的语言"
language["golang"] = make(map[string]string, 2)
language["golang"]["id"] = "2"
language["golang"]["desc"] = "golang抗并发非常good"
```

##### new & make

- new函数参数是类型，返回值是指针，指向该类型的内存地址，分配的内存被设为零值，即该类型的零值，就是说字符串为空，整型为0，布尔变量为false等。

- make函数返回值与参数类型一致，而不是指针，因为make仅初始化slice,map,channel等的内存，而这些类型是引用类型，不需要返回指针。

- 总结：make仅用于分配并初始化slice,map,channel类型，而new能分配任何数据类型。new返回指针(Type, *Type)，make返回引用(Type)。另外new仅分配空间，make分配的空间之后被清空并初始化。

##### 方法值

> 在一个包的API需要一个函数值、且调用方希望操作的是某一个绑定了对象的方法的话，方法"值"会非常实用。

##### 方法表达式（再强化一下！！！）（很厉害的东西）

##### interface & 断言

- interface：有点像Java的Object（再理解下）
- 断言：用于检查类型是否满足

##### 反射

- 在计算机科学领域，反射是指一类应用，它们能够自描述和自控制。也就是说，这类应用通过采用某种机制来实现对自己行为的描述（self-representation）和监测（examination），并能根据自身行为的状态和结果，调整或修改应用所描述行为的状态和相关的语义。

感觉不是特别像人话，建议再理解下！

##### 结构体标签

```

结构体标签（Struct Tag）类似于 C# 中的特性（Attribute）。C# 允许在类、字段、方法等前面添加 Attribute，然后在反射系统中可以获取到这个属性系统。例如：
[Conditional("DEBUG")]
public static void Message(string msg)
{
    Console.WriteLine(msg)；
}

```

```
`key1:"value1" key2:"value2"`

结构体标签由一个或多个键值对组成。键与值使用冒号分隔，值用双引号括起来。键值对之间使用一个空格分隔。

从结构体标签中获取值:
StructTag 拥有一些方法，可以进行 Tag 信息的解析和提取，如下所示：
func(tag StructTag)Get(key string)string
根据 Tag 中的键获取对应的值，例如 `key1:"value1"key2:"value2"` 的 Tag 中，可以传入“key1”获得“value1”。
func(tag StructTag)Lookup(key string)(value string,ok bool)
根据 Tag 中的键，查询值是否存在。
```
```
package main
import (
    "fmt"
    "reflect"
)
func main() {
    type cat struct {
        Name string
        Type int `json:"type" id:"100"`
    }
    typeOfCat := reflect.TypeOf(cat{})
    if catType, ok := typeOfCat.FieldByName("Type"); ok {
        fmt.Println(catType.Tag.Get("json"))
    }
}
```

```
package main

import (
    "fmt"
    "reflect"
)

type resume struct {
    Name string `json:"name" doc:"我的名字"`
}

func findDoc(stru interface{}) map[string]string {
    t := reflect.TypeOf(stru).Elem()
    doc := make(map[string]string)

    for i := 0; i < t.NumField(); i++ {
        doc[t.Field(i).Tag.Get("json")] = t.Field(i).Tag.Get("doc")
    }

    return doc

}

func main() {
    var stru resume
    doc := findDoc(&stru)
    fmt.Printf("name字段为：%s\n", doc["name"])
}
```

### Golang高阶

##### goroutine

##### channel

##### select

##### go modules