# Despliegue de aplicación en contenedor docker

## Requisitos
- Docker engine instalado

## Decisiones de diseño tomadas
* Como ya se disponía de un script python para descargar, instalar y correr la aplicación, se ha reutilizado en este apartado con algunos cambios para delegar, por ejemplo la creación de la variable de entorno `GROUP_NUMBER` en el [Dockerfile](./Dockerfile)

## Comentarios acerca de la fiabilidad y escalabilidad de esta solución
* Esta solución es mucho más fiable que la máquina virtual pues al utilizar una imagen base fija, nos estamos asegurando de que el entorno donde corre la aplicación no cambie.
* Sin embargo, los problemas de escalabilidad son los mismos que en el apartado de máquinas virtuales pues estamos creando un único contenedor, por lo tanto, podremos escalar verticalmente pero no horizontalmente y como se ha comentado, los puntos únicos de fallo serán varios: el runtime de contenedores, el contenedor en sí mismo, la conexión de red del equipo si se quiere servir a otros hosts, la propia máquina anfitriona... etc.

## Pasos a seguir

1. Construir la imagen:

```bash
    docker build -f Dockerfile -t equipo9/bookstore .
```

2. Correr la imagen haciendo el mapeo de puertos correspondiente, por ejemplo si se usa el puerto 8080 de la máquina anfitriona:


```bash
    docker run -p 8080:9080 -e "GROUP_NUMBER=9" --name equipo9-bookstore equipo9/bookstore
```

3. También se ha subido la imagen a dockerhub así que se puede correr directamente en cualquier equipo con docker engine instalado con:

```bash
    docker run -p 8080:9080 -e "GROUP_NUMBER=9" --name equipo9-bookstore arcones/bookstore:9
```

La aplicación bookstore podrá ser accedida por el navegador en http://localhost:8080/productpage