#! /bin/bash
JENKINS_PORT=8090
JENKINS_CONTAINER_NAME=jenkins
JENKINS_HOME=~/jenkins_home

mkdir $JENKINS_HOME

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
docker run -d --name $JENKINS_CONTAINER_NAME \
	-p $JENKINS_PORT:8080 -p 50000:50000 \
	-v $JENKINS_HOME:/var/jenkins_home \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v $(which docker):/bin/docker \
	-v /usr/lib/x86_64-linux-gnu/libapparmor.so.1.1.0:/lib/x86_64-linux-gnu/libapparmor.so.1 \
	-u root \
	jenkins:1.609.3

#the last 3 volume bindings are important in order to enable jenkins to run docker, see 
#http://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/