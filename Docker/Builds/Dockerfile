FROM debian:bullseye

RUN apt update  &&   \
    apt-get install -y  wget gnupg curl procps git maven vim  sudo mariadb-server-10.5 locales && \
    rm -rf /var/lib/apt/lists/

## Configure and setup a default UTF-8 locale needed for iutools ( POSIX was the default... )
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LC_ALL en_US.UTF-8 
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en

## Create iutools user
RUN echo "iutools ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    groupadd iutools && \
    useradd -s /bin/bash  -g iutools -d /var/iutools iutools && \
    mkdir /var/iutools && \
    chown -R iutools:iutools /var/iutools 
    
COPY --chown=iutools:iutools ./iutools-configs/ /var/iutools/
# Setup MySQL for iutools ( create user and db )
RUN /var/iutools/bin/setup_mysql.sh

## Use user iutools from now on. 
USER iutools
WORKDIR /var/iutools

#Set some defaults and install Tomcat , JAVA , Elasticsearch in sys  .
RUN echo "source /var/iutools/conf/iutools_profile.sh" >> /var/iutools/.bashrc && \
    echo "alias ll='ls -ltrh --color=auto'" > /var/iutools/.bashrc && \
    echo "set mouse-=a" >> /var/iutools/.vimrc && \
    mkdir /var/iutools/javasources /var/iutools/sys /var/iutools/logs && \
    cd /var/iutools/sys && \
    wget --quiet https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.17.3-linux-x86_64.tar.gz && \
    tar -xzvf elasticsearch-7.17.3-linux-x86_64.tar.gz && \
    rm elasticsearch-7.17.3-linux-x86_64.tar.gz && \
    wget --quiet https://builds.openlogic.com/downloadJDK/openlogic-openjdk/8u352-b08/openlogic-openjdk-8u352-b08-linux-x64.tar.gz && \
    tar -xzf openlogic-openjdk-8u352-b08-linux-x64.tar.gz && \
    rm openlogic-openjdk-8u352-b08-linux-x64.tar.gz && \
    ln -s openlogic-openjdk-8u352-b08-linux-x64 java_1.8 && \
    wget --quiet https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.84/bin/apache-tomcat-8.5.84.tar.gz && \
    tar -xzf apache-tomcat-8.5.84.tar.gz && \
    ln -s apache-tomcat-8.5.84 tomcat8 && \
    rm apache-tomcat-8.5.84.tar.gz 

#Download / Install java-utils , iutools & deploy app
RUN . /var/iutools/conf/iutools_profile.sh && \
    cd /var/iutools/javasources && \
    git clone https://github.com/nrc-cnrc/java-utils.git && \
    cd java-utils && \
    git checkout 38af2abdeaa167678554858cdec8bf9ca0ac4d41 && \
    mvn clean install -DskipTests=true && \
    cd /var/iutools/javasources && \
    git clone https://github.com/iutools/iutools.git && \
    cd iutools && \
    git checkout e22573ad19106636994f0cf9b0b6ddd8d0eda1ac && \
    mvn clean install:install-file  -DgroupId=net.loomchild -DartifactId=maligna-ui -Dpackaging=jar -Dversion=3.0.1 -Dfile=./iutools-core/src/main/lib/maligna-ui-3.0.1.jar && \
    mvn clean install -DskipTests=true && \
    cp /var/iutools/javasources/iutools/iutools-apps/target/iutools-apps.war /var/iutools/sys/tomcat8/webapps/iutools.war && \
    echo "CATALINA_OPTS=\"$CATALINA_OPTS -Dorg_iutools=/var/iutools/conf/org_iutools.properties -Dlog4j.configurationFile=file:/var/iutools/conf/log4j2.xml \"" > /var/iutools/sys/tomcat8/bin/setenv.sh

#Load iutools TM and corpus
COPY --chown=iutools:iutools ./iutools-data /var/iutools/iutools-data/
RUN bash /var/iutools/bin/load-data_iutools.sh

EXPOSE 8080
#Start iutools ( MySQL , Elasticsearch , Tomcat)
CMD ["/bin/bash", "/var/iutools/bin/start_iutools.sh"]
