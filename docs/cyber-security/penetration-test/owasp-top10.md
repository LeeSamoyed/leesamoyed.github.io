# OWASP-Top10

主要用于开发自测，注意千万别做任何可能存在违法的行为！！！
道路千万条！！！安全第一条！！！

## 爆破
这是一个很容易犯的错误，一般都需要多次错误锁定之类的操作，或者短时间内只允许一定次数的操作，别让测试人员把server搞down了！！！

下面是开发人员请采纳的自查爆破方式（如有需求，稍微进行修改）

工具采用BurpSuite —— Turbo Intruder

### Py验证码6位
```
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
```
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
一些很老、很破又是小站。或者长期不维护的系统。特征是页面较为简陋，排列不齐

开发人员如果接收到这类项目一定注意Sql！！！

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
/robots.txt
记录协议（爬虫协议、规则等）

### phpinfo信息泄漏
/phpinfo
记录php配置情况

### Swagger2
/v2/api-docs
/v2/\_catalog
记录接口相关信息

### pprof未授权访问
debug/pprof/goroutine?debug=1

### grafana
/dashboard/snapshot/:key
/api/snapshots/:key

### 返回包敏感信息
- 返回包中别放敏感信息！！！

### 信息填写敏感信息
- 信息填写有时候会对应uid，uid的返回包中存在敏感信息（千万别剩下功夫，一定先验证过了再返回数据，同时，谁的账号就返回谁的数据）

###  Session共用技巧
- 同一个地址加上http和不加https可能是两个站（看转发与否），注意开发时不要存在Session共用情况

### 信息修改
- 一般来说存在id类的地方，都可能犯这个错误

### 绕过
- 返回包中时常存在判断正确错误的参数，这个可能是一个需要注意的点，不要让这个校验能通过前端修改等方式被绕过了

### 绑定
- 存在绑定等操作的时候，一定要谨慎再谨慎，千万不可以存在随机修改一个号码就过了（尤其是，只验证号码，不验证号码和验证码是否一致的时候）

### 接口利用
- 有一些接口，千万别给调用权限，尤其是短信收发！！！

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
