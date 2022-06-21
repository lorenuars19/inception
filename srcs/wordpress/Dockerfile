FROM debian:buster

RUN apt-get -y update && apt-get -y install curl php-fpm zsh

COPY ./entry.sh /tmp/entry.sh

WORKDIR /var/www/html/wordpress

ENTRYPOINT ["/bin/sh", "/tmp/entry.sh"]
