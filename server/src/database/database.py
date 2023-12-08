#  * @copyright   This file is part of the "eshop - proyecto iso" project.
#  * 
#  *              Every file is free software: you can redistribute it and/or modify
#  *              it under the terms of the GNU General Public License as published by
#  *              the Free Software Foundation, either version 3 of the License, or
#  *              (at your option) any later version.
#  * 
#  *              These files are distributed in the hope that they will be useful,
#  *              but WITHOUT ANY WARRANTY; without even the implied warranty of
#  *              MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  *              GNU General Public License for more details.
#  * 
#  *              You should have received a copy of the GNU General Public License
#  *              along with the "eshop - proyecto iso" project. 
#  *              If not, see <http://www.gnu.org/licenses/>.
#***************************************************************************************************
import sqlite3
from datetime import datetime
from typing import Union
import random


#***************************************************************************************************
class Database:
	connection = sqlite3.connect("../../database/isoDB.db")
	cursor = connection.cursor()
	cursor.execute("PRAGMA foreign_keys = ON;")


#***************************************************************************************************
	@classmethod
	def email_exists(cls, email: str) -> bool:
		query = "SELECT COUNT(*) FROM cliente WHERE email = ?"
		cls.cursor.execute(query, (email,))
		count = cls.cursor.fetchone()
		return count[0] > 0


#***************************************************************************************************
	@classmethod
	def password_matches(cls, email: str, password: str) -> bool:
		query = "SELECT pwd FROM cliente WHERE email = ?"
		cls.cursor.execute(query, (email,))
		user_pwd = cls.cursor.fetchone()[0]
		return True if user_pwd == password else False


#***************************************************************************************************
	@classmethod
	def is_admin(cls, email: str) -> bool:
		query = "SELECT admin FROM Cliente WHERE email = ?"
		cls.cursor.execute(query, (email,))
		result = cls.cursor.fetchone()[0]
		return bool(result)


#***************************************************************************************************
	@classmethod
	def user_signup(cls, email: str, password: str) -> bool:
		query = "INSERT INTO cliente (email, pwd) VALUES (?, ?)"
		query2 = """
		INSERT INTO Marketing (email, tag, peso, contador)
		VALUES (?, ?, ?, ?);
		"""
		try:
			cls.cursor.execute(query, (email, password))
			tags = cls.fetch_tags()["tags"]
			while len(tags) > 3:
				random_index = random.randint(0, len(tags) - 1)
				tags.pop(random_index)
			for tag in tags: 
				cls.cursor.execute(query2, (email, tag, 0.5, 0))
			cls.connection.commit()
			return True
		except Exception as e:
			cls.connection.rollback()
			print(f"(!) An error occurred while adding new user: \n{e}")
			return False


#***************************************************************************************************
	@classmethod
	def fetch_user_info(cls, email: str) -> tuple:
		query = """
		SELECT *
		FROM Cliente
		WHERE email = ?;
		"""
		cls.cursor.execute(query, (email,))
		user_info = cls.cursor.fetchall()[0]
		return {"email": user_info[0], "name": user_info[1], "surname": user_info[2], 
						"payment": user_info[3], "address": user_info[4], "password": user_info[5], 
						"admin": user_info[6] }


#***************************************************************************************************
	@classmethod
	def tag_in_user_marketing(cls, email: str, tag: str) -> bool:
		query = """
		SELECT COUNT(*)
		FROM Marketing
		WHERE email = ? AND tag = ?;
		"""
		cls.cursor.execute(query, (email, tag))
		results = cls.cursor.fetchall()
		return results[0][0] > 0


#***************************************************************************************************
	@classmethod
	def add_tag_to_user_marketing(cls, email: str, tag: str) -> bool:
		query = """
		INSERT INTO Marketing (email, tag, peso, contador)
		VALUES (?, ?, ?, ?);
		"""
		try:
			cls.cursor.execute(query, (email, tag, 0.5, 1))
			cls.connection.commit()
			return True
		except Exception as e:
			cls.connection.rollback()
			print(f"(!) An error occurred while adding a tag to user marketing: \n{e}")
			return False


