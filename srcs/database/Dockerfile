FROM debian:buster

ARG MY_SQL_ROOT_PASSWORD=${PASSWD}

RUN apt-get -y update && apt-get -y install mariadb-server

COPY ./entry.sh /entry.sh

CMD [ "/bin/sh", "/entry.sh" ]
