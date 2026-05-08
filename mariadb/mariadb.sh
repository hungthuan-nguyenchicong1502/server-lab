#!/bin/sh
set -e

mkdir -p /run/mysqld /var/lib/mysql

chown -R mysql:mysql /run/mysqld /var/lib/mysql
chmod -R 755 /run/mysqld /var/lib/mysql

# tao db

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db
    # mariadb-secure-installation
fi

exec "$@"