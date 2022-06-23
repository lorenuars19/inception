
while ! mariadb -hmariadb -u${LOGIN} -p${MY_SQL_PASSWD} ${WP_DB_NAME} &>/dev/null; do
    sleep 1
done

chmod 700 /bin/wp

env >>  ${VOL_WP_PATH}/.log_output

/bin/wp --allow-root cli update
/bin/wp --allow-root core download --locale=en_US
/bin/wp --allow-root config create --dbname=${WP_DB_NAME} --dbuser=${LOGIN} --dbpass=${MY_SQL_PASSWD}

printf "CONFIG CREATE RET : %s\n" $(ls | grep config) >> ${VOL_WP_PATH}/.log_output

/bin/wp --allow-root core install --url=${LOGIN}.42.fr --title="${LOGIN}_site" --admin_user=${LOGIN} --admin_password=${WP_ROOT_PASSWD} --admin_email="${LOGIN}@student.s19.be"
/bin/wp --allow-root user create --user-login=edit --role=editor --user_pass=${WP_EDIT_PASSWD}

/usr/sbin/php-fpm7 -F -R
