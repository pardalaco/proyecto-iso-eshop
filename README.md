# Eshop

## Propósito del proyecto

El proyecto fue desarrollado para cubrir la parte de prácticas de la asignatura Ingeniería de Software, del tercer año de carrera, en la Universidad Politécnica de Valencia (UPV).

La intención de trabajar en este proyecto es totalmente pedagógica. Este proyecto sirvió para aprender a cómo crear, desarrollar y gestionar un proyecto.

## Objetivos

Objetivo principal:
- Desarrollar un proyecto de software desde cero.
- Diseñar una aplicación funcional.

Objetivos transversales:
- Diseñar y crear la base de datos.
- Diseñar y crear el servidor.
  - Crear un CLI. Una aplicación por línea de comandos que nos permita gestionar el servidor.
  - Interconectar el servidor con la base de datos.
  - Interconectar el servidor con la interfaz.
- Diseñar y crear una interfaz funcional.

## Integrantes y sus aportaciones dentro del proyecto

- Joan Sánchez Verdú
   - Diseño de la base de datos.
   - Desarrollo de la base de datos.
- Hiram Montejano Gómez
  - Diseño del servidor.
  - Desarrollo del servidor.
  - Desarrollo del CLI.
- Pablo Segovia Martínez
  - Desarrollo de la interfaz.
- Daniel Rovira Martínez
  - Diseño del diagrama de flujo de la interfaz.
  - Desarrollo de la interfaz.

## Requisitos de ejecución

- Tener ```python3``` instalado.
- Tener ```Flutter``` instalado.
- Tener ```SQLite``` instalado.
- Tener ```Visual Studio Code``` instalado.
  - Tener la extensión ```flutter``` instalada.
  - Tener la extensión de ```Dart```.

## Instalación

- Abrimos el proyecto con Visual Studio Code.
- Una vez abierto el proyecto, importamos los paquetes necesarios con:
  ```
  flutter: get packages
  ```

- Creamos la base de datos, para ello:
  - Nos metemos en la carpeta ```database```.
  - Ejecutamos los dos archivos con python.
    ```
    $ python3 createDB.py
    $ python3 fillAndTest.py
    ```
  - Hay que ejecutar primero ```createDB.py```.
  - Posteriormente ejecutamos ```fillAndTest.py```.

- Iniciamos el servidor, para ello:
  - Nos metemos en la ```carpeta server/bin```.
  - Ejecutamos con python3 el archivo.
    ```
    $ python3 run_server.py
    ```
  - A partir de ahora, el servidor estará iniciado. Por defecto, se inicia en localhost.

- Iniciamos la aplicación
  - Desde Visual Studio Code, si tenemos todo bien configurado, deberíamos poder ejecutar la aplicación sin ningún problema, desplegándola en un Emulador de Android.

## Observaciones

Para obtener más información sobre cómo se hizo el proyecto o más documentación, ir a la carpeta ```dev```.
