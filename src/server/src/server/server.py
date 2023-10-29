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
import logging
import time

import schedule

from src.database.database import Database


#***************************************************************************************************
class Server:
	def __init__(self, host: str, port: int, buffer_size: int) -> None:
		self.host = host
		self.port = port
		self.buffer_size = buffer_size
		self.database = Database()

		self.schedule_daily_task()


#***************************************************************************************************
	def schedule_daily_task(self) -> None:
		self.set_up_logger()
		schedule.every().day.at("00:00").do(self.set_up_logger)
		self.run_daily_tasks()


#***************************************************************************************************
	def run_daily_tasks(self):
		while True:
			schedule.run_pending()
			time.sleep(1)


#***************************************************************************************************
	def set_up_logger(self) -> None: 
		now = time.datetime.now()

		# Configure and set loggers
		logger_formatter_stream = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
		logger_formatter_file = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
		logger_stream_handler = logging.StreamHandler()
		logger_stream_handler.setFormatter(logger_formatter_stream)

		# Set up main logger
		self.logger = logging.getLogger("Logger")
		self.logger.setLevel(logging.INFO)
		self.logger.addHandler(logger_stream_handler)
		main_file_handler = logging.FileHandler(f"../../logs/{now.day}_{now.month}_{now.year}.log")
		main_file_handler.setFormatter(logger_formatter_file)
		self.logger.addHandler(main_file_handler)


#***************************************************************************************************
	async def handle_client(self, reader: asyncio.StreamReader, writer: asyncio.StreamWriter) -> None:
		# @todo Real implementation
		data = await reader.read(self.buffer_size)
		message = data.decode('utf-8')
		addr = writer.get_extra_info('peername')

		print(f"Received {message} from {addr}")

		writer.write("ACK".encode('utf-8'))
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