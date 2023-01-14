#!/bin/bash
source /var/iutools/conf/iutools_profile.sh

echo "Stoping Tomcat / iutools.org"
sh $CATALINA_HOME/bin/shutdown.sh
echo "Sleeping for 2 sec.."
sleep 2

# backup current iutools WAR file
mv  $CATALINA_HOME/webapps/iutools.war  $CATALINA_HOME/webapps/iutools.war.`date +"%H:%M:%S_%d-%m-%Y"`.back

# Delete old iutools directory from the Tomcat webapps
rm -rf $CATALINA_HOME/webapps/iutools

# Copy new  version of the  WAR
echo "cp $IUTOOLS_SOURCES/iutools-apps/target/iutools-apps.war $CATALINA_HOME/webapps/iutools.war "
cp $IUTOOLS_SOURCES/iutools-apps/target/iutools-apps.war $CATALINA_HOME/webapps/iutools.war

echo "Starting Tomcat / iutools.org"
sh $CATALINA_HOME/bin/catalina.sh jpda start &


