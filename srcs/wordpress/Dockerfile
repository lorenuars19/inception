FROM debian:buster

RUN apt-get -y update && apt-get -y install curl php-fpm zsh

COPY ./entry.sh /tmp/entry.sh

WORKDIR ${VOL_WP_PATH}

ENTRYPOINT ["/bin/sh", "/tmp/entry.sh"]
