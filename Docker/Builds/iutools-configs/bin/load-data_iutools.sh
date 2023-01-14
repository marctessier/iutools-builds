#!/bin/bash

sudo /usr/bin/mysqld_safe &
sleep 5
. /var/iutools/conf/iutools_profile.sh
/var/iutools/sys/elasticsearch-7.17.3/bin/elasticsearch --daemonize
sleep 20

#iutools_cli load_corpus -force
java -Xmx18g -Dlog4j.configurationFile=file:/var/iutools/conf/log4j2.xml -Dorg_iutools=/var/iutools/conf/org_iutools.properties -cp "/var/iutools/javasources/iutools/iutools-core/target/iutools-core.jar:/var/iutools/javasources/iutools/iutools-core/target/lib/*" org.iutools.cli.CLI load_corpus -force 

#iutools_cli load_translation_memory --force
java -Xmx18g -Dlog4j.configurationFile=file:/var/iutools/conf/log4j2.xml -Dorg_iutools=/var/iutools/conf/org_iutools.properties -cp "/var/iutools/javasources/iutools/iutools-core/target/iutools-core.jar:/var/iutools/javasources/iutools/iutools-core/target/lib/*" org.iutools.cli.CLI load_translation_memory --force 

sleep 3

sudo killall -u mysql

