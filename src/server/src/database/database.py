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


#***************************************************************************************************
class Database:
	connection = sqlite3.connect("../../../src/database/isoDB.db")
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
	def user_signup(cls, email: str, username: str, password: str) -> list:
		query = "INSERT INTO cliente (email, nombre, pwd) VALUES (?, ?, ?)"
		cls.cursor.execute(query, (email, username, password))
		cls.connection.commit()


#***************************************************************************************************
	@classmethod
	def fetch_all_products(cls) -> list:
		query = """
			SELECT 
				p.id AS product_id,
				p.nombre AS product_name,
				p.descripcion AS product_description,
				p.imagen AS product_image,
				p.precio AS product_price,
				GROUP_CONCAT(t.nombre) AS tags
			FROM 
				Producto p
			LEFT JOIN 
				Clasificacion c ON p.id = c.idProducto
			LEFT JOIN 
				Tag t ON c.idTag = t.id
			GROUP BY 
				p.id, p.nombre, p.descripcion, p.imagen, p.precio
			ORDER BY 
				p.id;
		"""
		cls.cursor.execute(query)
		results = cls.cursor.fetchall()
		products = []
		for row in results:
			products.append({"product_id": row[0], "product_name": row[1], "product_description": row[2], 
											 "product_image": row[3], "product_price": row[4], "tags": row[5]})
		return {"amount": len(products), "products": products}
