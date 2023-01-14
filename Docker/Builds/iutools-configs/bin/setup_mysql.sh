/usr/bin/mysqld_safe &
sleep 8
/usr/bin/mysql -uroot < /var/iutools/conf/config.mysql
sleep 2
killall -u mysql
