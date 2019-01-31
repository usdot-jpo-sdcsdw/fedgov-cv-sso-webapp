FROM jetty:9.3.11-jre8-alpine

# These are defaults, change them
ENV SSO_AUTH_MYSQL_URL=localhost
ENV SSO_AUTH_MYSQL_USERNAME=root
ENV SSO_AUTH_MYSQL_PASSWORD=password

# Password for the certificate keystore
ENV JETTY_KEYSTORE_PASSWORD=CHANGEME

# The relative path from $JETTY_HOME/etc/keystore_mount your keystore is placed in
ENV JETTY_KEYSTORE_RELATIVE_PATH=keystore

# Mount the keystore here
VOLUME $JETTY_HOME/etc/keystore_mount

WORKDIR $JETTY_HOME

# Copy in war file and associated configuration xml
COPY accounts.xml "$JETTY_HOME/webapps/accounts.xml"
COPY target/accounts.war /opt/accounts.war

# Add in new entrypoint script
RUN mv /docker-entrypoint.sh /jetty-docker-entrypoint.sh
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh