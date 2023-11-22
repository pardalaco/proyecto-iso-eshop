# [Database Definition](https://dbdiagram.io/d/Proyecto-ISO-2023-24-6544d7f97d8bbd64656c2444)

```sql
// Definición BBDD Proyecto ISO 2023/2024

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
  id INT [pk]
  email varchar(40) [not null]
  total DECIMAL(7,2) [not null, note: "default 0"]
}

Table Contiene {
  idCarrito INT [pk]
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
  tag VARCHAR(45) [pk]
}

Table Pedido {
  id INT [pk]
  email varchar(40) 
  direccion varchar(45) [not null]
  tarjeta VARCHAR(45) [not null]
  total DECIMAL(7,2) [not null, note: "default 0"]
  estado varchar(20) [not null, note: "default Pagado"]
}

Table LineaPedido {
  idPedido INT [pk]
  idProducto INT [pk]
  cantidad INT [not null, default: 1]

}

Ref: Clasificacion.idProducto > Producto.id
Ref: Clasificacion.tag > Tag.nombre 
Ref: Direccion.email > Cliente.email
Ref: Tarjeta.email > Cliente.email
Ref: Carrito.email > Cliente.email
Ref: Contiene.idCarrito > Carrito.id //ON DELETE CASCADE
Ref: Contiene.idProducto > Producto.id
Ref: Pedido.email > Cliente.email  // ON DELETE nul
Ref: LineaPedido.idPedido > Pedido.id //ON DELETE CASCADE

/*
Procedimiento aproximado de creación de un pedido:
  1º Tener un carrito con productos
  2º Selección "crear pedido" dentro del carrito
    2.1 Almacenar el id del carrito seleccionado (p.ej carritoSelect)
    2.2 Almacenar el email del cliente que ha creado el pedido (p.ej mailSelect)
    2.3 Crear pedido implica insertar un nuevo pedido en la tabla pedido, con el email=mailSelect, pedido.total = carritoSelect.total y estado = Invoiced
  3º INSERT todos los productos del carrito selccionado (SELECT * FROM contiene WHERE idCarrito=carritoSelect) (Ver SELECT INTO en SQLite si existe para insertar en base a una selección)
  4º Eliminar carrito (DELETE FROM carrito WHERE id=carritoSelect)

Modificación
  1º Solo si el usuario es admin, podra modificar el estado del pedido (UPDATE Pedido SET estado = loquesea WHERE id = elquedebacambiar)
  2º El usuario podrá cancelar el pedido SOLO si estado = Invoiced
      (Podría ayudar una función "getEstadoPedido(int id)" donde obtenemos el estado de un pedido especificado como parámetro (SELECT estado FROM pedido WHERE id = idParametro))
    2.1 Caneclar el pedido (DELETE FROM pedido WHERE id = pedidoCancelado)
*/



Ref: "Carrito"."email" < "Cliente"."admin"
```