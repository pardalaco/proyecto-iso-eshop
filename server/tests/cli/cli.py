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
import asyncio
import subprocess
import os
import sys

import json

from handler.handler import execute_command


#***************************************************************************************************
PRIVILEGE_NONE = 0
PRIVILEGE_NORMAL_USER = 1
PRIVILEGE_ADMIN = 2

current_user = {"privilege": PRIVILEGE_NONE, "email": None}
input_type = ["\n: ", "\n>> ", "\n# "]


#***************************************************************************************************
def get_user_input() -> list[str]:
	user_input = input(input_type[current_user["privilege"]])
	return user_input.split()


#***************************************************************************************************
async def main() -> None:
	host = "127.0.0.1"
	port = 32768
	try:
		reader, writer = await asyncio.open_connection(host, port)
	except Exception as e:
		print(e)
		sys.exit(1)

	print("Welcome to eShop!\nType [help, h] to see what you can do at any time!")
	while True:
		input_list = get_user_input()
		communication, message = execute_command(input_list, current_user)
		if communication:
			message = json.dumps(message)
			writer.write(message.encode())

			data = b""
			try:
				while True:
					chunk = await asyncio.wait_for(reader.read(1024), timeout = 0.2)
					if not chunk:
						break
					data += chunk
			except asyncio.TimeoutError:
				# End of data chunks
				pass
			data = data.decode()
			response = json.loads(data)
			communication, message = execute_command(input_list, current_user, True, response)
		else:
			if message is None:
				print("Exiting the application")
				sys.exit(0)
		print(message)

	writer.close()
	await writer.wait_closed()


#***************************************************************************************************
if __name__ == "__main__":
	asyncio.run(main())