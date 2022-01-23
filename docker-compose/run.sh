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
docker-compose rm -f -v && docker-compose --env-file envs/$1.env up --build --force-recreate --remove-orphans<img  align="left" width="150" style="float: left;" src="https://www.upm.es/sfs/Rectorado/Gabinete%20del%20Rector/Logos/UPM/CEI/LOGOTIPO%20leyenda%20color%20JPG%20p.png">
<img  align="right" width="60" style="float: right;" src="https://www.dit.upm.es/images/dit08.gif">

