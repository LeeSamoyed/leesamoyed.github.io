FROM alpine

RUN apk add --no-cache git openssh-client

ADD *.sh /

ENTRYPOINT ["sh", "entrypoint.sh"]
