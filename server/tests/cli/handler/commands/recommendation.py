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
from .. import PRIVILEGE_ADMIN, PRIVILEGE_NORMAL_USER, PRIVILEGE_NONE


#***************************************************************************************************
def handle_rate_product(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		return (False, "You need to Log in to use this command")
	else:
		if isresponse:
			if args[0]["content"]["success"]:
				return (False, "Product Rated")
			else:
				return (False, "There was an error rating the product")
		else:
			return (True, {"type": 8, "code": 1, 
										"content": {"email": current_user["email"],
																"productid": args[0],
																"rating": args[1],
																"comment": " ".join(args[2:]) if len(args) > 2 else None}})


#***************************************************************************************************
def handle_view_ratings(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		return (False, "You need to Log in to use this command")
	else:
		if isresponse:
			product_ratings = "Ratings:\n"
			for i, rating in enumerate(args[0]["content"]["ratings"]):
				product_ratings += f"\n{i + 1}.- *{rating['rating']:.2f}*, {rating['email']} ({rating['date']})"
				if rating["comment"]:
					product_ratings += f"\n\t{rating['comment']}"
			return (False, product_ratings)
		else:
			return (True, {"type": 8, "code": 2, "content": {"productid": args[0]}})


#***************************************************************************************************
def handle_list_recommended(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		return (False, "You need to Log in to use this command")
	else:
		if isresponse:
			products = ""
			for item in args[0]["content"]["products"]:
				products += (f"\n*{item['rating']:.2f}({item['count']})* {item['id']}: {item['name']} - "
											f"{item['price']}€")
			return (False, products)
		else:
			if len(args) == 0:
				return (True, {"type": 8, "code": 3, "content": {"email": current_user["email"]}})
			elif args[0] == "-tags":
				return (True, {"type": 8, "code": 4, "content": {"email": current_user["email"],
																													"tags": ",".join(args[1:])}})


#***************************************************************************************************
def handle_my_marketing(isresponse: bool, current_user: dict, args: list[str]) -> tuple[bool, dict]:
	if current_user["privilege"] == PRIVILEGE_NONE:
		return (False, "You need to Log in to use this command")
	else:
		if isresponse:
			user_tags = ""
			for i, tag in enumerate(args[0]["content"]["tags"]):
				user_tags += f"\n{tag['tag']}, {tag['weight']}, ({tag['count']} since last interaction)"
			return (False, user_tags)
		else:
			return (True, {"type": 8, "code": 5, "content": {"email": current_user["email"]}})


#***************************************************************************************************
recommendation_command_handlers = {
    "rate": handle_rate_product,
		"rt": handle_rate_product,

		"view-ratings": handle_view_ratings,
		"vr": handle_view_ratings,

		"list-recommended": handle_list_recommended,
		"lr": handle_list_recommended,

		"my_marketing": handle_my_marketing,
		"mm": handle_my_marketing,
}