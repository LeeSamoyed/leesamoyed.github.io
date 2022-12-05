# 危险函数关键字

### 漏洞关键字
|漏洞名称 | 关键词|
|  -  | -|
| XXE | SAXReader, DocumentBuilder, XMLStreamReader, ... |
| File  | MultipartFile, createNewFile, FileInputStream |
| SSRF | HttpCilent, URL, ImageIO, HttpURLConnection, OkHttpCilent |
| SQL | Statement, PreparedStatement, sql, $, hql |
| EXEC | getRuntime.exec, ProcessBuilder.start |


### 漏洞表格
|漏洞名称 | 关键词|
|  -  | -|
| 密码硬编码、密码明文存储 | password 、pass、jdbc|
|XSS  | getParamter、<%=、param. |
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