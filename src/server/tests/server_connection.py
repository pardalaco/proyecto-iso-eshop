import asyncio

async def tcp_client(message: str, host: str, port: int):
    reader, writer = await asyncio.open_connection(host, port)

    print(f"Send: {message}")
    writer.write(message.encode())

    data = await reader.read(100)
    print(f"Received: {data.decode()}")

    writer.close()
    await writer.wait_closed()

# Usage
asyncio.run(tcp_client("Hello Server!", "127.0.0.1", 32768))