#!/bin/bash

# Clean up cluster
#kubectl delete --all deployments && kubectl delete --all pods && kubectl delete --all services

kubectl apply -f details

DETAILS_HOSTNAME=`kubectl get services details-service -o json | jq -r '.spec.clusterIP'`

echo "El host donde corre el servicio de details es el ${DETAILS_HOSTNAME}"

cat productpage/productpage-deployment.yaml | sed "s/{{DETAILS_HOSTNAME}}/$DETAILS_HOSTNAME/g" | kubectl apply -f -

kubectl apply -f productpage/productpage-service.yaml

watch kubectl get services