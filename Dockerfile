FROM tomcat:8-jre8
LABEL maintainer="sai4cs@gmail.com"

# Copy WAR from Maven target folder
COPY ./target/webapp.war /usr/local/tomcat/webapps/

# Ensure default Tomcat apps are copied
RUN cp -R /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps
