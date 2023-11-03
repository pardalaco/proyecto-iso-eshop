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
import sys
import os
current_directory = os.path.dirname(os.path.abspath(__file__))
root_directory = os.path.join(current_directory, "..")
sys.path.append(root_directory)


#***************************************************************************************************
import asyncio

from config import settings
from src.server.server import Server


#***************************************************************************************************
def main() -> None:
	server_instance = Server(
		host = settings.HOST,
		port = settings.PORT,
		buffer_size = settings.BUFFER_SIZE
	)

	asyncio.run(server_instance.start())


#***************************************************************************************************
if __name__ == "__main__":
	main()