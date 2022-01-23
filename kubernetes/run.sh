#!/bin/bash

# Clean up cluster
kubectl delete --all deployments && kubectl delete --all pods && kubectl delete --all services


kubectl apply -f details
kubectl apply -f reviews

DETAILS_HOSTNAME=`kubectl get services details-service -o json | jq -r '.spec.clusterIP'`
REVIEWS_HOSTNAME=`kubectl get services reviews-service -o json | jq -r '.spec.clusterIP'`

echo "El host donde corre el servicio de details es el ${DETAILS_HOSTNAME}"
echo "El host donde corre el servicio de reviews es el ${REVIEWS_HOSTNAME}"

cat productpage/templates/productpage-deployment.tpl | \
    sed "s/{{REVIEWS_HOSTNAME}}/$REVIEWS_HOSTNAME/g" | \
    sed "s/{{DETAILS_HOSTNAME}}/$DETAILS_HOSTNAME/g" > productpage/productpage-deployment.yaml

kubectl apply -f productpage

watch kubectl get services