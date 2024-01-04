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
			(1, 3): self.handle_is_user_admin,
			(2, 1): self.handle_request_all_products,
			(2, 2): self.handle_request_product_by_id,
			(2, 3): self.handle_request_products_by_tags,
			(2, 4): self.handle_request_all_tags,
			(2, 5): self.handle_request_products_by_query,
			(3, 1): self.handle_new_product,
			(3, 2): self.handle_edit_product,
			(3, 3): self.handle_delete_product,
			(3, 4): self.handle_new_tag,
			(4, 1): self.handle_new_cart,
			(4, 2): self.handle_edit_cart,
			(4, 3): self.handle_remove_cart,
			(4, 4): self.handle_add_product_to_cart,
			(4, 5): self.handle_edit_product_quantity,
			(4, 6): self.handle_remove_product_from_cart,
			(4, 7): self.handle_request_cart_products,
			(4, 8): self.handle_request_user_carts,
			(4, 9): self.handle_purchase,
			(5, 1): self.handle_edit_user_info,
			(5, 2): self.handle_edit_payment,
			(5, 3): self.handle_edit_address,
			(5, 4): self.handle_user_info,
			(6, 1): self.handle_list_orders,
			(6, 2): self.handle_order_details,
			(6, 3): self.handle_cancel_order,
			(6, 4): self.handle_request_order_products,
			(7, 1): self.handle_list_all_orders,
			(7, 2): self.handle_change_order_status,
			(8, 1): self.handle_rate_product,
			(8, 2): self.handle_fetch_product_ratings,
			(8, 3): self.handle_fetch_recommended_products,
			(8, 4): self.handle_fetch_recommended_products_by_tags,
			(8, 5): self.handle_fetch_marketing_profile,
			(9, 1): self.handle_edit_product_tags,
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
		if not Database.email_exists(content.get("email")) \
			or not Database.password_matches(content.get("email"), content.get("password")):
				return {"success": False, "admin": False}

		success = True
		admin = False
		if Database.is_admin(content.get("email")):
			admin = True
		
		return {"success": success, "admin": admin}


#***************************************************************************************************
	def handle_user_signup(self, content: dict) -> dict:
		email = content["email"]
		password = content["password"]
		if Database.email_exists(email):
			return {"success": False}
		else:
			success = Database.user_signup(email, password)
			if success:
				self.handle_new_cart({"email": email, "cartname": "Carrito"})
			return {"success": success}


#***************************************************************************************************
	def handle_is_user_admin(self, content: dict) -> dict:
		return {"success": Database.is_admin(content["email"])}


#***************************************************************************************************
	def handle_request_all_products(self, content: dict) -> dict:
		return Database.fetch_all_products()


#***************************************************************************************************
	def handle_request_product_by_id(self, content: dict) -> dict:
		email = content["email"]
		product_id = content["id"]
		return Database.fetch_product_by_id(email, product_id)


#***************************************************************************************************
	def handle_request_products_by_tags(self, content: dict) -> dict:
		email = content["email"]
		tags = content["tags"].split(",")
		return Database.fetch_products_by_tags(email, tags)


#***************************************************************************************************
	def handle_request_all_tags(self, content: dict) -> dict:
		return Database.fetch_tags()


#***************************************************************************************************
	def handle_request_products_by_query(self, content: dict) -> dict:
		#@todo handle request by query
		email = content["email"]
		query = content["query"]
		query = " ".split(query)
		for keyword in query:
			if len(keyword) <= 2:
				query.pop(keyword)
		return Database.fetch_products_by_query(email, query) 


#***************************************************************************************************
	def handle_new_product(self, content: dict) -> dict:
		email = content["email"]
		if not Database.is_admin(email):
			return {"success": False}
		else:
			name = content["name"]
			description = content["description"]
			image = content["image"]
			price = content["price"]
			tags = content["tags"].split(",")
			success = Database.new_product(name, description, image, price)
			product_id = Database.get_product_id(name)
			success = Database.add_product_tags(product_id, tags)
			return {"success": success}


