# install worpress using wp-cli

if [ ! -f /bin/wp ];then exit 1; fi

chmod 700 /bin/wp

/bin/wp --allow-root cli update
/bin/wp --allow-root core download --path=${VOL_WP_PATH} --locale=en_US
/bin/wp --allow-root config create --path=${VOL_WP_PATH} --dbname=${LOGIN} --dbuser=mysql --dbpass=${MY_SQL_ROOT_PASSWD}
/bin/wp --allow-root core install --path=${VOL_WP_PATH} --url=${LOGIN}.42.fr --title="${LOGIN}_site" --admin_user=${LOGIN} --admin_password=${WP_ROOT_PASSWD} --admin_email="${LOGIN}@student.s19.be"
/bin/wp --allow-root user create --path=${VOL_WP_PATH} --user-login=edit --role=editor --user_pass=${WP_EDIT_PASSWD}

/bin/wp --allow-root shell
