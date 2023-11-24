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
def handle_quit(isresponse: bool, current_user: dict, args: list[str]) ->  tuple[bool, str]:
	return (False, None)


#***************************************************************************************************
def handle_help(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, str]:
	if current_user["privilege"] == PRIVILEGE_ADMIN:
		return (False, admin_help() + note_help())
	elif current_user["privilege"] == PRIVILEGE_NORMAL_USER:
		return (False, shop_help() + note_help())
	else:
		return (False, user_help() + note_help())


def user_help() -> str:
	return """
	Available Commands:
		login <email> <password> - Log in with your email and password.
		signup <email> <password> - Register a new account with email and password.
	"""
	

def shop_help() -> str:
	return """
	Available Commands:
		list-products (lp) [-tags <tag> <tag> ...] [keyword] - List products by tags or keyword. 
				If no tags or keyword are provided, it lists all available products.
	"""

def admin_help() -> str:
	return """
	Available Commands:
	"""

def note_help() -> str:
	return """	logout - Log out of the application.
		help (h) - Show this help message.
		quit (q, exit) - Exit the application.

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