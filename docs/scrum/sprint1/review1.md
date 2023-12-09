# Review del Sprint 1

## Resumen

Este documento detalla la revisión del primer sprint del proyecto, abarcando lo que se planeó hacer, lo que efectivamente se realizó, y los desafíos encontrados.

---

## Objetivos del Sprint 1

- Investigar y definir la infraestructura de la aplicación:
  - Servidor en Python.
  - Base de datos SQLite.
  - User en Flutter.
  - Comunicación mediante sockets TCP.
- Servidor:
  - Capacidad de recibir y enviar mensajes (singlethreading).
  - Interacción con la base de datos.
- User:
  - Capacidad de recibir y enviar mensajes con el servidor.
  - Interfaz básica para testing y verificación de funcionamiento.
- Base de datos:
  - Diseño inicial.

---

## Resultados Alcanzados

- Implementación de todos los objetivos iniciales.
- Servidor con capacidad multithreading.
- Desarrollo de casos de uso.
- Diseño avanzado y escalable de la base de datos.
- Diseño escalable de mensajes.
- Documentación adicional generada y añadida.

---

## Desafíos y Problemas Encontrados

- Falta de claridad en la aplicación antes de comenzar a implementar:
- Problemas con la librería de sockets TCP (`dart:io`) que no funciona para web.