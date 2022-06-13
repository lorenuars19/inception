FROM debian:debian:buster

ENV MYSQL_VERSION=8.0

RUN apt-get -y -qq update \
&& apt-get -y -qq install apt-utils zsh curl lsb-release wget gnupg

#TODO move .env file
ENV MYSQL_ALLOW_EMPTY_PASSWORD=1

# Install MySQL
RUN cd /tmp \
&& curl -LsS https://dev.mysql.com/get/mysql-apt-config_0.8.22-1_all.deb -o mysql.deb \
&& echo "4" | dpkg -i ./mysql.deb \
&& apt-get update \
&& echo "" "" | apt-get -y -qq install mysql-server

RUN mkdir ./db-volume.d/

VOLUME /var/lib/mysql

CMD [ "mysqld" ]
