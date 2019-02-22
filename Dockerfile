FROM jetty:9.4.12-jre8-alpine

# These are defaults, change them
ENV SSO_AUTH_MYSQL_URL=localhost
ENV SSO_AUTH_MYSQL_USERNAME=root
ENV SSO_AUTH_MYSQL_PASSWORD=password

# Password for the certificate keystore
ENV JETTY_KEYSTORE_PASSWORD=CHANGEME

# If set to a non-empty string, the keystore will be imported into the trust
# store. This is necessary if your SSL certificates are not trusted by java
# by default, i.e. self-signed
ENV TRUST_KEYSTORE=

# Copy in war file and associated configuration xml
COPY accounts.xml "$JETTY_BASE/webapps/accounts.xml"
COPY target/accounts.war /opt/accounts.war

# Add in new entrypoint script
USER root
RUN mv /docker-entrypoint.sh /jetty-docker-entrypoint.sh
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh