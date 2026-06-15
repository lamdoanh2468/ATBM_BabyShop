FROM tomcat:11-jre21

# Deploy WAR under /BE context.
COPY target/BE-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/BE.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
