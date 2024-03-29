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
import time
import json

from src.database.database import Database
from src.server.message_handler import MessageHandler


#***************************************************************************************************
class Server:
	def __init__(self, host: str, port: int, buffer_size: int) -> None:
		self.host = host
		self.port = port
		self.buffer_size = buffer_size
		self.database = Database()


#***************************************************************************************************
	async def handle_client(self, reader: asyncio.StreamReader, writer: asyncio.StreamWriter) -> None:
		handler = MessageHandler()
		address = writer.get_extra_info('peername')

		while True:
			data = await reader.read(self.buffer_size)
			if not data:
				# Client disconnected
				break

			message = data.decode('utf-8')
			print(f"Received from {address}: {message}")
			
			try:
				message_json = json.loads(message)
				response = handler.handle_message(message_json)
			except json.JSONDecodeError:
				print(f"Received malformed JSON from {address}")
				response = "ERROR"

			print(f"Responded to {address}: {response}")
			writer.write(response.encode('utf-8'))
			await writer.drain()

		writer.close()


#***************************************************************************************************
	async def start(self) -> bool:
		server = await asyncio.start_server(
			self.handle_client,
			self.host,
			self.port
		)
		print(f"Server started on {self.host}:{self.port}")
		
		async with server:
			await server.serve_forever()