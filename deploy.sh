#!/bin/bash

# Start Tomcat with the specified credentials
/usr/local/tomcat/bin/catalina.sh start

# Wait for Tomcat to fully start
sleep 10

# Deploy the WAR file
curl --retry 10 --retry-delay 5 --retry-connrefused -u $TOMCAT_USER:$TOMCAT_PASSWORD -X PUT \
  -H "Content-Type: application/octet-stream" \
  --data-binary @/usr/local/tomcat/webapps/$WAR_FILE \
  http://localhost:8080/manager/text/deploy?path=/$WAR_FILE

# Tail the Tomcat log
tail -f /usr/local/tomcat/logs/catalina.out
