# Gin

[Code](https://github.com/gin-gonic/gin)

[Tutorial](https://go.dev/doc/tutorial/)

[码神之路](https://www.mszlu.com/go/gin/01/01.html#_1-go%E6%B5%81%E8%A1%8C%E7%9A%84web%E6%A1%86%E6%9E%B6)

## Gin介绍

### 特性

- 快速：基于 Radix 树的路由，小内存占用。没有反射。可预测的 API 性能。

- 支持中间件：传入的 HTTP 请求可以由一系列中间件和最终操作来处理。 例如：Logger，Authorization，GZIP，最终操作 DB。

- Crash 处理：Gin 可以 catch 一个发生在 HTTP 请求中的 panic 并 recover 它。这样，你的服务器将始终可用。例如，你可以向 Sentry 报告这个 panic！

- JSON 验证：Gin 可以解析并验证请求的 JSON，例如检查所需值的存在。

- 路由组：更好地组织路由。是否需要授权，不同的 API 版本…… 此外，这些组可以无限制地嵌套而不会降低性能。

- 错误管理：Gin 提供了一种方便的方法来收集 HTTP 请求期间发生的所有错误。最终，中间件可以将它们写入日志文件，数据库并通过网络发送。

- 内置渲染：Gin 为 JSON，XML 和 HTML 渲染提供了易于使用的 API。

- 可扩展性：新建一个中间件非常简单。

### 路由

路由是URI到函数的映射

##### RESTful API

使用特定的HTTP方法来对服务器上的资源进行操作。

    1. GET，表示读取服务器上的资源

    2. POST，表示在服务器上创建资源

    3. PUT,表示更新或者替换服务器上的资源

    4. DELETE，表示删除服务器上的资源

    5. PATCH，表示更新/修改资源的一部分

##### URL

URI书写的时候，不需要关心scheme和authority这两部分，我们主要通过path和query两部分的书写来进行资源的定位。

- 静态URL

- 动态URL

### 参数

### 响应

### 模板

### 会话

##### cookie

##### session

### 中间件

## Gin安装

### 初始化(Windows)

```sh
D:\go\project>mkdir ginlearn
D:\go\project>cd ginlearn
D:\go\project\ginlearn>go work init
D:\go\project\ginlearn>mkdir helloworld
D:\go\project\ginlearn>cd helloworld
D:\go\project\ginlearn\helloworld>go mod init test.com/helloworld
go: creating new go.mod: module test.com/helloworld
D:\go\project\ginlearn\helloworld>cd ..
D:\go\project\ginlearn>go work use ./helloworld

PS D:\go\project\ginlearn> cd .\helloworld\
#下载并安装gin
PS D:\go\project\ginlearn\helloworld> go get -u github.com/gin-gonic/gin
```

```go
package main

import "github.com/gin-gonic/gin"

func main() {
	r := gin.Default()
	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})
	r.Run() // 监听并在 0.0.0.0:8080 上启动服务
}
```
