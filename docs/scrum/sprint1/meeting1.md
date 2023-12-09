# Resumen de la Reunión Scrum
**date:** 		28/10/2023  
**Equipo:** 	Los Niños de Adolfo  
**Sprint:** 	1  

---

## 1. Participantes:
- Montejano Gómez, Hiram
- Rovira Martínez, Daniel
- Sánchez Verdú, Joan
- Segovia Martínez, Pablo

---

## 2. Tipo de Reunión: 
Revisión del sprint

---

## 3. Puntos Destacados:

### **Reportes individuales:**

#### **Daniel:** 
- Progreso con el networking entre aplicaciones Python (en concreto, sockets).
- La implementación actual solo permite conexión de servidor con 1 User.
- Se plantea la posibilidad de usar la librería de Python `asyncio` para multithreading.

#### **Joan:** 
- Presenta el primer esquema de la base de datos.
- Se sugiere extraer la columna “tag” de la tabla “Product” a su propia tabla n:n.
- Posibles ampliaciones:
  - Múltiples addresses con tabla 1:n.
  - Múltiples payments con tabla 1:n.

#### **Hiram:** 
- Conexión exitosa a la base de datos SQLite desde Python utilizando `import sqlite3`.
- Ejecución de scripts con posibilidad de generarse con MySQL Workbench.

#### **Pablo:** 
- Informe sobre las primeras soluciones de interacción entre Flutter y Python.
- Uso de la librería `dart.py` descartado.
- Evaluación de las librerías Django y Flask.
  - Flask supera a Django por ser más ligero y generar menos código no deseado.
  - Sin usar librerías, desde Flutter se logró enviar un JSON mediante HTTP(S) usando `send` y recibirlo con `get` usando funciones de `http.dart`. (¿Existen funciones para HTTPS?)

---

## 4. Acciones a Seguir/Próximos Pasos:
- Crear páginas para testing desde Flutter (login e interacción con base de datos).
- Definir funciones de comunicación desde Flutter con sockets TCP e integrarlas a la interfaz.
- Empezar el servidor de Python para interacción con la base de datos y por sockets TCP, desarrollando la lógica de negocio.
- Diseñar la estructura de la base de datos.