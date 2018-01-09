FROM jetty:9.3.11-jre8-alpine

# Mount the keystore here
VOLUME $JETTY_HOME/etc/keystore_mount
#VOLUME $JETTY_HOME/etc/sso

# These are defaults, change them
ENV SSO_AUTH_MYSQL_URL=localhost
ENV SSO_AUTH_MYSQL_USERNAME=root
ENV SSO_AUTH_MYSQL_PASSWORD=password

ENV JETTY_KEYSTORE_PASSWORD=CHANGEME
# The relative path from $JETTY_HOME/etc/keystore_mount your keystore is placed in
ENV JETTY_KEYSTORE_RELATIVE_PATH=keystore

WORKDIR $JETTY_HOME

COPY target/accounts.war /opt/accounts.war
COPY accounts.xml "$JETTY_HOME/webapps/accounts.xml"
COPY run-webapp.sh "$JETTY_HOME/run-webapp.sh"
RUN chmod +x "$JETTY_HOME/run-webapp.sh"

RUN echo '--module=https' >> "$JETTY_HOME/start.ini"; \
    echo '--module=ssl' >> "$JETTY_HOME/start.ini"; \
    echo '--module=resources' >> "$JETTY_HOME/start.ini";
    #echo jetty.sslContext.trustStorePassword=`cat passobf` >> "$JETTY_HOME/modules/ssl.mod"; \
    #echo jetty.sslContext.keyStorePassword=`cat passobf` >> "$JETTY_HOME/modules/ssl.mod"; \
    #echo jetty.sslContext.keyManagerPassword=`cat passobf` >> "$JETTY_HOME/modules/ssl.mod"; \ 

ENTRYPOINT /bin/sh ./run-webapp.sh