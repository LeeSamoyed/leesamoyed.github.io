FROM ubuntu

RUN apt update && apt install git python3 python3-pip -y && \
  echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

ADD . /
