# [Database Definition](https://dbdiagram.io/d/Proyecto-ISO-2023-24-6544d7f97d8bbd64656c2444)

```sql
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
  nombre varchar(80) [not null]
}

Table Carrito {
  ROWID INT [pk]
  email varchar(40) [not null]
  nombre VARCHAR(40) [note: "default Carrito"]
  total DECIMAL(7,2) [not null, note: "default 0"]
}

Table Contiene {
  idCarrito INT [pk]
  idProducto INT [pk]
  cantidad INT [not null, default: 1]
}

Table Producto {
  ROWID INT [pk]
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
  tag VARCHAR(45) [pk]
}

Table Pedido {
  ROWID INT [pk]
  email varchar(40) 
  direccion varchar(45) [not null]
  tarjeta VARCHAR(45) [not null]
  fecha date [not null]
  total DECIMAL(7,2) [not null, note: "default 0"]
  estado varchar(20) [not null, note: "default Pagado"]
}

Table LineaPedido {
  idPedido INT [pk]
  nombre VARCHAR(45) [pk] 
  idProducto INT
  cantidad INT [not null, default: 1]

}

Ref: Clasificacion.idProducto > Producto.ROWID
Ref: Clasificacion.tag > Tag.nombre 
Ref: Direccion.email > Cliente.email
Ref: Tarjeta.email > Cliente.email
Ref: Carrito.email > Cliente.email
Ref: Contiene.idCarrito > Carrito.ROWID //ON DELETE CASCADE
Ref: Contiene.idProducto > Producto.ROWID
Ref: Pedido.email > Cliente.email  // ON DELETE nul
Ref: LineaPedido.idPedido > Pedido.ROWID //ON DELETE CASCADE
Ref: LineaPedido.idProducto > Producto.ROWID //on delete nul
```