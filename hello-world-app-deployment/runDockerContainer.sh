#! /bin/bash

DOCKER_REPO=192.168.35.217:5000/hello-world-app
TAG=0.0.1-SNAPSHOT
CONTAINER_NAME=hello-world-app

docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME
docker run -d --name $CONTAINER_NAME -p 8080:8080 $DOCKER_REPO:$TAG
#use -d to run in background
#use -it to run in foreground and get the output. add --rm to remove the container (container's file system) when it exits.