#***************************************************************************************************
	@classmethod
	def increase_marketing_tag_counters(cls, email: str) -> bool:
		query = """
		UPDATE Marketing
		SET contador = CASE
			WHEN contador = 60 THEN 1
			ELSE contador + 1
		END,
		peso = CASE
			WHEN contador = 50 THEN 0.4
			WHEN contador % 10 = 0 THEN peso - 0.05
			ELSE peso
		END
		WHERE email = ?;
		"""
		try:
			cls.cursor.execute(query, (email,))
			cls.connection.commit()
			return True
		except Exception as e:
			cls.connection.rollback()
			print(f"(!) An error occurred while increasing user marketing tags counter: \n{e}")
			return False


#***************************************************************************************************
	@classmethod
	def update_user_marketing(cls, email: str, tag: str, operation: int, var: float = None) -> None:
		if not cls.tag_in_user_marketing(email, tag):
			if not cls.add_tag_to_user_marketing(email, tag):
				return
		query = """
		UPDATE Marketing 
		SET peso = peso + ?, contador = 1
		WHERE email = ? AND tag = ?;
		"""
		if operation == 0: # Search specific product with <tags>
			variance = 0.01
		elif operation == 1: # Search products by <tag>
			variance = 0.03
		elif operation == 2: # Add product to cart with <tags>
			variance = 0.02
		elif operation == 3: # Buy product with <tags>
			variance = 0.05
		elif operation == 4: # Rate product with <tags> and <rating>
			if var is not None:
				variance = 0.05 * (var - 2.5)
			else:
				return
		elif operation == 5: # Remove product from cart with <tags>
			variance = -0.02
		else:
			variance = 0
		try:
			cls.cursor.execute(query, (variance, email, tag))
			cls.connection.commit()
			return
		except Exception as e:
			cls.connection.rollback()
			print(f"(!) An error occurred while updating tag in user marketing profile: \n{e}")
			return


#***************************************************************************************************
	@classmethod
	def fetch_all_products(cls) -> dict:
		query = """
			SELECT p.ROWID,
        p.nombre,
        p.descripcion,
        p.imagen,
        p.precio,
				p.rating,
				p.contRating,
        GROUP_CONCAT(t.nombre) AS tags
			FROM Producto p
			LEFT JOIN Clasificacion c 
					ON p.ROWID = c.idProducto
			LEFT JOIN Tag t 
					ON c.tag = t.nombre
			GROUP BY p.ROWID, p.nombre, p.descripcion, p.imagen, p.precio, p.rating, p.contRating
			ORDER BY p.rating DESC;
		"""
		cls.cursor.execute(query)
		results = cls.cursor.fetchall()
		products = []
		for row in results:
			products.append({"id": row[0], "name": row[1], "description": row[2], "image": row[3], 
											"price": row[4], "rating": row[5], "count": row[6], "tags": row[7]})
		return {"amount": len(products), "products": products}


#***************************************************************************************************
	@classmethod
	def fetch_product_by_id(cls, email: str, product_id: int) -> dict:
		query = """
		SELECT 	p.ROWID,
        		p.nombre,
        		p.descripcion,
        		p.imagen,
        		p.precio,
						p.rating,
						p.contRating,
        		GROUP_CONCAT(t.nombre) AS tags
		FROM Producto p
		LEFT JOIN Clasificacion c 
				ON p.ROWID = c.idProducto
		LEFT JOIN Tag t 
				ON c.tag = t.nombre
		WHERE p.ROWID = ?
		GROUP BY p.ROWID, p.nombre, p.descripcion, p.imagen, p.precio, p.rating, p.contRating
		"""
		cls.cursor.execute(query, (product_id,))
		results = cls.cursor.fetchall()
		item = results[0]
		product = {"id": item[0], "name": item[1], "description": item[2], "image": item[3], 
								"price": item[4], "rating": item[5], "count": item[6], "tags": item[7]}

		tags = item[7].split(",")
		cls.increase_marketing_tag_counters(email)
		for tag in tags:
			cls.update_user_marketing(email, tag, 0)

		return product


#***************************************************************************************************
	@classmethod
	def fetch_products_by_tags(cls, email: str, tags: list[str]) -> dict:
		query = """
		SELECT  p.ROWID,
						p.nombre,
						p.descripcion,
						p.imagen,
						p.precio,
						p.rating,
						p.contRating,
						GROUP_CONCAT(t.nombre) AS tags
		FROM producto p
		INNER JOIN Clasificacion c ON c.idProducto = p.ROWID 
		LEFT JOIN Tag t ON c.tag = t.nombre
		WHERE c.tag IN (
		""" + ",".join("?" for i in range(len(tags))) + ")"
		query += """GROUP BY p.ROWID, p.nombre, p.descripcion, p.imagen, 
			p.precio, p.rating, p.contRating 
		ORDER BY p.rating DESC
		"""
		cls.cursor.execute(query, tags)
		results = cls.cursor.fetchall()
		products = []
		for row in results:
			products.append({"id": row[0], "name": row[1], "description": row[2], "image": row[3], 
											"price": row[4], "rating": row[5], "count": row[6], "tags": row[7]})

		cls.increase_marketing_tag_counters(email)
		for tag in tags:
			cls.update_user_marketing(email, tag, 1)

		return {"amount": len(products), "products": products}


#***************************************************************************************************
	@classmethod
	def fetch_tags(cls) -> dict:
		query = """
		SELECT nombre
		FROM Tag;
		"""
		cls.cursor.execute(query)
		results = cls.cursor.fetchall()
		results = [tag[0].capitalize() for tag in results]
		return {"tags": results}


#***************************************************************************************************
	@classmethod
	def fetch_product_tags(cls, productid: int) -> list[str]:
		query = """
		SELECT tag
		FROM Clasificacion
		WHERE idProducto = ?
		"""
		cls.cursor.execute(query, (productid,))
		results = cls.cursor.fetchall()
		return [tag[0].capitalize() for tag in results]


#***************************************************************************************************
	@classmethod
	def new_product(cls, name: str, description: str, image: str, price: float) -> bool:
		query = """
		INSERT INTO Producto (nombre, descripcion, imagen, precio)
	    VALUES (?, ?, ?, ?);
		"""
		try:
			cls.cursor.execute(query, (name, description, image, price))
			cls.connection.commit()
			return True
		except Exception as e:
			cls.connection.rollback()
			print(f"(!) An error occurred while adding a new product: \n{e}")
			return False


#***************************************************************************************************
	@classmethod
	def edit_product(cls, productid: int, field: str, value: Union[str, int]) -> bool:
		valid_columns = ["nombre", "descripcion", "imagen", "precio"]
		if field in valid_columns:
			query = f"""
			UPDATE Producto
			SET {field} = ?
			WHERE ROWID = ?;
			"""
			try:
				cls.cursor.execute(query, (value, productid))
				cls.connection.commit()
				return True
			except Exception as e:
				cls.connection.rollback()
				print(f"(!) An error occurred while editing a product: \n{e}")
				return False
		else:
			return False


#***************************************************************************************************
	@classmethod
	def add_product_tags(cls, productid: int, tags: str) -> bool:
		taglist = tags.split(",")
		query = """
		INSERT INTO Clasificacion 
    	VALUES(?, ?);
		"""
		try:
			for tag in taglist:
				if cls.tag_exists(tag):
					cls.cursor.execute(query, (productid, tag))
				else:
					cls.connection.commit()
					print(f"(!) Tried to add a non existent Tag: {tag}")
					return False
				cls.connection.commit()
			return True
		except Exception as e:
			cls.connection.rollback()
			print(f"(!) An error occurred while adding product tags: \n{e}")
			return False


#***************************************************************************************************
	@classmethod
	def remove_product_tags(cls, productid: int, tags: str) -> bool:
		taglist = tags.split(",")
		query = """
		DELETE FROM Clasificacion
		WHERE idProducto = ? AND tag = ?;
		"""
		try:
			for tag in taglist:
				if cls.tag_exists(tag):
					cls.cursor.execute(query, (productid, tag))
				else:
					cls.connection.commit()
					print(f"(!) Tried to remove a non existent Tag: {tag}")
					return False
				cls.connection.commit()
			return True
		except Exception as e:
			cls.connection.rollback()
			print(f"(!) An error occurred while removing product tags: \n{e}")
			return False


#***************************************************************************************************
	@classmethod
	def delete_product(cls, productid: int) -> bool:
		query = """
		DELETE FROM Producto
		WHERE ROWID = ?; 
		"""
		try:
			cls.cursor.execute(query, (productid,))
			cls.connection.commit()
			return True
		except Exception as e:
			cls.connection.rollback()
			print(f"(!) An error occurred while deleting a product: \n{e}")
			return False


#***************************************************************************************************
	@classmethod
	def tag_exists(cls, tag: str) -> bool:
		query = """
		SELECT COUNT(*)
		FROM Tag
		WHERE nombre = ?
		"""
		cls.cursor.execute(query, (tag,))
		results = cls.cursor.fetchall()
		return results[0][0] == 1


#***************************************************************************************************
	@classmethod
	def new_tag(cls, tag: str) -> bool:
		query = """
		INSERT INTO Tag
    VALUES(?);
		"""
		try:
			cls.cursor.execute(query, (tag,))
			cls.connection.commit()
			return True
		except Exception as e:
			cls.connection.rollback()
			print(f"(!) An error occurred while adding a new tag: \n{e}")
			return False


#***************************************************************************************************
	@classmethod
	def is_user_cart(cls, email: str, cartid: int) -> bool:
		query = """
		SELECT COUNT(*)
		FROM Carrito
		WHERE ROWID = ? AND email = ?;
		"""
		cls.cursor.execute(query, (cartid, email))
		results = cls.cursor.fetchall()
		return results[0][0] > 0


#***************************************************************************************************
	@classmethod
	def get_cart_user(cls, cartid: str) -> str:
		query = """
		SELECT email
		FROM Carrito
		WHERE ROWID = ?
		"""
		cls.cursor.execute(query, (cartid,))
		results = cls.cursor.fetchall()
		return results[0][0]


#***************************************************************************************************
	@classmethod
	def new_cart(cls, email: str, cartname: str) -> bool:
		query = """
		INSERT INTO Carrito (email, nombre)
			VALUES (?, ?);
		"""
		try:
			cls.cursor.execute(query, (email, cartname))
			cls.connection.commit()
			return True
		except Exception as e:
			cls.connection.rollback()
			print(f"(!) An error occurred while adding new cart: \n{e}")
			return False


#***************************************************************************************************
	@classmethod
	def edit_cart(cls, email: str, cartid: int, newname: str) -> bool:
		query = """
		UPDATE Carrito 
		SET nombre = ?
		WHERE ROWID = ? AND email = ?;
		"""
		try:
			cls.cursor.execute(query, (newname, cartid, email))
			cls.connection.commit()
			return True
		except Exception as e:
			cls.connection.rollback()
			print(f"(!) An error occurred while editing a cart: \n{e}")
			return False


#***************************************************************************************************
	@classmethod
	def remove_cart(cls, email: str, cartid: int) -> bool:
		query = """
		DELETE FROM Carrito 
			WHERE ROWID = ? AND email = ?;
		"""
		try:
			cls.cursor.execute(query, (cartid, email))
			cls.connection.commit()
			return True
		except Exception as e:
			cls.connection.rollback()
			print(f"(!) An error occurred while removing a cart: \n{e}")
			return False


