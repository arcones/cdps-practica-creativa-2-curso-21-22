### Despliegue en máquina virtual de Google Cloud Platform

#### Requisitos

- Máquina virtual con Ubuntu instalado y el puerto 80 (HTTP) abierto

### Decisiones de diseño tomadas
* La máquina virtual se preparara instalando pyenv y con esta funcionalidad se instala una versión específica de python y pip, para evitar problemas con la distintas versiones de python y/o dependencias si se delegase en la versión de python que viene por defecto con el sistema operativo
* La aplicación bookstore se levanta en el puerto designado (el indicado en los argumentos de entrada al programa o, en su defecto, el predeterminado), pero este puerto no se expone a Internet. En lugar de esto se usa `socat` para hacer una redirección del tráfico del puerto de la aplicación al 80, y así que las conexiones desde Internet a la máquina se hagan sin la necesidad de explicitar el puerto. El objetivo de esto es aprovechar la configuración que trae Google Cloud Platform por defecto para el puerto 80, que a buen seguro será más fiable que cualquier configuración que podamos hacer el máquina para exponer otro puerto manualmente.

#### Pasos a seguir

1. Preparar el tarball necesario para suministrar a la máquina:

```bash
    cd ./despliegue-en-gcp && ./prepareTarball.sh
```

2. Iniciar una sesión ssh en la máquina virtual y una vez dentro usar la funcionalidad siguiente para subir el tarball creado en el paso anterior (cdps-pc2.tar.gz):

![upload to vm button](./img/upload_to_vm.png)

3. Dentro de la consola de la máquina virtual, descomprimir el tarball y ejecutar el script que instalará el entorno python necesario:

```bash
    rm -rf bookstore && mkdir bookstore && \
        tar xvf cdps-pc2.tar.gz -C bookstore && \
        rm -rf cdps-pc2.tar.gz && cd bookstore && \
        ./setupVM.sh
```

4. Reiniciar la shell para aplicar los cambios

```bash
    source ~/.profile
```

5. Establecer el valor de la variable de entorno que completará el título de la web:

```bash
    export GROUP_NUMBER="Equipo 09"
```

6. Finalmente, para levantar el servicio bookstore, ejecutar:

```bash
    ./runBookStore.sh
```

Si se quiere correr la aplicación en un puerto distinto, pasarlo como argumento, por ejemplo:

```bash
    ./runBookStore.sh 9181
```

Aparecerá un mensaje con la URL pública de la aplicación para acceder desde fuera de la máquina.