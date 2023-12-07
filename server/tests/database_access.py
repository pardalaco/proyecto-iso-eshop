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
import json


#***************************************************************************************************
async def tcp_client(message: str, host: str, port: int) -> None:
    reader, writer = await asyncio.open_connection(host, port)

    print(f"Send: {message}")
    writer.write(message.encode())

    data = await reader.read(1024)
    print(f"Received: {data.decode()}")

    writer.close()
    await writer.wait_closed()


#***************************************************************************************************
def test_error() -> None:
	print("\nTesting Invalid Type & Code")
	msg_type = 43
	msg_code = 123
	msg_content = {"This": "won't work"}
	message = json.dumps({"type": msg_type, "code": msg_code, "content": msg_content})
	asyncio.run(tcp_client(message, "127.0.0.1", 32768))


#***************************************************************************************************
def test_login() -> None:
	print("\nTesting User Log in")
	msg_type = 1
	msg_code = 1
	msg_content = {"email": "test@gmail.com", "password": "test"}
	message = json.dumps({"type": msg_type, "code": msg_code, "content": msg_content})
	asyncio.run(tcp_client(message, "127.0.0.1", 32768))


#***************************************************************************************************
def test_wrong_password() -> None:
	print("\nTesting wrong password Log in")
	msg_type = 1
	msg_code = 1
	msg_content = {"email": "test@gmail.com", "password": "wrong"}
	message = json.dumps({"type": msg_type, "code": msg_code, "content": msg_content})
	asyncio.run(tcp_client(message, "127.0.0.1", 32768))


#***************************************************************************************************
def test_wrong_email() -> None:
	print("\nTesting wrong email Log in")
	msg_type = 1
	msg_code = 1
	msg_content = {"email": "test@gmail.com", "password": "wrong"}
	message = json.dumps({"type": msg_type, "code": msg_code, "content": msg_content})
	asyncio.run(tcp_client(message, "127.0.0.1", 32768))


#***************************************************************************************************
def test_admin_login() -> None:
	print("\nTesting admin user Log in")
	msg_type = 1
	msg_code = 1
	msg_content = {"email": "hmongom@gmail.com", "password": "hmongom"}
	message = json.dumps({"type": msg_type, "code": msg_code, "content": msg_content})
	asyncio.run(tcp_client(message, "127.0.0.1", 32768))


#***************************************************************************************************
def test_fetch_all_products() -> None:
	print("\nTesting Fetch All Products")
	msg_type = 2
	msg_code = 1
	msg_content = {}
	message = json.dumps({"type": msg_type, "code": msg_code, "content": msg_content})
	asyncio.run(tcp_client(message, "127.0.0.1", 32768))


#***************************************************************************************************
if __name__ == "__main__":
	test_error()
	test_login()
	test_wrong_password()
	test_wrong_email()
	test_admin_login()
	test_fetch_all_products()

	
	

	