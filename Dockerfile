FROM java:7

MAINTAINER Tomohisa Kusano <siomiz@gmail.com>

ADD https://github.com/dularion/streama/archive/master.tar.gz /tmp/
COPY DataSource.groovy /tmp/

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

WORKDIR /opt/streama

RUN tar zxvf /tmp/master.tar.gz --strip-components=1 \
	&& rm /tmp/master.tar.gz \
	&& mv /tmp/DataSource.groovy grails-app/conf/ \
	&& ./grailsw war

VOLUME ["/media/storage", "/data/streama"]

EXPOSE 8080

CMD ["/opt/streama/grailsw", "run-war"]

