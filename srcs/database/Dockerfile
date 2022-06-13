FROM debian:buster

RUN apt-get -y update && apt-get -y install mariadb-server

RUN mkdir ./db-volume.d/

VOLUME /var/lib/mysql

CMD [ "mysqld" ]
