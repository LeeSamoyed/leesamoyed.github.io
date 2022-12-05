# 危险函数关键字

### 后端漏洞关键字
|漏洞名称 | 关键词|
|  -  | -|
| XXE | SAXReader, DocumentBuilder, XMLStreamReader, ... |
| File  | MultipartFile, createNewFile, FileInputStream |
| SSRF | HttpCilent, URL, ImageIO, HttpURLConnection, OkHttpCilent |
| SQL | Statement, PreparedStatement, sql, $, hql |
| EXEC | getRuntime.exec, ProcessBuilder.start |
| 密码硬编码、密码明文存储 | password 、pass、jdbc|
| XSS  | getParamter、<%=、param. |
| SQL注入 | Select、Dao 、from 、delete 、update、insert |
| 任意文件下载 | download 、fileName 、filePath、write、getFile、getWriter |
| 任意文件删除 | Delete、deleteFile、fileName 、filePath |
| 文件上传 | Upload、write、fileName 、filePath |
| 命令注入 | getRuntime、exec、cmd、shell |
| 缓冲区溢出 | strcpy,strcat,scanf,memcpy,memmove,memeccpy Getc(),fgetc(),getchar;read,printf |
| XML注入 | DocumentBuilder、XMLStreamReader、SAXBuilder、SAXParser 、SAXReader 、XMLReader 、SAXSource 、TransformerFactory 、SAXTransformerFactory 、SchemaFactory |
| 反序列化漏洞 | ObjectInputStream.readObject 、ObjectInputStream.readUnshared、XMLDecoder.readObject 、Yaml.load、XStream.fromXML、ObjectMapper.readValue、JSON.parseObject |
| url跳转 | sendRedirect、setHeader、forward |
| 不安全组件暴露 |  activity、Broadcast Receiver、Content Provider、Service、inter-filter |
| 日志记录敏感信息 | log log.info logger.info  |
| 代码执行 | eval、system、exec |

### Web
|函数名称 | 关键词|
|  -  | -|
| getParameter | request类获取参数方法 |
| getParameterNames | 获取参数名 |
| getParameterValues | 获取参数值 |
| getParameterMap | 获取参数map类型 |
| getQueryString | 获取URL的value值 |
| getHeader | 获取请求头 |
| getHeaderNames | 获取请求头名 |
| getRequestURL | 获取请求URL |
| getCookies | 获取cookie |
| getRequestedSessionId | 获取sessionid |
| getInputStream | 获取输入数据 |
| getReader | 获取请求内容 |
| getMethod | 获取请求方法 |
| getProtocol | 获取请求协议 |
| getServerName | 获取服务名 |
| getRemoteUser | 获取当前缓存的用户 |
| getUserPrincipal | 获取用户指纹 |

### 文件
|函数名称 | 关键词|
|  -  | -|
| java.io.FileInputStream | 文件输入 |
| java.io.FileOutputStream | 文件输出 |
| java.io.FileReader | 文件读取 |
| java.io.FileWriter | 文件写入 |

### URL重定向
- javax.servlet.http.HttpServletResponse.sendRedirect
- javax.servlet.http.HttpServletResponse.setStatus
- javax.servlet.http.HttpServletResponse.addHeader