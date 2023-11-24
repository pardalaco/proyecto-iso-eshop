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
from .. import PRIVILEGE_ADMIN, PRIVILEGE_NORMAL_USER, PRIVILEGE_NONE


#***************************************************************************************************
def handle_list_products(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		return (False, "You need to Log in to use this command")
	else:
		if isresponse:
			response = ""
			# Parse the content into a product list
			for item in args[0]["content"]["products"]:
				response += (f"{item['product_id']}: {item['product_name']} - {item['product_price']}€\n"
										f"\t{item['product_description']}\n")
			return (False, response)
		else:
			if len(args) == 0:
				# Retrieve all
				return (True, {"type": 2, "code": 1, "content": {}})
			elif args[0] == "-tags":
				# Retrieve by tag(s)
				return (True, {"type": 2, "code": 3, "content": {"tags": ",".join(args[1:]).lower()}})
			else:
				# Retrieve by keyword
				return (True, {"type": 2, "code": 4, "content": {"keyword": " ".join(args[0:]).lower()}})


#***************************************************************************************************
def handle_product(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		return (False, "You need to Log in to use this command")
	else:
		if isresponse:
			item = args[0]["content"]["products"]
			return (False, f"{item['product_id']}: {item['product_name']} - {item['product_price']}€\n"
										 f"\t{item['product_description']}\n")
		else:
			return (True, {"type": 2, "code": 2, "content": {"id": args[0]}})


#***************************************************************************************************
def handle_list_tags(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		return (False, "You need to Log in to use this command")
	else:
		if isresponse:
			tags = args[0]["content"]["tags"]
			return (False, ", ".join(tag for tag in tags))
		else:
			return (True, {"type": 2, "code": 5, "content": {}})


#***************************************************************************************************
shop_command_handlers = {
	"list-products": handle_list_products,
	"list": handle_list_products,
	"products": handle_list_products,
	"lp": handle_list_products,
	"l": handle_list_products,

	"product": handle_product,
	"p": handle_product,

	"tags": handle_list_tags,
	"t": handle_list_tags
}