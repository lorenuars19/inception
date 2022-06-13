FROM debian:buster

RUN apt-get -y update && apt-get -y install curl php-fpm zsh

# install worpress using wp-cli
RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /bin/wp && chmod 700 /bin/wp

RUN wp core download --path=/var/wordpress --locale=en_EN

CMD ["/bin/cat"]
