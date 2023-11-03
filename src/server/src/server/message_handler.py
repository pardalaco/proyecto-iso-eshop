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
import json
from src.database.database import Database


#***************************************************************************************************
class MessageHandler:
	def __init__(self) -> None:
		self.dispatcher = {
			(1, 1): self.handle_user_login,
			(1, 2): self.handle_user_signup,
			(2, 1): self.handle_request_all_products,
			(2, 2): self.handle_request_products_by_id,
			(2, 3): self.handle_request_products_by_tags,
		}


#*************************************************************************************************** 
	def handle_message(self, message_json: dict) -> str:
		type_value = message_json.get("type")
		code_value = message_json.get("code")
		content = message_json.get("content")

		handler = self.dispatcher.get((type_value, code_value))
		
		if handler:
			response =  {"type": type_value, "code": code_value, "content": handler(content)}
		else:
			response = {"type": 0, "code": 0, "content": {}} # Invalid type or code
		
		return json.dumps(response)


#***************************************************************************************************
	def handle_user_login(self, content: dict) -> dict:
		# @todo if not Database.email_exists(content.get("email")) or not Database.password_matches(content.get("password")):
		if not Database.password_matches(content.get("email"), content.get("password")): # @debug
			return {"success": False, "admin": False}

		success = True
		admin = False
		# @todo if is_admin(content.get("email")):
		# 	admin = True
		
		return {"success": success, "admin": admin}


#***************************************************************************************************
	def handle_user_signup(self, content: dict) -> dict:
		# if Database.email_exists(content.get("email")):
		# 	return {"success": False}
		# else:
			Database.user_signup(content.get("email"), content.get("username"), content.get("password"))
			return {"success": True}


#***************************************************************************************************
	def handle_request_all_products(self, content: dict) -> dict:
		# Fetch all products
		# ...
		pass


#***************************************************************************************************
	def handle_request_products_by_id(self, content: dict) -> dict:
		# Fetch products by ID
		# ...
		pass


#***************************************************************************************************
	def handle_request_products_by_tags(self, content: dict) -> dict:
		# Fetch products by tags
		# ...
		pass