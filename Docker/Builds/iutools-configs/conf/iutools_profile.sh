export TZ=America/Montreal
export JAVA_HOME=/var/iutools/sys/java_1.8
export PATH=$JAVA_HOME/bin:$PATH;


export IUTOOLS_HOME=/var/iutools
export PATH=$IUTOOLS_HOME/bin:$PATH

export CATALINA_HOME=$IUTOOLS_HOME/sys/tomcat8

export IUTOOLS_SOURCES=$IUTOOLS_HOME/javasources/iutools
export IUTOOLS_VERSION=1.0.2
export IUTOOLS_DATA='$IUTOOLS_HOME/iutools-data'

export IUTOOLS_CORE_EXECS=${IUTOOLS_SOURCES}/iutools-core/target
export IUTOOLS_PROPS_FILE=$IUTOOLS_HOME/conf/org_iutools.properties
export LOG4J2_XML=file:$IUTOOLS_HOME/conf/log4j2.xml

alias iutools_cli='java -Xmx18g -Dlog4j.configurationFile=${LOG4J2_XML} -Dorg_iutools=${IUTOOLS_PROPS_FILE} -cp "${IUTOOLS_CORE_EXECS}/iutools-core.jar:${IUTOOLS_CORE_EXECS}/lib/*" org.iutools.cli.CLI'




alias monitorProgress='sh $IUTOOLS_HOME/bin/monitorProgress.bash';
alias mvn-install='mvn clean install -DskipTests'
alias reload-iutools-env='source $IUTOOLS_HOME/conf/iutools_profile.sh'
