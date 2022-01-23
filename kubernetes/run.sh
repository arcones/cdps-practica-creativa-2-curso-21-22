#!/bin/bash

# Clean up cluster
kubectl delete --all deployments && kubectl delete --all pods && kubectl delete --all services

# Create details service
kubectl apply -f details
DETAILS_HOSTNAME=`kubectl get services details-service -o json | jq -r '.spec.clusterIP'`
echo "El host donde corre el servicio de details es el ${DETAILS_HOSTNAME}"

# Create ratings service
kubectl apply -f ratings
RATINGS_HOSTNAME=`kubectl get services ratings-service -o json | jq -r '.spec.clusterIP'`
echo "El host donde corre el servicio de ratings es el ${RATINGS_HOSTNAME}"

# Create reviews service
cat reviews/templates/reviews-deployment.tpl | \
    sed "s/{{RATINGS_HOSTNAME}}/$RATINGS_HOSTNAME/g" > reviews/reviews-deployment.yaml

kubectl apply -f reviews
REVIEWS_HOSTNAME=`kubectl get services reviews-service -o json | jq -r '.spec.clusterIP'`
echo "El host donde corre el servicio de reviews es el ${REVIEWS_HOSTNAME}"

# Create productpage service
cat productpage/templates/productpage-deployment.tpl | \
    sed "s/{{REVIEWS_HOSTNAME}}/$REVIEWS_HOSTNAME/g" | \
    sed "s/{{DETAILS_HOSTNAME}}/$DETAILS_HOSTNAME/g" > productpage/productpage-deployment.yaml

kubectl apply -f productpage

watch kubectl get services