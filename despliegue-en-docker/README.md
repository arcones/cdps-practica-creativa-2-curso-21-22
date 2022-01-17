## Despliegue de aplicación en contenedor docker

### Decisiones de diseño tomadas
TODO

##### Pasos a seguir

1. Construir la imagen:

```bash
    docker build -f Dockerfile -t equipo-09:bookstore .
```

2. Correr la imagen haciendo el mapeo de puertos correspondiente, por ejemplo si se usa el puerto 8080 de la máquina anfitriona:


```bash
    docker run -dp 8080:9080 --name bookstore equipo-09/bookstore:1.0.0
```

La aplicación bookstore podrá ser accedida por el navegador en http://localhost:8080


TODO detalles enunciado
TODO docker run con environament parametrizao