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
from typing import Union

from .. import PRIVILEGE_ADMIN, PRIVILEGE_NORMAL_USER, PRIVILEGE_NONE


#***************************************************************************************************
def handle_login(isresponse: bool, privilege: dict, args: list[str]) -> tuple[bool, dict]:
	if privilege["privilege"] == PRIVILEGE_NONE:
		if isresponse:
			success = args[0]["content"]["success"]
			if success:
				privilege["privilege"] = PRIVILEGE_NORMAL_USER
				return (False, "Login Successful")
			else:
				return (False, "Login Unsuccessful")
		else:
			if (len(args) != 2):
				return (False, "Invalid Argument Count")
			return (True, {"type": 1, "code": 1, "content": {"email": args[0], "password": args[1]}})
	else:
		return (False, "This command is unavailable while logged in")


#***************************************************************************************************
def handle_signup(isresponse: bool, privilege: int, args: list[str]) -> tuple[bool, dict]:
	if privilege["privilege"] == PRIVILEGE_NONE:
		if (len(args) != 2):
			return (False, "Invalid Argument Count")
		return (True, {"type": 1, "code": 2, "content": {"email": args[0], "password": args[1]}})
	else:
		return (False, "This command is unavailable while logged in")


#***************************************************************************************************
def handle_logout(isresponse: bool, privilege: int, args: list[str]) -> tuple[bool, dict]:
	if privilege["privilege"] == PRIVILEGE_NONE:
		return (False, "You are not logged in")
	else:
		privilege["privilege"] = PRIVILEGE_NONE
		return (False, "Successfully logged out")


#***************************************************************************************************
user_command_handlers = {
    "login": handle_login,
    "signup": handle_signup,
    "logout": handle_logout
}