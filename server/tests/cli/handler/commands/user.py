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
def handle_login(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		if isresponse:
			success = args[0]["content"]["success"]
			if success:
				current_user["privilege"] = PRIVILEGE_NORMAL_USER
				return (False, "Login Successful")
			else:
				current_user["email"] = None
				return (False, "Login Unsuccessful")
		else:
			if (len(args) != 2):
				return (False, "Invalid Argument Count")
			current_user["email"] = args[0]
			return (True, {"type": 1, "code": 1, "content": {"email": args[0], "password": args[1]}})
	else:
		return (False, "This command is unavailable while logged in")


#***************************************************************************************************
def handle_signup(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		if isresponse:
			success = args[0]["content"]["success"]
			if success:
				return (False, "Signup Successful")
			else:
				return (False, "Signup Unsuccessful")
		if (len(args) != 2):
			return (False, "Invalid Argument Count")
		return (True, {"type": 1, "code": 2, "content": {"email": args[0], "password": args[1]}})
	else:
		return (False, "This command is unavailable while logged in")


#***************************************************************************************************
def handle_logout(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		return (False, "You are not logged in")
	else:
		current_user["privilege"] = PRIVILEGE_NONE
		current_user["email"] = None
		return (False, "Successfully logged out")


#***************************************************************************************************
def handle_edit_payment(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		return (False, "You need to Log in to use this command")
	else:
		if isresponse:
			if args[0]["content"]["success"] == True:
				return (False, "Payment edited successfully")
			else:
				return (False, "There was an error while editing the payment")
		else:
			return (True, {"type": 5, "code": 4, "content": {"email": current_user["email"],
																												"payment": " ".join(args)}})


#***************************************************************************************************
def handle_edit_address(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		return (False, "You need to Log in to use this command")
	else:
		if isresponse:
			if args[0]["content"]["success"] == True:
				return (False, "Address edited successfully")
			else:
				return (False, "There was an error while editing the address")
		else:
			return (True, {"type": 5, "code": 5, "content": {"email": current_user["email"],
																												"address": " ".join(args)}})


#***************************************************************************************************
def handle_user_info(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		return (False, "You need to Log in to use this command")
	else:
		if isresponse:
			user_info = args[0]["content"]
			return (False, f"Email: {user_info['email']}\nPassword: {user_info['password']}"
											f"\nName: {user_info['name']}"
											f"\nPayment: {user_info['payment']}\nAddress: {user_info['address']}")
		else:
			return (True, {"type": 5, "code": 6, "content": {"email": current_user["email"]}})


#***************************************************************************************************
user_command_handlers = {
    "login": handle_login,
    "signup": handle_signup,
    "logout": handle_logout,

		"edit-payment": handle_edit_payment,
		"epy": handle_edit_payment,

		"edit-address": handle_edit_address,
		"ead": handle_edit_address,

		"user-info": handle_user_info,
		"ui": handle_user_info
}