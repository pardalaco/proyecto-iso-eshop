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
import asyncio

from src.models.user import User
from src.models.product import Product


#***************************************************************************************************
class Database:
	def __init__(self, *args, **kwargs) -> None:
		self.connection = sqlite3.connect("../../../database/isoDB.db")
		self.cursor = self.connection.cursor()
		self.cursor.execute("PRAGMA foreign_keys = ON;")


#***************************************************************************************************
	async def query_user() -> User:
		pass


#***************************************************************************************************
	async def store_user(user: User) -> None:
		pass


#***************************************************************************************************
	async def query_products() -> list[Product]:
		pass


#***************************************************************************************************
	async def store_product(product: Product) -> None:
		pass