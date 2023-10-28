import asyncio

class Server:
	def __init__(self, host: str, port: int, buffer_size: int) -> None:
		self.host = host
		self.port = port
		self.buffer_size = buffer_size

	async def handle_client(self, reader: asyncio.StreamReader, writer: asyncio.StreamWriter) -> None:
		# @todo Real implementation
		data = await reader.read(self.buffer_size)
		message = data.decode('utf-8')
		addr = writer.get_extra_info('peername')

		print(f"Received {message} from {addr}")

		writer.write("ACK".encode('utf-8'))
		await writer.drain()

		writer.close()

	async def start(self) -> bool:
		server = await asyncio.start_server(
			self.handle_client,
			self.host,
			self.port
		)
		print(f"Server started on {self.host}:{self.port}")
		
		async with server:
			await server.serve_forever()