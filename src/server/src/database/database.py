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
	connection = sqlite3.connect("../../src/database/isoDB.db")
	cursor = connection.cursor()
	cursor.execute("PRAGMA foreign_keys = ON;")


#***************************************************************************************************
	@classmethod
	def email_exists(cls, email: str) -> bool:
		pass


#***************************************************************************************************
	@classmethod
	def password_matches(cls, email: str, password: str) -> bool:
		query = "SELECT pwd FROM cliente WHERE email = ?"
		cls.cursor.execute(query, (email,))
		user_pwd = cls.cursor.fetchone()

		return True if user_pwd == password else False


#***************************************************************************************************
	@classmethod
	def is_admin(email: str) -> bool:
		pass


#***************************************************************************************************
	@classmethod
	def user_signup(cls, email: str, username: str, password: str) -> None:
		query = "INSERT INTO cliente (email, nombre, pwd) VALUES (?, ?, ?)"
		cls.cursor.execute(query, (email, username, password))
		cls.connection.commit()