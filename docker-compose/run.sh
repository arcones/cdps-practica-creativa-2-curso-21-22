#!/bin/bash

# Clean up from previous executions
chown -R $USER app && rm -rf app
docker rmi -f $(docker images -aq) ;  docker rm -vf $(docker ps -a -q) ; docker rmi -f $(docker images -aq) ; docker rm -vf $(docker ps -a -q)

git clone https://github.com/CDPS-ETSIT/practica_creativa2.git app

cd app/bookinfo/src/reviews && \
    docker run --rm -u root -v "$(pwd)":/home/gradle/project -w /home/gradle/project gradle:4.8.1 gradle clean build

cd -

docker-compose rm -f && docker-compose up --force-recreate --remove-orphans