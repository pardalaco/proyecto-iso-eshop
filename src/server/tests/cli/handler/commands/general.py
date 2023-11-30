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
def handle_quit(isresponse: bool, current_user: dict, args: list[str]) ->  tuple[bool, str]:
	return (False, None)


#***************************************************************************************************
def handle_help(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, str]:
	if current_user["privilege"] == PRIVILEGE_ADMIN:
		return (False, shop_help() + admin_help() + note_help())
	elif current_user["privilege"] == PRIVILEGE_NORMAL_USER:
		return (False, shop_help() + note_help())
	else:
		return (False, user_help() + note_help())


def user_help() -> str:
	return """
	Available Commands:
		login <email> <password>
		signup <email> <password>
	"""
	

def shop_help() -> str:
	return """
	User Commands:
		edit-payment (epy) <payment>
		edit-address (ead) <address>
		user-info (ui)

	Shop Commands:
		list-products (lp) [-tags <tag> <tag> ...]
		product (p) <product_id>
		tags (t)

	Cart Commands:
		new-cart (nc) <cart_name>
		edit-cart (ec) <cart_id> <cart_name>
		remove-cart (rc) <cart_id>
		add-product (ap) <cart_id> <product_id>
		edit-product-quantity (epq) <cart_id> <product_id> <quantity>
		remove-product (rp) <cart_id> <product_id>
		list-cart-products (lcp) <cart_id>
		list-carts (lc)
		pruchase-cart (pc) <cart_id>

	Order Commands:
		list-orders (lo)
		order-details (od) <order_id>
		cancel-order (co) <order_id>
	"""

def admin_help() -> str:
	return """
	Admin Commands:
		new-product (np) <name> <description> <image> <price>
		edit-product (ep) <product_id> <field> <value> [tagop = "0", "1"]
			(field can be: "nombre", "descripcion", "imagen", "precio")
			(tagop only if field == "tags")
		delete-product (dp) <product_id>
		new-tag (nt) <tag>
		list-all-orders (lao)
		change-order-status (cos) <order_id> <status>
			(status can be: 0 = "Invoiced", 1 = "Prepared", 2 = "Shipped", 3 = "Out for Delivery", 
			                4 = "Delivered", 5 = "Cancelled")
	"""

def note_help() -> str:
	return """	
	Other Commands:
		logout
		help (h)
		quit (q, exit)

	Note:
		<angle brackets> indicate required arguments.
		[square brackets] indicate optional arguments.
		(parentheses) indicate aliases or additional information.
	"""


#***************************************************************************************************
general_command_handlers = {
    "help": handle_help,
		"h": handle_help,

    "quit": handle_quit,
    "exit": handle_quit,
    "q": handle_quit
}