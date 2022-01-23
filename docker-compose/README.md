# Despliegue de aplicación basada en microservicios utilizando docker-compose

## Decisiones de diseño tomadas
* Se ha decidido delegar en docker-compose la creación de los contenedores, usando la directiva `build` en cada una de las imágenes configuradas en el `docker-compose.yml`
* Se usan ficheros con la configuración de los distintos entornos para parametrizar la versión de `Reviews` y el color de las estrellas en cada momento
* Se proporciona un script bash para limpiar contenedores y ficheros de ejecucciones anteriores, bajarse los fuentes y compilarlos y finalmente ejecutar la orden de docker-compose que levanta el entorno con la configuración seleccionada

## Comentarios acerca de la fiabilidad y escalabilidad de esta solución
* La solución de este apartado es más compleja que la de los dos anteriores, pues hay que gestionar cuatro contenedores a la vez, además de la configuración para hacerlos trabajar juntos
* Sin embargo, una vez listas las configuraciones y ficheros necesarios, la solución es más fiable porque está distribuida: que se caiga mi servicio de reviews no hará que la página productpage deje de servir el resto de información por lo que mi sistema seguirá proveyendo algunos servicios
* Además en esta solución, si veo que uno de los microservicios está expuesto a gran demanda de tráfico, asimétrica con el tráfico que reciben el resto de contenedores, puedo escalarlo individualmente. Un caso típico de esta situación son las redes sociales, donde las APIs de lectura de la información (por ejemplo, leer un tweet) sirven muchas más peticiones que las de escritura de información (por ejemplo, escribir un tweet) por lo que los microservicios de lectura tienen asignados muchos más recursos que los de escritura, ya sea horizontal (más contendores en paralelo) o verticalmente (contenedores con más recursos asignados)

## Pasos a seguir

1. Construir la imagen ejecutando el script anteriormente mencionado con `sudo`:

```bash
    sudo ./run.sh
```

Para ejecutar la aplicación con otras versiones, simplemente pasarlo como parámetro, por ejemplo:

```bash
    sudo ./run.sh v2 # Para la versión con estrellas de color negro
    sudo ./run.sh v3 # Para la versión con estrellas de color rojo
```

La aplicación bookstore podrá ser accedida por el navegador en http://localhost:9080/productpage