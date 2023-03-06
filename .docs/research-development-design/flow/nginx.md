# Nginx

## Nginx修改后配置

测试
```
nginx -t
```

```
systemctl restart nginx
```

## 80,443端口代理

### 80
```
server {
    listen       80;
    server_name  www.prometheus.test.com; #自定义域名
    root         /usr/share/nginx/html;

    # Load configuration files for the default server block.
    include /etc/nginx/default.d/*.conf;

    location / {
        proxy_pass http://192.168.100.158:9090; #填写对应主机IP
    }
}
```

### 443

- ssl

```
openssl genrsa -out tls.key 2048
openssl req -new -x509 -days 365 -key tls.key -out tls.crt -subj /C=CN/ST=Beijingshi/L=Beijing/O=devops/CN=cn
```

- 代理

```
server {
    listen       80;
    listen	     443 ssl;
    ssl_certificate /data/tls.crt; #找到证书所在对应目录
    ssl_certificate_key /data/tls.key; #找到key所在对应目录
    server_name  www.grafana.test.com; #自定义域名
    root         /usr/share/nginx/html;

    # Load configuration files for the default server block.
    include /etc/nginx/default.d/*.conf;

    location / {
        proxy_pass http://192.168.100.158:3000; #填写对应主机IP
    }
}
```

### http2https

```
server {
    listen       80;
    listen       443 ssl;
    ssl_certificate /data/tls.crt; #找到证书所在对应目录
    ssl_certificate_key /data/tls.key; #找到key所在对应目录
    server_name  www.prometheus.test.com; #自定义域名
    root         /usr/share/nginx/html;

    # Load configuration files for the default server block.
    include /etc/nginx/default.d/*.conf;
    # http自动跳转https
    if ($server_port = 80 ) {
            return 301 https://$host$request_uri;
    }

    location / {
        proxy_pass http://192.168.100.158:9090; #填写对应主机IP
    }
    # http自动跳转https
    error_page 497  https://$host$request_uri;
}
```