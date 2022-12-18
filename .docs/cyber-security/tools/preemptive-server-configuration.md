# 抢占式服务器配置

开发完了，自己扫一扫

### AWVS
```
sudo apt update

sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update

sudo apt install docker-ce docker-ce-cli containerd.io

docker pull secfa/docker-awvs

docker run -it -d -p 8889:3443 secfa/docker-awvs
```