#***************************************************************************************************
	@classmethod
	def add_product_to_cart(cls, cartid: int, productid: int) -> bool:
		query = """
			INSERT INTO Contiene 
				VALUES(?, ?, ?);
		"""
		try:
			cls.cursor.execute(query, (cartid, productid, 1))
			cls.connection.commit()

			email = cls.get_cart_user(cartid)
			tags = cls.fetch_product_tags(productid)
			cls.increase_marketing_tag_counters(email)
			for tag in tags:
				cls.update_user_marketing(email, tag, 2)

			return True
		except Exception as e:
			cls.connection.rollback()
			print(f"(!) An error occurred while adding a product to a cart: \n{e}")
			return False


#***************************************************************************************************
	@classmethod
	def edit_product_quantity(cls, cartid: int, productid: int, quantity: int) -> bool:
		query = """
		UPDATE Contiene
		SET cantidad = ?
		WHERE idCarrito = ? AND idProducto = ?;
		"""
		try:
			cls.cursor.execute(query, (quantity, cartid, productid))
			cls.connection.commit()
			return True
		except Exception as e:
			cls.connection.rollback()
			print(f"(!) An error occurred while editing product quantity on a cart: \n{e}")
			return False


#***************************************************************************************************
	@classmethod
	def remove_product_from_cart(cls, cartid: int, productid: int) -> bool:
		query = """
		DELETE FROM Contiene 
		WHERE idCarrito = ? AND idProducto = ?;
		"""
		try:
			cls.cursor.execute(query, (cartid, productid))
			cls.connection.commit()

			email = cls.get_cart_user(cartid)
			tags = cls.fetch_product_tags(productid)
			cls.increase_marketing_tag_counters(email)
			for tag in tags:
				cls.update_user_marketing(email, tag, 5)

			return True
		except Exception as e:
			cls.connection.rollback()
			print(f"(!) An error occurred while removing a product from a cart: \n{e}")
			return False


#***************************************************************************************************
	@classmethod
	def request_cart_products(cls, cartid: int) -> dict:
		query = """
		SELECT	producto.ROWID,
        		producto.nombre,
						producto.descripcion,
						producto.imagen,
						producto.precio, 
						contiene.cantidad, 
						GROUP_CONCAT(clasificacion.tag) AS tags
		FROM producto, contiene
		LEFT JOIN clasificacion ON producto.ROWID = clasificacion.idProducto
		WHERE contiene.idProducto = producto.ROWID 
				AND contiene.idCarrito = ?
		GROUP BY producto.ROWID, producto.nombre, producto.descripcion, producto.imagen, 
						producto.precio, contiene.cantidad;
		"""
		cls.cursor.execute(query, (cartid,))
		results = cls.cursor.fetchall()
		products = []
		for row in results:
			products.append({"product_id": row[0], "product_name": row[1], "product_description": row[2], 
											 "product_image": row[3], "product_price": row[4], "tags": row[6], 
											 "quantity": row[5]})
		total = cls.get_cart_total(cartid)
		return {"success": True, "amount": len(products), "total": total, "products": products}


#***************************************************************************************************
	@classmethod
	def fetch_carts(cls, email: str) -> dict:
		query = """
		SELECT ROWID, nombre 
		FROM Carrito
		WHERE email = ?;
		"""

		cls.cursor.execute(query, (email,))
		cartlist = cls.cursor.fetchall()
		total = []
		for cart in cartlist:
			total.append(cls.get_cart_total(cart[0]))
		return {"carts": [{"cartid": cart[0], "cartname": cart[1], "total": total[i]} 
						for i, cart in enumerate(cartlist)]}


