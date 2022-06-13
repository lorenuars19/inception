FROM debian:buster

RUN apt-get -y -qq update && apt-get -y -qq install mariadb

RUN mkdir ./db-volume.d/

VOLUME /var/lib/mysql

CMD [ "mysqld" ]
