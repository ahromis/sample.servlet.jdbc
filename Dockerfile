FROM websphere-liberty:webProfile7

ENV LICENSE accept
ENV DERBY_KEY aade6f4eaa2504fc04dc561fc3e7c374
ENV DERBY_VERSION 10.13.1.1

RUN wget -q http://mirror.olnevhost.net/pub/apache//db/derby/db-derby-$DERBY_VERSION/db-derby-$DERBY_VERSION-bin.tar.gz -O /tmp/db-derby-$DERBY_VERSION-bin.tar.gz && \
	cd /tmp && \
	echo $DERBY_KEY db-derby-$DERBY_VERSION-bin.tar.gz | md5sum -c && \
	tar zxf db-derby-$DERBY_VERSION-bin.tar.gz && \
	cp db-derby-$DERBY_VERSION-bin/lib/derby.jar /opt/ibm/wlp/usr/shared/resources/derby-$DERBY_VERSION.jar && \
	rm -rf /tmp/*
COPY target/liberty/wlp/usr/servers/defaultServer/server.xml /config/server.xml
COPY target/liberty/wlp/usr/servers/defaultServer/bootstrap.properties /config/bootstrap.properties
COPY target/*.war /config/apps/JDBCApp.war
