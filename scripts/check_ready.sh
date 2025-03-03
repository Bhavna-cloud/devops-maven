#!/bin/bash

# Check if the application is fully ready 
while ! curl --silent --fail http://tomcat-alb-151555836.us-east-1.elb.amazonaws.com/hello-world-maven; do
    echo "Waiting for the application to be ready..."
    sleep 5
done
echo "Application is ready. Proceeding with traffic."
