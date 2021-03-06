if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld

fi

chown -R mysql:mysql /var/lib/mysql
rm -rf /var/lib/mysql/*

mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm --skip-test-db

if [[ $? -ne 0 ]];then
	echo ERROR
	exit 1
fi
tmp=`mktemp`
if [ ! -f "${tmp}" ]; then
	exit 1
fi

cat << EOF > ${tmp}

USE mysql;
FLUSH PRIVILEGES;

DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

ALTER USER 'root'@'localhost' IDENTIFIED BY '${MY_SQL_ROOT_PASSWD}';

CREATE DATABASE ${WP_DB_NAME};
CREATE USER '${LOGIN}'@'%' IDENTIFIED BY '${MY_SQL_PASSWD}';
GRANT ALL PRIVILEGES ON ${WP_DB_NAME}.* TO '${LOGIN}'@'%';

FLUSH PRIVILEGES;

EOF

/usr/bin/mysqld --user=mysql --bootstrap < ${tmp}
rm ${tmp}


# allow remote connections
sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf


exec /usr/bin/mysqld --user=mysql --console
