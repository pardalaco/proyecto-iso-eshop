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

from .commands.general import general_command_handlers
from .commands.user import user_command_handlers
from .commands.shop import shop_command_handlers
from .commands.cart import cart_command_handlers
from .commands.order import order_command_handlers
from .commands.admin import admin_command_handlers

from . import PRIVILEGE_ADMIN, PRIVILEGE_NORMAL_USER, PRIVILEGE_NONE


#***************************************************************************************************
COMMANDS = {**general_command_handlers, **user_command_handlers, **shop_command_handlers, 
						**cart_command_handlers, **order_command_handlers, **admin_command_handlers}


#***************************************************************************************************
def execute_command(input_list: list[str], current_user: dict, 
										isresponse: bool = False, response: str = None) -> Union[tuple[bool, str], 
																																						tuple[bool, dict]]:
	command = input_list[0].lower()
	command_handler = COMMANDS.get(command, handle_default)
	if isresponse:
		args = [response]
	else:
		args = input_list[1:]
	return command_handler(isresponse, current_user, args)


#***************************************************************************************************
def handle_default(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, str]:
	return (False, "Unknown command.")