#!/bin/bash

# Check if Tomcat is running 
if ! pgrep -x "tomcat" > /dev/null
then
    echo "Tomcat is not running!"
    exit 1
else
    echo "Tomcat is running fine."
fi


URL="http://tomcat-alb-151555836.us-east-1.elb.amazonaws.com/hello-world-maven/"
HTTP_STATUS=$(curl --write-out "%{http_code}" --silent --output /dev/null $URL)

if [ "$HTTP_STATUS" -eq 200 ]; then
    echo "Application is up and healthy!"
else
    echo "Application health check failed with status code: $HTTP_STATUS"
    exit 1
fi

# You could add additional checks or logging as needed here

exit 0