#***************************************************************************************************
	@classmethod
	def cart_has_content(cls, cartid: int) -> bool:
		query = """
		SELECT COUNT(*)
		FROM Contiene
		WHERE idCarrito = ?;
		"""
		cls.cursor.execute(query, (cartid,))
		contents = cls.cursor.fetchall()[0]
		return len(contents) > 0


#***************************************************************************************************
	@classmethod
	def create_order(cls, email: str, cartid: int) -> int:
		user_info = cls.fetch_user_info(email)
		cart_total = cls.get_cart_total(cartid)
		current_date = datetime.now()
		current_date = current_date.strftime("%d/%m/%Y")
		query = """
		INSERT INTO Pedido (email, direccion, tarjeta, fecha, total, estado) 
		VALUES (?, ?, ?, ?, ?, 'Invoiced');
		"""
		try:
			cls.cursor.execute(query, (user_info["email"], user_info["address"], user_info["payment"],
																 current_date, cart_total))
			orderid = cls.cursor.lastrowid
			cls.connection.commit()
			return orderid
		except Exception as e:
			cls.connection.rollback()
			print(f"(!) An error occurred while creating order: \n{e}")
			return 0


#***************************************************************************************************
	@classmethod
	def get_total_cart_tags(cls, cartid: int) -> list[str]:
		query = """
		SELECT c2.tag
		FROM Contiene c
		INNER JOIN Producto p ON P.ROWID = c.idProducto 
		INNER JOIN Clasificacion c2 ON c2.idProducto = p.ROWID 
		WHERE idCarrito = ?;
		"""
		cls.cursor.execute(query, (cartid,))
		results = cls.cursor.fetchall()
		return [tag[0].capitalize() for tag in results]


#***************************************************************************************************
	@classmethod
	def fill_order(cls, cartid: int, orderid: int) -> bool:
		query = """
		INSERT INTO LineaPedido 
		SELECT pedido.ROWID, producto.nombre, Contiene.idProducto, Contiene.cantidad
		FROM Pedido, producto, Contiene 
		WHERE Pedido.ROWID = ?  
			AND Contiene.idCarrito = ? 
			AND Contiene.idProducto = producto.ROWID;
		"""
		try:
			cls.cursor.execute(query, (orderid, cartid))
			cls.connection.commit()

			email = cls.get_cart_user(cartid)
			tags = cls.get_total_cart_tags(cartid)
			cls.increase_marketing_tag_counters(email)
			for tag in tags:
				cls.update_user_marketing(email, tag, 3)

			return True
		except Exception as e:
			cls.connection.rollback()
			print(f"(!) An error occurred while filling order with cart contents: \n{e}")
			return False


#***************************************************************************************************
	@classmethod
	def empty_cart(cls, cartid: int) -> bool:
		query = """
		DELETE FROM Contiene
		WHERE idCarrito = ?;
		"""
		try:
			cls.cursor.execute(query, (cartid,))
			cls.connection.commit()
			return True
		except Exception as e:
			cls.connection.rollback()
			print(f"(!) An error occurred while emptying cart: \n{e}")
			return False


#***************************************************************************************************
	@classmethod
	def get_cart_total(cls, cartid: int) -> float:
		query = """
		SELECT Contiene.cantidad, Producto.precio 
		FROM Contiene, Producto 
		WHERE Contiene.idProducto = Producto.ROWID AND Contiene.idCarrito = ?;
		"""
		cls.cursor.execute(query, (cartid,))
		productlist = cls.cursor.fetchall()
		total = 0
		for product in productlist:
			total += product[0] * product[1]
		return total

#***************************************************************************************************
	@classmethod
	def edit_payment(cls, email: str, payment: str) -> bool:
		query = """
		UPDATE Cliente
		SET tarjeta = ?
		WHERE email = ?
		"""
		try:
			cls.cursor.execute(query, (payment, email))
			cls.connection.commit()
			return True
		except Exception as e:
			cls.connection.rollback()
			print(f"(!) An error occurred while editing payment: \n{e}")
			return False


