#!/bin/bash

# Clean up from previous executions
chown -R $USER app && rm -rf app

# Download application sources
git clone https://github.com/CDPS-ETSIT/practica_creativa2.git app

# Compile Java microservice
cd app/bookinfo/src/reviews
docker run --rm -u root -v "$(pwd)":/home/gradle/project -w /home/gradle/project gradle:4.8.1 gradle clean build

# Run all containers
cd -
docker-compose rm -f -v && docker-compose --env-file envs/$1.env up --build --force-recreate --remove-orphans