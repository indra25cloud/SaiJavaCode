# Use official Tomcat image
FROM tomcat:8-jre8

# Add a label instead of deprecated MAINTAINER
LABEL maintainer="sai4cs@gmail.com"

# Copy the WAR file into Tomcat webapps
COPY webapp.war /usr/local/tomcat/webapps/

# Optional: Copy default webapps content if needed
# RUN cp -R /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps/

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