#***************************************************************************************************
	@classmethod
	def edit_address(cls, email: str, address: str) -> bool:
		query = """
		UPDATE Cliente
		SET direccion = ?
		WHERE email = ?
		"""
		try:
			cls.cursor.execute(query, (address, email))
			cls.connection.commit()
			return True
		except Exception as e:
			cls.connection.rollback()
			print(f"(!) An error occurred while editing address: \n{e}")
			return False


#***************************************************************************************************
	@classmethod
	def is_user_order(cls, email: str, orderid: int) -> bool:
		query = """
		SELECT COUNT(*)
		FROM Pedido
		WHERE ROWID = ? AND email = ?;
		"""
		cls.cursor.execute(query, (orderid, email))
		results = cls.cursor.fetchall()
		return results[0][0] > 0


#***************************************************************************************************
	@classmethod
	def fetch_order_status(cls, orderid: int) -> str:
		query = """
		SELECT estado
		FROM Pedido
		WHERE ROWID = ?;
		"""
		cls.cursor.execute(query, (orderid,))
		results = cls.cursor.fetchall()
		print(results)
		return results[0][0]


#***************************************************************************************************
	@classmethod
	def fetch_orders(cls, email: str) -> dict:
		query = """
		SELECT *
		FROM Pedido
		WHERE email = ?
		"""
		cls.cursor.execute(query, (email,))
		results = cls.cursor.fetchall()
		print(results)
		orders = []
		for order in results:
			orders.append({"orderid": order[0], "date": order[4], "total": order[5], 
											"status": order[6]})
		return {"orders": orders}


#***************************************************************************************************
	@classmethod
	def fetch_order_details(cls, orderid: int) -> dict:
		query = """
		SELECT *
		FROM Pedido
		WHERE ROWID = ?;
		"""
		cls.cursor.execute(query, (orderid,))
		results = cls.cursor.fetchall()[0]
		return {"success": True, "orderid": results[0], "email": results[1], "address": results[2],
						"payment": results[3], "date": results[4], "total": results[5], "status": results[6]}


#***************************************************************************************************
	@classmethod
	def cancel_order(cls, orderid: int) -> bool:
		query = """
		UPDATE Pedido
		SET estado = 'Cancelled'
		WHERE ROWID = ?;
		"""
		try:
			cls.cursor.execute(query, (orderid,))
			cls.connection.commit()

			return True
		except Exception as e:
			cls.connection.rollback()
			print(f"(!) An error occurred while deleting order: \n{e}")
			return False


#***************************************************************************************************
	@classmethod
	def fetch_all_orders(cls) -> dict:
		query = """
		SELECT * 
		FROM Pedido;
		"""
		cls.cursor.execute(query)
		results = cls.cursor.fetchall()
		orderlist = []
		for order in results:
			orderlist.append({"orderid": order[0], "email": order[1], "address": order[2],
											"payment": order[3], "date": order[4], "total": order[5], "status": order[6]})
		return {"amount": len(orderlist), "orders": orderlist}


#***************************************************************************************************
	@classmethod
	def change_order_status(cls, orderid: int, status: int) -> bool:
		statuses = ["Invoiced", "Prepared", "Shipped", "Out for Delivery", "Delivered", "Cancelled"]
		query = """
		UPDATE Pedido	
		SET estado = ?
		WHERE ROWID = ?;
		"""
		try:
			cls.cursor.execute(query, (statuses[int(status)], orderid))
			cls.connection.commit()
			return True
		except Exception as e:
			cls.connection.rollback()
			print(f"(!) An error occurred while changing order status: \n{e}")
			return False


