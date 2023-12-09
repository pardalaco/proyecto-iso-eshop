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
def handle_toggle_admin(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		return (False, "You need to Log in to use this command")
	if current_user["privilege"] == PRIVILEGE_ADMIN:
				current_user["privilege"] = PRIVILEGE_NORMAL_USER
				return (False, "Admin mode disabled")
	else:
		if isresponse:
			if args[0]["content"]["success"]:
				current_user["privilege"] = PRIVILEGE_ADMIN
				return (False, "Admin mode enabled")
			else:
				return (False, "You cannot enter admin mode")
		else:
			return (True, {"type": 1, "code": 3, "content": {"email": current_user["email"]}})


#***************************************************************************************************
def handle_new_product(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] != PRIVILEGE_ADMIN:
		return (False, "You need to be an Admin to use this command")
	else:
		if isresponse:
			if args[0]["content"]["success"]:
				return (False, "New product added")
			else:
				return (False, "There was a problem adding a new product")
		else:
			return (True, {"type": 3, "code": 1, "content": {"email": current_user["email"], 
							"name": args[0], "description": args[1], "image": args[2], "price": args[3]}})


#***************************************************************************************************
def handle_edit_product(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] != PRIVILEGE_ADMIN:
		return (False, "You need to be an Admin to use this command")
	else:
		if isresponse:
			if args[0]["content"]["success"]:
				return (False, "Product edited")
			else:
				return (False, "There was a problem editing the product")
		else:
			return (True, {"type": 3, "code": 2, "content": {"email": current_user["email"], 
																												"productid": args[0],
																												"tagop": args[-1],
																												args[1]: args[2]}})


#***************************************************************************************************
def handle_delete_product(isresponse: bool, current_user: dict, 
													args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] != PRIVILEGE_ADMIN:
		return (False, "You need to be an Admin to use this command")
	else:
		if isresponse:
			if args[0]["content"]["success"]:
				return (False, "Product removed")
			else:
				return (False, "There was a problem removing the product")
		else:
			return (True, {"type": 3, "code": 3, "content": {"email": current_user["email"], 
																											"productid": args[0]}})


#***************************************************************************************************
def handle_new_tag(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] != PRIVILEGE_ADMIN:
		return (False, "You need to be an Admin to use this command")
	else:
		if isresponse:
			if args[0]["content"]["success"]:
				return (False, "Tag added")
			else:
				return (False, "There was a problem adding the tag")
		else:
			return (True, {"type": 3, "code": 4, "content": {"email": current_user["email"], 
																											"tag": args[0]}})


#***************************************************************************************************
def handle_list_all_orders(isresponse: bool, current_user: dict, 
													args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] != PRIVILEGE_ADMIN:
		return (False, "You need to be an Admin to use this command")
	else:
		if isresponse:
			orderlist = "ShopOrders: "
			for order in args[0]["content"]["orders"]:
				orderlist += f"\n\t{order['orderid']} {order['date']} {order['email']} {order['status']}"
			return (False, orderlist)
		else:
			return (True, {"type": 7, "code": 1, "content": {"email": current_user["email"]}})


#***************************************************************************************************
def handle_change_order_status(isresponse: bool, current_user: dict, 
															args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] != PRIVILEGE_ADMIN:
		return (False, "You need to be an Admin to use this command")
	else:
		if isresponse:
			if args[0]["content"]["success"]:
				return (False, "ShopOrder status changed")
			else:
				return (False, "There was a problem changing the order status")
		else:
			return (True, {"type": 7, "code": 2, "content": {"email": current_user["email"], 
																											"orderid": args[0], "status": args[1]}})


#***************************************************************************************************
admin_command_handlers = {
	"asadmin": handle_toggle_admin,

	"new-product": handle_new_product,
	"np": handle_new_product,

	"edit-product": handle_edit_product,
	"ep": handle_edit_product,

	"delete-product": handle_delete_product,
	"dp": handle_delete_product,

	"new-tag": handle_new_tag,
	"nt": handle_new_tag,

	"list-all-orders": handle_list_all_orders,
	"lao": handle_list_all_orders,

	"change-order-status": handle_change_order_status,
	"cos": handle_change_order_status
}