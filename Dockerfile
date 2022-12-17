FROM alpine

RUN apk add --no-cache git openssh-client

ADD . /

ENTRYPOINT ["sh", "entrypoint.sh"]