#***************************************************************************************************
	def handle_edit_product(self, content: dict) -> dict:
		email = content.pop("email", None)
		if "tagop" in content:
			tagop = int(content.pop("tagop"))
		if not Database.is_admin(email):
			return {"success": False}
		else:
			productid = content.pop("productid", None)
			for key in content:
				if key == "tags":
					if tagop == 0:
						if not Database.add_product_tags(productid, content[key].split(",")):
							return {"success": False}
					else:
						if not Database.remove_product_tags(productid, content[key].split(",")):
							return {"success": False}
				else:	
					if not Database.edit_product(productid, key, content[key]):
						return {"success": False}
			return {"success": True}


#***************************************************************************************************
	def handle_delete_product(self, content: dict) -> dict:
		email = content["email"]
		if not Database.is_admin(email):
			return {"success": False}
		else:
			return {"success": Database.delete_product(content["productid"])}


#***************************************************************************************************
	def handle_new_tag(self, content: dict) -> dict:
		email = content["email"]
		if not Database.is_admin(email):
			return {"success": False}
		else:
			return {"success": Database.new_tag(content["tag"])}


#***************************************************************************************************
	def handle_new_cart(self, content: dict) -> dict:
		print(content)
		email = content["email"]
		cartname = content["cartname"]
		success = Database.new_cart(email, cartname)
		return {"success": success}


#***************************************************************************************************
	def handle_edit_cart(self, content: dict) -> dict:
		email = content["email"]
		cartid = content["cartid"]
		newname = content["newname"]
		success = Database.edit_cart(email, cartid, newname)
		return {"success": success}


#***************************************************************************************************
	def handle_remove_cart(self, content: dict) -> dict:
		email = content["email"]
		cartid = content["cartid"]
		success = Database.remove_cart(email, cartid)
		return {"success": success}

#***************************************************************************************************
	def handle_add_product_to_cart(self, content: dict) -> dict:
		email = content["email"]
		cartid = content["cartid"]
		productid = content["productid"]
		success = Database.is_user_cart(email, cartid)
		if not success:
			return {"success": success}
		else:
			success = Database.add_product_to_cart(cartid, productid)
			return {"success": success}


#***************************************************************************************************
	def handle_edit_product_quantity(self, content: dict) -> dict:
		email = content["email"]
		cartid = content["cartid"]
		productid = content["productid"]
		quantity = content["quantity"]
		success = Database.is_user_cart(email, cartid)
		if not success:
			return {"success": success}
		else:
			success = Database.edit_product_quantity(cartid, productid, quantity)
			return {"success": success}


#***************************************************************************************************
	def handle_remove_product_from_cart(self, content: dict) -> dict:
		email = content["email"]
		cartid = content["cartid"]
		productid = content["productid"]
		success = Database.is_user_cart(email, cartid)
		if not success:
			return {"success": success}
		else:
			success = Database.remove_product_from_cart(cartid, productid)
			return {"success": success}


#***************************************************************************************************
	def handle_request_cart_products(self, content: dict) -> dict:
		email = content["email"]
		cartid = content["cartid"]
		success = Database.is_user_cart(email, cartid)
		if not success:
			return {"success": success, "amount": 0, "products": {}}
		else:
			return Database.request_cart_products(cartid)


#***************************************************************************************************
	def handle_request_user_carts(self, content: dict) -> dict:
		return Database.fetch_carts(email = content["email"])


#***************************************************************************************************
	def handle_purchase(self, content: dict) -> dict:
		email = content["email"]
		cartid = content["cartid"]
		if not Database.is_user_cart(email, cartid):
			return {"success": False}
		if not Database.cart_has_content(cartid):
			return{"success": False}
			
		orderid = Database.create_order(email, cartid)
		if orderid == 0:
			return {"success": False}
		
		if not Database.fill_order(cartid, orderid):
			return {"success": False}
		
		if not Database.empty_cart(cartid):
			return {"success": False}

		return {"success": True, "orderid": orderid}


