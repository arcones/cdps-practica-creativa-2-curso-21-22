# cdps-practica-creativa-2

## Despliegue de aplicación en máquina virtual pesada

### Requisitos

- Máquina virtual con Ubuntu instalado

### Pasos a seguir

1. Preparar el tarball necesario para suministrar a la máquina:

```bash
    ./prepareTarball.sh
```

2. Iniciar una sesión ssh en la máquina virtual y una vez dentro usar la funcionalidad siguiente para subir el tarball creado en el paso anterior (cdps-pc2.tar.gz):

![upload to vm button](./upload_to_vm.png)

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

5. Finalmente, para levantar el servicio bookstore, ejecutar:

```bash
    ./runBookStore.sh
```