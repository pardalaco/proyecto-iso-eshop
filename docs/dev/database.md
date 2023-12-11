# [Database Definition](https://dbdiagram.io/d/Proyecto-ISO-2023-24-6544d7f97d8bbd64656c2444)

```sql
Table User {
  email varchar(40) [pk] 
  name varchar(45) [note: "default Mr"]
  password VARCHAR [not null]
  payment VARCHAR(45)
  address VARCHAR(45)
  admin TINYINT [note: "default 0"]
}

Table Cart {
  ROWID INT [pk]
  email varchar(40) [not null]
  name VARCHAR(40) [note: "default Cart"]
  total DECIMAL(7,2) [not null, note: "default 0"]
}

Table Contains {
  cart_id INT [pk]
  product_id INT [pk]
  quantity INT [not null, default: 1]
}

Table Product {
  ROWID INT [pk]
  name VARCHAR(45) [not null]
  description VARCHAR(100) [not null]
  image VARCHAR(80) [not null]
  price DECIMAL(7,2) [not null]
  rating INT [not null, note: "default 0"]  
  rating_count INT [not null, note: "default 0"]
}

Table Tag {
  name VARCHAR(45) [pk]
}

Table Classification {
  product_id INT [pk]
  tag VARCHAR(45) [pk]
}

Table ShopOrder {
  ROWID INT [pk]
  email varchar(40) 
  address varchar(45) [not null]
  payment VARCHAR(45) [not null]
  date DATE [not null]
  total DECIMAL(7,2) [not null, note: "default 0"]
  status varchar(20) [not null, note: "default Pagado"]
}

Table ShopOrderLine {
  order_id INT [pk]
  name VARCHAR(45) [pk]
  product_id INT
  quantity INT [not null, default: 1]
}

Table Marketing {
  email VARCHAR(40) [pk]
  tag VARCHAR(45) [pk]
  weight DECIMAL(7,2) [not null, note: "default 0.5"]
  counter INT [not null]
}

Table Feedback {
  email VARCHAR(45) [pk]
  product_id INT [pk]
  rating INT [not null]
  comment VARCHAR(100)
  date DATE [not null]
}

Ref: Classification.product_id > Product.ROWID
Ref: Classification.tag > Tag.name 
Ref: Cart.email > User.email
Ref: Contains.cart_id > Cart.ROWID //ON DELETE CASCADE
Ref: Contains.product_id > Product.ROWID
Ref: ShopOrder.email > User.email  // ON DELETE nul
Ref: ShopOrderLine.order_id > ShopOrder.ROWID //ON DELETE CASCADE
Ref: ShopOrderLine.product_id > Product.ROWID //ON DELETE SET NULL
Ref: Marketing.email > User.email //ON DELETE/UPDATE CASCADE
Ref: Marketing.tag > Tag.name //ON DELETE/UPDATE CASCADE
Ref: Feedback.email > User.email //ON DELETE/UPDATE CASCADE
Ref: Feedback.product_id > Product.ROWID //ON DELETE/UPDATE CASCADE
```