#***************************************************************************************************
	def handle_edit_user_info(self, content: dict) -> dict:
		useremail = content["useremail"]
		changes = content["changes"]
		for change in changes:
			try:
				newval = content[change]
				if not Database.update_user_info(useremail, change, newval):
					return {"success": False}
				if change == "email":
					useremail = content["email"]
			except Exception as e:
				print(f"(!) Error while updating user info: \n{e}")
		return {"success": True}


#***************************************************************************************************
	def handle_edit_payment(self, content: dict) -> dict:
		email = content["email"]
		payment = content["payment"]
		success = Database.edit_payment(email, payment)
		return {"success": success}


#***************************************************************************************************
	def handle_edit_address(self, content: dict) -> dict:
		email = content["email"]
		address = content["address"]
		success = Database.edit_address(email, address)
		return {"success": success}


#***************************************************************************************************
	def handle_user_info(self, content: dict) -> dict:
		email = content["email"]
		user_info = Database.fetch_user_info(email)
		return user_info


#***************************************************************************************************
	def handle_list_orders(self, content: dict) -> dict:
		email = content["email"]
		return Database.fetch_orders(email)
		

#***************************************************************************************************
	def handle_order_details(self, content: dict) -> dict:
		email = content["email"]
		orderid = content["orderid"]
		if Database.is_user_order(email, orderid):
			return Database.fetch_order_details(orderid)
		elif Database.is_admin(email):
			return Database.fetch_order_details(orderid)
		else:
			return {"success": False}
		

#***************************************************************************************************
	def handle_cancel_order(self, content: dict) -> dict:
		email = content["email"]
		orderid = content["orderid"]
		if Database.is_user_order(email, orderid):
			if Database.fetch_order_status(orderid) == "Invoiced":
				return {"success": Database.cancel_order(orderid)}
		return {"success": False}


#***************************************************************************************************
	def handle_request_order_products(self, content: dict) -> dict:
		email = content["email"]
		orderid = content["orderid"]
		if Database.is_user_order(email, orderid):
			return Database.fetch_order_products(orderid)


#***************************************************************************************************
	def handle_list_all_orders(self, content: dict) -> dict:
		email = content["email"]
		if not Database.is_admin(email):
			return {}
		else:
			return Database.fetch_all_orders()


#***************************************************************************************************
	def handle_change_order_status(self, content: dict) -> dict:
		email = content["email"]
		if not Database.is_admin(email):
			return {"success": False}
		else:
			orderid = content["orderid"]
			status = content["status"]
			return {"success": Database.change_order_status(orderid, status)}


#***************************************************************************************************
	def handle_rate_product(self, content: dict) -> dict:
		email = content["email"]
		productid = content["productid"]
		if Database.has_bought(email, productid):
			rating = content["rating"]
			comment = content["comment"]
			return {"success": Database.rate_product(email, productid, rating, comment)}
		else:
			return {"success": False}


#***************************************************************************************************
	def handle_fetch_product_ratings(self, content: dict) -> dict:
		productid = content["productid"]
		return Database.fetch_product_ratings(productid)


#***************************************************************************************************
	def handle_fetch_recommended_products(self, content: dict) -> dict:
		email = content["email"]
		return Database.fetch_recommended_products(email)


#***************************************************************************************************
	def handle_fetch_recommended_products_by_tags(self, content: dict) -> dict:
		email = content["email"]
		tags = content["tags"].split(",")
		return Database.fetch_recommended_products_by_tags(email, tags)


#***************************************************************************************************
	def handle_fetch_marketing_profile(self, content: dict) -> dict:
		email = content["email"]
		return Database.fetch_marketing_profile(email)


#***************************************************************************************************
	def handle_edit_product_tags(self, content: dict) -> dict:
		email = content["email"]
		if not Database.is_admin(email):
			return {"success": False}
		tags = content["tags"]
		productid = content["productid"]
		original_tags = Database.fetch_product_tags(productid)
		tags_to_add = [tag for tag in tags if tag not in original_tags]
		tags_to_remove = [tag for tag in original_tags if tag not in tags]

		if not Database.add_product_tags(productid, tags_to_add):
			return {"success": False}
		if not Database.remove_product_tags(productid, tags_to_remove):
			return {"success": False}
		return {"success": True}