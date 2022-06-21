FROM alpine:3.13

ARG MY_SQL_ROOT_PASSWORD=${PASSWD}

RUN apk update && apk add --no-cache mariadb mariadb mariadb-client

COPY ./entry.sh /entry.sh

ENTRYPOINT [ "/bin/sh", "/entry.sh" ]
