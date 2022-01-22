#!/bin/bash

cd dockerfiles

# Clean up from previous executions
chown -R $USER app && rm -rf app

# Download application sources
git clone https://github.com/CDPS-ETSIT/practica_creativa2.git app

# Compile Java microservice
cd app/bookinfo/src/reviews
docker run --rm -u root -v "$(pwd)":/home/gradle/project -w /home/gradle/project gradle:4.8.1 gradle clean build

cd -

# Create containers and push them to registry
docker login

docker build -f ProductPage_Dockerfile -t arcones/equipo9-k8s-productpage . && docker push arcones/equipo9-k8s-productpage
docker build -f Details_Dockerfile -t arcones/equipo9-k8s-details . && docker push arcones/equipo9-k8s-details
docker build -f Reviews_Dockerfile -t arcones/equipo9-k8s-reviews . && docker push arcones/equipo9-k8s-reviews
docker build -f Ratings_Dockerfile -t arcones/equipo9-k8s-ratings . && docker push arcones/equipo9-k8s-ratings



cd ..