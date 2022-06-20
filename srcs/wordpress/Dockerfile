FROM debian:buster

RUN apt-get -y update && apt-get -y install curl php-fpm zsh

# install worpress using wp-cli
RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /bin/wp \
&& chmod 700 /bin/wp \
&& wp cli update \
&& wp --allow-root core download --path=${VOL_WP_PATH} --skip-plugins --skip-packages --skip-themes \
	--locale=en_US \
&& wp --allow-root config create --path=${VOL_WP_PATH} --skip-plugins --skip-packages --skip-themes \
	--dbname=${LOGIN}_wp_db --dbuser=${LOGIN} --dbpass=${PASSWD}

CMD ["/bin/wp shell"]
