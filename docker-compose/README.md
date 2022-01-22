## Despliegue de aplicación basada en microservicios utilizando docker-compose

### Decisiones de diseño tomadas
* Se ha decidido delegar en docker-compose la creación de los contenedores, usando la directiva `build` en cada una de las imágenes configuradas en el `docker-compose.yml`
* Se usan ficheros con la configuración de los distintos entornos para parametrizar la versión de `Reviews` y el color de las estrellas en cada momento
* Se proporciona un script bash para limpiar contenedores y ficheros de ejecucciones anteriores, bajarse los fuentes y compilarlos y finalmente ejecutar la orden de docker-compose que levanta el entorno con la configuración seleccionada

##### Pasos a seguir

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