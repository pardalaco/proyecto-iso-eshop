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


#***************************************************************************************************
def handle_login(privilege: int, args: list[str]) -> tuple[bool, dict]:
	if (len(args) != 2):
		return (False, "Invalid Argument Count")

	return (True, {"type": 1, "code": 1, "content": {"email": args[0], "password": args[1]}})


#***************************************************************************************************
def handle_signup(privilege: int, args: list[str]) -> tuple[bool, dict]:
	if (len(args) != 2):
		return (False, "Invalid Argument Count")

	return (True, {"type": 1, "code": 2, "content": {"email": args[0], "password": args[1]}})


#***************************************************************************************************
def handle_logout(privilege: int, args: list[str]) -> tuple[bool, dict]:
	return (False, "@todo")


#***************************************************************************************************
user_command_handlers = {
    "login": handle_login,
    "signup": handle_signup,
    "logout": handle_logout
}