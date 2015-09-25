#! /bin/bash
# add 'source <pathToThisFile>/docker-util.sh' to ~/.bashrc. This makes this functions available in your shell.
docker-remove-stopped(){
	#docker rm $(docker ps -a -q)
	docker ps -a -q | xargs docker rm
}

docker-nuke() {
	docker ps -q | xargs docker stop
	docker ps -q -a | xargs docker rm
}
docker-rmi-none() {
	docker images | grep '<none>' | \
	awk '{ print $3 }' | \
	xargs docker rmi
}
docker-go() {
	docker run --rm -t -i $@
}	




