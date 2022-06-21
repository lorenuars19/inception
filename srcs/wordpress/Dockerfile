FROM debian:buster

RUN apt-get -y update && apt-get -y install curl php-fpm mariadb-client zsh

COPY ./entry.sh /entry.sh

CMD ["/bin/sh", "entry.sh"]
