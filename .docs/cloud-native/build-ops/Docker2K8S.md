# Docker程序部署K8S流程

1. 迁移docker image下载 上传到harbor（固化版本）

    * 找一台有docker的机器pull
    * docker pull
    * docker tag 固化tag（为上传做准备）
    * docker login harbor
    * docker push

2. 改code，从docker迁移到K8S，docker yml -> pod yml
   
3. pg -> RDS数据库（可以不考虑，直接创建）

4. service定义

5. ingress定义