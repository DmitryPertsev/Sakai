FROM tomcat_server_8028

RUN apt-get update -y 
RUN apt-get install git -y
RUN wget http://mirrors.sonic.net/apache/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz && tar -zxf apache-maven-3.2.5-bin.tar.gz && cp -R apache-maven-3.2.5 /usr/local && ln -s /usr/local/apache-maven-3.2.5/bin/mvn /usr/bin/mvn

RUN git clone https://github.com/sakaiproject/sakai.git
RUN git -C ./sakai checkout 11.x
RUN (cd sakai; mvn clean install sakai:deploy -Dmaven.tomcat.home=/opt/tomcat/)
RUN cp -a /opt/tomcat/lib/. /opt/tomcat/sakai-lib


ENTRYPOINT ["/opt/scripts/entrypoint.sh"]
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
