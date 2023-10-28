import sys
import os
current_directory = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(current_directory, '..'))

import asyncio
from config import settings
from src.server.server import Server

def main() -> None:
	server_instance = Server(
		host = settings.HOST,
		port = settings.PORT,
		buffer_size = settings.BUFFER_SIZE
	)

	asyncio.run(server_instance.start())

if __name__ == "__main__":
	main()