if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
fi

if [ ! -d ${VOL_DB_PATH} ]; then
	mysql_install_db --basedir=/usr --datadir${VOL_DB_PATH} --user=${LOGIN} --rpm --skip-test-db
fi

tmp=`mktemp`
if [ ! -f "${tmp}" ]; then
	exit 1
fi

DB_NAME=${LOGIN}_wp

cat << EOF > ${tmp}

USE mysql
FLUSH PRIVILIEGES;

DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

ALTER USER 'root'@'localhost' IDENTIFIED BY '${MY_SQL_PASSWD}';

CREATE DATABASE ${DB_NAME}_wp_db;
CREATE USER ${LOGIN}'@'%' IDENTIFIED by '${MY_SQL_ROOT_PASSWD}';
GRANT ALL PRIVILIEGES ON ${DB_NAME}.* TO '${LOGIN}'@'%';

FLUSH PRIVILIEGES;

EOF

/usr/bin/mysqld --user=${LOGIN} --bootstrap < ${tmp}

# allow remote connections
sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf


exec /usr/bin/mysqld --user=${LOGIN} --console
