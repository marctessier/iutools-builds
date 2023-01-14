sudo /usr/bin/mysqld_safe &
source /var/iutools/conf/iutools_profile.sh
/var/iutools/sys/elasticsearch-7.17.3/bin/elasticsearch  &
sleep 5

sh $CATALINA_HOME/bin/catalina.sh jpda start &
wait
