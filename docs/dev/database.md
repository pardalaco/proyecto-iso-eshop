# [Database Definition](https://dbdiagram.io/d/Proyecto-ISO-2023-24-6544d7f97d8bbd64656c2444)

```sql
-- Definición BBDD Proyecto ISO 2023/2024

Table Cliente {
  email varchar(40) [pk] 
  nombre varchar(45) [note: "default Mr"]
  apellidos VARCHAR(70) [note: "default Robberino"]
  pwd VARCHAR [not null]
  admin TINYINT [note: "default 0"]
}

Table Direccion {
  email varchar(40) [pk]
  direccion VARCHAR(45) [pk]

}

Table Tarjeta {
  email varchar(40) [pk]
  tarjeta VARCHAR(45) [pk]
}

Table Carrito {
  email varchar(40) [pk]
  total DECIMAL(7,2) [not null, note: "default 0"]
}

Table Contiene {
  email varchar(40) [pk]
  idProducto INT [pk]
  cantidad INT [not null, default: 1]
}

Table Producto {
  id INT [pk]
  nombre VARCHAR(45) [not null]
  descripcion VARCHAR(100) [not null]
  imagen VARCHAR(80) [not null]
  precio DECIMAL(7,2) [not null]
}

Table Tag {
  nombre VARCHAR(45) [pk]
}

Table Clasificacion {
  idProducto INT [pk]
  tag INT [pk]
}

Ref: Clasificacion.idProducto > Producto.id
Ref: Clasificacion.tag > Tag.nombre 
Ref: Direccion.email > Cliente.email
Ref: Tarjeta.email > Cliente.email
Ref: Carrito.email > Cliente.email
Ref: Contiene.email > Carrito.email
Ref: Contiene.idProducto > Producto.id
```