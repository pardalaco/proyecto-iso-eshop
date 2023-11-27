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
def handle_list_orders(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		return (False, "You need to Log in to use this command")
	else:
		if isresponse:
			orderlist = "Your Orders:"
			for order in args[0]["content"]["orders"]:
				orderlist += f"\n\t{order['orderid']}. {order['date']} {order['total']}€ {order['status']}"
			return (False, orderlist)
		else:
			return (True, {"type": 6, "code": 1, "content": {"email": current_user["email"]}})


#***************************************************************************************************
def handle_order_details(isresponse: bool, current_user: dict, 
													args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		return (False, "You need to Log in to use this command")
	else:
		if isresponse:
			order = args[0]["content"]
			if order["success"]:
				return (False, f"{order['orderid']}. {order['date']} {order['total']}€ {order['status']}"
												f"\n\temail: {order['email']}"
												f"\n\tpayment: {order['payment']}"
												f"\n\taddress: {order['address']}")
			else:
				return (False, "There was an error listing the order details")
		else:
			return (True, {"type": 6, "code": 2, "content": {"email": current_user["email"], 
																											"orderid": args[0]}})


#***************************************************************************************************
def handle_cancel_order(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		return (False, "You need to Log in to use this command")
	else:
		if isresponse:
			if args[0]["content"]["success"]:
				return (False, "Order cancelled")
			else:
				return (False, "There was an error cancelling your order")
		else:
			return (True, {"type": 6, "code": 3, "content": {"email": current_user["email"], 
																											"orderid": args[0]}})


#***************************************************************************************************
order_command_handlers = {
    "list-orders": handle_list_orders,
		"lo": handle_list_orders,

		"order-details": handle_order_details,
		"od": handle_order_details,

		"cancel-order": handle_cancel_order,
		"co": handle_cancel_order
}