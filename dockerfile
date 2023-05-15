FROM tomcat:10

# Set the environment variables
ENV TOMCAT_USER=admin
ENV TOMCAT_PASSWORD=password
ENV WAR_FILE=ABCtechnologies-1.0.war

# Set the working directory
WORKDIR /app

# Copy the war file to the webapps directory
COPY ABCtechnologies-1.0.war /usr/local/tomcat/webapps/

# Add a script to automatically deploy the war file when the container starts
COPY deploy.sh /usr/local/tomcat/bin/
RUN chmod +x /usr/local/tomcat/bin/deploy.sh
SHELL ["/bin/bash", "-c"]

# Expose the Tomcat port
EXPOSE 8080

# Start Tomcat and deploy the war file
CMD ["/usr/local/tomcat/bin/deploy.sh"]
