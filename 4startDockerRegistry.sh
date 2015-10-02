#! /bin/bash
PORT=5000
VOLUME_PATH=~/docker-registry-data
docker run -d -p $PORT:5000 --restart=always --name registry \
-v $VOLUME_PATH:/var/lib/registry \
  registry:2

echo "Docker Registry runs on port $PORT"
echo "Prefix tag with localhost:5000 so that it points to the registry"
echo "Access http://localhost:5000/v2/_catalog in the browser to show the content. Or http://localhost:5000/v2/prozu-service/tags/list"
echo "See https://docs.docker.com/registry/spec/api/#detail for documentation" 
echo "Also you can see the docker content in $VOLUME_PATH"
