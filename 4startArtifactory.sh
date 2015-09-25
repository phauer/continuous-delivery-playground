#! /bin/bash
VERSION=4.1.2
export ARTIFACTORY_HOME=/var/opt/jfrog/artifactory

docker pull jfrog-docker-registry.bintray.io/jfrog/artifactory-pro:$VERSION
docker run -d --name artifactory -p 8081:8081 -v $ARTIFACTORY_HOME/data -v $ARTIFACTORY_HOME/logs -v $ARTIFACTORY_HOME/backup -v $ARTIFACTORY_HOME/etc jfrog-docker-registry.bintray.io/jfrog/artifactory-pro:$VERSION

echo "Please wait a while and access Artifactory via http://localhost:8081/artifactory"