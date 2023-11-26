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
def handle_new_cart(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		return (False, "You need to Log in to use this command")
	else:
		if isresponse:
			if args[0]["content"]["success"] == True:
				return (False, "Cart created")
			else:
				return (False, "There was an error creating the cart")
		else:
			return (True, {"type": 4, "code": 1, "content": {"email": current_user["email"], 
																												"cartname": " ".join(args)}})


#***************************************************************************************************
def handle_edit_cart(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		return (False, "You need to Log in to use this command")
	else:
		if isresponse:
			if args[0]["content"]["success"] == True:
				return (False, "Cart name edited successfully")
			else:
				return (False, "There was an error editing the cart")
		else:
			return (True, {"type": 4, "code": 2, "content": {"email": current_user["email"], 
																												"cartid": args[0],
																												"newname": " ".join(args[1:])}})

#***************************************************************************************************
def handle_remove_cart(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		return (False, "You need to Log in to use this command")
	else:
		if isresponse:
			if args[0]["content"]["success"] == True:
				return (False, "Cart removed successfully")
			else:
				return (False, "There was an error removing the cart")
		else:
			return (True, {"type": 4, "code": 3, "content": {"email": current_user["email"], 
																												"cartid": args[0]}})


#***************************************************************************************************
def handle_add_product(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		return (False, "You need to Log in to use this command")
	else:
		if isresponse:
			if args[0]["content"]["success"] == True:
				return (False, "Product added")
			else:
				return (False, "There was an error adding the product")
		else:
			return (True, {"type": 4, "code": 4, "content": {"email": current_user["email"],
																												"cartid": args[0],
																												"productid": args[1]}})


#***************************************************************************************************
def handle_edit_product_quantity(isresponse: bool, current_user: dict, 
																	args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		return (False, "You need to Log in to use this command")
	else:
		if isresponse:
			if args[0]["content"]["success"] == True:
				return (False, "Product quantity edited")
			else:
				return (False, "There was an error editing the quantity of the product")
		else:
			return (True, {"type": 4, "code": 5, "content": {"email": current_user["email"],
																												"cartid": args[0],
																												"productid": args[1],
																												"quantity": args[2]}})


#***************************************************************************************************
def handle_remove_product(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		return (False, "You need to Log in to use this command")
	else:
		if isresponse:
				if args[0]["content"]["success"] == True:
					return (False, "Product removed")
				else:
					return (False, "There was an error removing the product")
		else:
			return (True, {"type": 4, "code": 6, "content": {"email": current_user["email"],
																												"cartid": args[0],
																												"productid": args[1]}})


#***************************************************************************************************
def handle_list_cart_products(isresponse: bool, current_user: dict, 
															args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		return (False, "You need to Log in to use this command")
	else:
		if isresponse:
			if args[0]["content"]["success"] == True:
				products = args[0]["content"]["products"]
				productlist = f"Cart Total: {args[0]['content']['total']}€\nProducts:"
				for product in products:
					productlist += (f"\n{product['product_id']}: {product['product_name']} - "
													f"{product['product_price']}€, {product['quantity']} uds "
													f"({product['product_price'] * product['quantity']}€)"
													f"\n\t{product['product_description']}\n")
				return (False, productlist)
			else:
				return (False, "There was an error listing cart products")
		else:
			return (True, {"type": 4, "code": 7, "content": {"email": current_user["email"], 
																											"cartid": args[0]}})



#***************************************************************************************************
def handle_list_carts(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		return (False, "You need to Log in to use this command")
	else:
		if isresponse:
			cartlist = "Your Carts:"
			for cart in args[0]["content"]["carts"]:
				cartlist += f"\n\t{cart['cartid']}. {cart['cartname']} {cart['total']}€"
			return (False, cartlist)
		else:
			return (True, {"type": 4, "code": 8, "content": {"email": current_user["email"]}})


#***************************************************************************************************
def handle_purchase(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	# @test
	if current_user["privilege"] == PRIVILEGE_NONE:
		return (False, "You need to Log in to use this command")
	else:
		if isresponse:
			if args[0]["content"]["success"] == True:
				orderid = args[0]["content"]["orderid"]
				return (False, f"Purchase Completed, Order ID: {orderid}")
			else:
				return (False, "There was an error with your purchase")
		else:
			return (True, {"type": 4, "code": 9, "content": {"email": current_user["email"], 
																											"cartid": args[0]}})

#***************************************************************************************************
cart_command_handlers = {
	"new-cart": handle_new_cart,
	"nc": handle_new_cart,

	"edit-cart": handle_edit_cart,
	"ec": handle_edit_cart,

	"remove-cart": handle_remove_cart,
	"rc": handle_remove_cart,

	"add-product": handle_add_product,
	"ap": handle_add_product,

	"edit-product-quantity": handle_edit_product_quantity,
	"epq": handle_edit_product_quantity,

	"remove-product": handle_remove_product,
	"rp": handle_remove_product,

	"list-cart-products": handle_list_cart_products,
	"lcp": handle_list_cart_products,

	"list-carts": handle_list_carts,
	"lc": handle_list_carts,

	"purchase-cart": handle_purchase,
	"pc": handle_purchase
}