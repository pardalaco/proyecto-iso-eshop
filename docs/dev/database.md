# [Database Definition](https://dbdiagram.io/d/Proyecto-ISO-2023-24-6544d7f97d8bbd64656c2444)

```sql
Table Cliente {
  email varchar(40) [pk] 
  nombre varchar(45) 
  apellidos VARCHAR(70)
  pwd VARCHAR [not null]
  direccion VARCHAR(45)
  tarjeta VARCHAR(45)
  admin TINYINT [note: "default 0"]
}

Table Producto {
  id INT [pk]
  nombre VARCHAR(45) 
  descripcion VARCHAR(100) 
  imagen VARCHAR(80)
  precio DECIMAL(7,2) 
}

Table Tag {
  id INT [pk]
  nombre VARCHAR(45) [not null, unique]
}

Table Clasificacion {
  idProducto INT [pk]
  idTag INT [pk]
  }

Ref: Clasificacion.idProducto > Producto.id // many-to-one
Ref: Clasificacion.idTag > Tag.id // many-to-one

```