#! /bin/bash
PORT=5000
docker run -d -p $PORT:5000 --name registry registry:2

echo "Docker Registry runs on port $PORT"
echo "Prefix tag with localhost:5000 so that it points to the registry"