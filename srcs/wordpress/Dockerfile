FROM debian:buster

RUN apt-get -y update && apt-get -y install curl php-fpm zsh

# install worpress using wp-cli
RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /bin/wp \
&& chmod 700 /bin/wp \
&& wp cli update \
&& wp --allow-root core download --path=${WP_PATH} --skip_plugins --skip_packages --skip_themes \
	--locale=en_US \
&& wp --allow-root config create --path=${WP_PATH} --skip_plugins --skip_packages --skip_themes \
	--dbname=${WP_DB_NAME} --dbuser=${WP_DB_USER} --dbpass=${WP_DB_PASS}

CMD ["/bin/wp shell"]
