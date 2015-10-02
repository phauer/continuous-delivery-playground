#! /bin/bash
JENKINS_PORT=8090
JENKINS_CONTAINER_NAME=jenkins
JENKINS_HOME=~/jenkins_home

JenkinsContainerId=`docker ps -qa --filter "name=$JENKINS_CONTAINER_NAME"`
if [ -n "$JenkinsContainerId" ]
then
	echo "Stopping and removing existing jenkins container"
	docker stop $JENKINS_CONTAINER_NAME
	docker rm $JENKINS_CONTAINER_NAME
fi

echo "Starting jenkins container on port $JENKINS_PORT and jenkins home is $JENKINS_HOME"
# https://github.com/jenkinsci/docker
# https://hub.docker.com/r/jenkinsci/jenkins/tags/
# /var/jenkins_home contains all plugins and configuration
docker run -d --name $JENKINS_CONTAINER_NAME -p $JENKINS_PORT:8080 -p 50000:50000 -v $JENKINS_HOME:/var/jenkins_home jenkins:1.609.3

