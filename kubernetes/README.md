# Despliegue de aplicación basada en microservicios utilizando kubernetes

## Requisitos

- Clúster GKE con 5 nodos sin autoescalado

## Decisiones de diseño tomadas

## Comentarios acerca de la fiabilidad y escalabilidad de esta solución
### TODO

## Pasos a seguir


kubectl get service productpage-service -o json | jq -r '. |  "http://" + .status.loadBalancer.ingress[0].ip + ":" + (.spec.ports[0].targetPort|tostring) + "/productpage"'
kubectl get service productpage-service -o json | jq -r '. |  "http://" + .status.loadBalancer.ingress[0].ip + ":" + (.spec.ports[0].targetPort|tostring) + "/productpage"'

TODO
el servicio de reviews q sea la versión 3