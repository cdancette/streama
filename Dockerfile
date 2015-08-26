FROM tomcat:7

MAINTAINER Tomohisa Kusano <siomiz@gmail.com>

ADD https://github.com/dularion/streama/archive/master.tar.gz /tmp/
COPY DataSource.groovy /tmp/

WORKDIR /opt/streama

RUN tar zxvf /tmp/master.tar.gz --strip-components=1 \
	&& rm /tmp/master.tar.gz \
	&& apt-get update \
	&& apt-get install -y openjdk-7-jdk \
	&& rm -rf /usr/local/tomcat/webapps/* \
	&& mv /tmp/DataSource.groovy grails-app/conf/ \
	&& JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64 ./grailsw war /usr/local/tomcat/webapps/ROOT.war \
	&& cp /usr/local/tomcat/webapps/ROOT.war /usr/local/tomcat/webapps/streama.war \
	&& apt-get remove -y openjdk-7-jdk \
	&& apt-get autoremove -y --purge

VOLUME ["/media/storage", "/data/streama"]

EXPOSE 8080

CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]