#***************************************************************************************************
	@classmethod
	def has_bought(cls, email: str, productid: int) -> bool:
		query = """
		SELECT COUNT(*)
		FROM Cliente, Pedido, LineaPedido
		WHERE Cliente.email = Pedido.email AND Pedido.ROWID = LineaPedido.idPedido 
			AND Cliente.email = ? 
			AND LineaPedido.idProducto = ?;
		"""
		cls.cursor.execute(query, (email, productid))
		results = cls.cursor.fetchall()
		return results[0][0] > 0

#***************************************************************************************************
	@classmethod
	def rate_product(cls, email: str, productid: int, rating: float, comment: str = None ) -> bool:
		current_date = datetime.now()
		current_date = current_date.strftime("%d/%m/%Y")
		query1 = """
		INSERT INTO Feedback (email, idProducto, rating, fecha, comentario)
		VALUES (?, ?, ?, ?,?);
		"""
		query2 = """
		INSERT INTO Feedback (email, idProducto, rating, fecha)
		VALUES (?, ?, ?, ?);
		"""
		query3 = """
		UPDATE Producto
		SET rating = (
				SELECT AVG(rating)
				FROM Feedback
				WHERE Feedback.idProducto = ?
		)
		WHERE ROWID = ?;
		"""
		query4 = """
		UPDATE Producto
		SET contRating = contRating + 1
		WHERE ROWID = ?
		"""
		try:
			if comment:
				cls.cursor.execute(query1, (email, productid, rating, current_date, comment))
			else:
				cls.cursor.execute(query2, (email, productid, rating, current_date))
			cls.cursor.execute(query3, (productid, productid))
			cls.cursor.execute(query4, (productid,))
			cls.connection.commit()

			tags = cls.fetch_product_tags(productid)
			cls.increase_marketing_tag_counters(email)
			for tag in tags:
				cls.update_user_marketing(email, tag, 4, float(rating))
			return True
		except Exception as e:
			cls.connection.rollback()
			print(f"(!) An error occurred while rating product: \n{e}")
			return False


#***************************************************************************************************
	@classmethod
	def fetch_product_ratings(cls, productid: int) -> bool:
		query = """
		SELECT email, rating, comentario, fecha
		FROM Feedback
		WHERE idProducto = ?;
		"""
		cls.cursor.execute(query, (productid,))
		results = cls.cursor.fetchall()
		ratings = []
		for rating in results:
			ratings.append({"email": rating[0], "rating": rating[1], "comment": rating[2] , 
											"date": rating[3]})
		return {"amount": len(ratings), "ratings": ratings}


#***************************************************************************************************
	@classmethod
	def fetch_recommended_products(cls, email: str) -> dict:
		query = """
		SELECT p.ROWID,
				p.nombre,
				p.descripcion,
				p.imagen,
				p.precio,
				p.rating,
				p.contRating,
				GROUP_CONCAT(c.tag) AS tags
		FROM Producto p
		LEFT JOIN Clasificacion c ON p.ROWID = c.idProducto
		LEFT JOIN Marketing m ON m.tag = c.tag
		WHERE m.email = ?
		GROUP BY p.ROWID, p.nombre, p.descripcion, p.imagen, p.precio, p.rating, p.contRating
		ORDER BY COALESCE(SUM(m.peso), 0) DESC;
		"""
		cls.cursor.execute(query, (email,))
		results = cls.cursor.fetchall()
		products = []
		print(results)
		for row in results:
			products.append({"id": row[0], "name": row[1], "description": row[2], "image": row[3], 
											"price": row[4], "rating": row[5], "count": row[6], "tags": row[7]})
		return {"amount": len(products), "products": products}


#***************************************************************************************************
	@classmethod
	def fetch_marketing_profile(cls, email: str) -> dict:
		query = """
		SELECT tag, peso, contador
		FROM Marketing
		WHERE email = ?;
		"""
		cls.cursor.execute(query, (email,))
		results = cls.cursor.fetchall()
		tags = []
		for tag in results:
			tags.append({"tag": tag[0], "weight": tag[1], "count": tag[2]})
		return {"amount": len(tags), "tags": tags}