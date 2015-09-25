#! /bin/bash
# https://hub.docker.com/r/sameersbn/gitlab/
# https://github.com/sameersbn/docker-gitlab

#TODO use docker-compose instead (see doc)

#postgresql
docker run --name gitlab-postgresql -d \
    --env 'DB_NAME=gitlabhq_production' \
    --env 'DB_USER=gitlab' --env 'DB_PASS=password' \
    --volume /srv/docker/gitlab/postgresql:/var/lib/postgresql \
    sameersbn/postgresql:9.4-3

#redis
docker run --name gitlab-redis -d \
    --volume /srv/docker/gitlab/redis:/var/lib/redis \
    sameersbn/redis:latest

#gitlab
docker run --name gitlab -d \
    --link gitlab-postgresql:postgresql --link gitlab-redis:redisio \
    --publish 10022:22 --publish 10080:80 \
    --env 'GITLAB_PORT=10080' --env 'GITLAB_SSH_PORT=10022' \
    --volume /srv/docker/gitlab/gitlab:/home/git/data \
sameersbn/gitlab:7.14.3

echo "NOTE: Please allow a couple of minutes for the GitLab application to start."
echo "Port: 10080. user: root. default pw: 5iveL!fe or changed to 12345678"
