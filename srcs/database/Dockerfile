FROM debian:buster

ARG MY_SQL_ROOT_PASSWORD=${PASSWD}

RUN apt-get -y update && apt-get -y install mariadb-server

RUN mkdir ${VOL_DB_PATH}

CMD [ "mysqld" ]
