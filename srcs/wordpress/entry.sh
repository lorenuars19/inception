# install worpress using wp-cli

curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /bin/wp \
&& chmod 700 /bin/wp \
&& wp cli update \
&& wp --allow-root core download --path=${VOL_WP_PATH} \
	--locale=en_US \
&& wp --allow-root config create --path=${VOL_WP_PATH} \
	--dbname=${LOGIN}_wp_db --dbuser=${LOGIN} --dbpass=${PASSWD} \
&& wp --allow-root core install --path=${VOL_WP_PATH} \
	--url=${LOGIN}.42.fr --title="${LOGIN}_site" --admin_user=${LOGIN} \
	--admin_password={PASSWD} --admin_email="${LOGIN}@student.s19.be" \
&& wp --allow-root user create --path=${VOL_WP_PATH} \
	--user-login=guest --role=subscriber --user_pass=guest123

wp shell
