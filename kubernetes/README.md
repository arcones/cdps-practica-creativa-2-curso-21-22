# Despliegue de aplicación basada en microservicios utilizando kubernetes

## Requisitos

- Clúster GKE con 5 nodos sin autoescalado

## Decisiones de diseño tomadas
* Para este sistema se ha utilizado la versión 2 de `Reviews` que usa `Ratings` para mostrar las estrellas de color rojo.
* Las imágenes requeridas se han subido todas a docker hub para simplificar la creación de los pods y servicios.
* Además, se provee de un único script de arranque, que, teniendo conexión con al clúster de Kubernetes y el `namespace` por defecto configurado correctamente, se encarga de limpiar cualquier configuración de ejecucciones anteriores y crear los pods y servicios necesarios. Para los servicios dependendientes de otros, como `Productpage` y `Reviews`, se utilizan plantillas para generar sus ficheros de despliegue usando `sed`, antes de lanzarlos al clúster.
* Además se ha intentado que la solución sea lo más idempotente posible, incluyendo en el script una limpieza previa de ejecuciones anteriores.

## Comentarios acerca de la fiabilidad y escalabilidad de esta solución
* La solución configurada en esta práctica es altamente fiable ya que se ha aplicado redundancia en algunos pods y además se ha distribuido la carga en los distintos nodos que componen el clúster. Esto hace que el sistema pueda aguantar de la caida de un pod o nodo mientras el máster de Kubernetes reconcilia el clúster para que la configuración se cumpla nuevamente.
* Kubernetes provee de las herramientas necesarias para escalar el sistema rápidamente, tanto manualmente añadiendo más nodos, como usando la función de autoescalado que, en momentos de alta demanda en los que los pods estén al límite de su capacidad, el clúster se encargue de correr más pods en otros nodos, estos últimos pudiéndose también crear en el momento.
* Además podemos configurar las réplicas de cada pod para que se reduden en nodos distintos si hay capacidad suficiente, haciendo que el riesgo de fallo de un nodo no comprometa nuestro servicio. Incluso podemos configurar el clúster para que los nodos estén en distintas regiones geográficas, evitando así que el riesgo de catástrofes naturales en un área, afecten a nuestro servicio.

## Pasos a seguir

1. Correr el script:

```bash
    ./run.sh
```

Cuando se asigne la IP externa del servicio `productpage-service`, se podrá acceder a través del navegador y del puerto `9080` al servicio.