FROM alpine

RUN apk add --no-cache git openssh-client

ADD *.sh /

ENTRYPOINT ["sh", ".repo-mirror/entrypoint.sh"]
