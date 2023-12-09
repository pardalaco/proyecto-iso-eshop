- [**JSON Message Structure**](#json-message-structure)
	- [**Main format**](#main-format)
	- [**JSON Definitions**](#json-definitions)
		- [**0. Error**](#0-error)
			- [**0.0. Invalid Type or Code**](#00-invalid-type-or-code)
		- [**1. User Access**](#1-user-access)
			- [**1.1. Log in**](#11-log-in)
			- [**1.2. Sign up**](#12-sign-up)
			- [**1.3. Is user Admin**](#13-is-user-admin)
		- [**2. Request Product(s)**](#2-request-products)
			- [**2.1. Request all Products**](#21-request-all-products)
			- [**2.2. Request product by ID**](#22-request-product-by-id)
			- [**2.3. Request product(s) by TAG(s)**](#23-request-products-by-tags)
			- [**2.4. Request all Tags**](#24-request-all-tags)
		- [**3. Manage Products (Admin)**](#3-manage-products-admin)
			- [**3.1. Add new product**](#31-add-new-product)
			- [**3.2. Edit product**](#32-edit-product)
			- [**3.3. Remove product**](#33-remove-product)
			- [**3.4. Add new tag**](#34-add-new-tag)
		- [**4. Related to Cart**](#4-related-to-cart)
			- [**4.1. Create Cart**](#41-create-cart)
			- [**4.2. Edit Cart name**](#42-edit-cart-name)
			- [**4.3. Delete Cart**](#43-delete-cart)
			- [**4.4. Add product**](#44-add-product)
			- [**4.5. Edit quantity of product**](#45-edit-quantity-of-product)
			- [**4.6. Remove product**](#46-remove-product)
			- [**4.7. Request Cart Products**](#47-request-cart-products)
			- [**4.8. Request all Carts**](#48-request-all-carts)
			- [**4.9. Purchase**](#49-purchase)
		- [**5. User Info**](#5-user-info)
			- [**5.1. Edit name**](#51-edit-name)
			- [**5.2. Edit email**](#52-edit-email)
			- [**5.3. Edit password**](#53-edit-password)
			- [**5.4. Edit Payment**](#54-edit-payment)
			- [**5.5. Edit Address**](#55-edit-address)
			- [**5.6. Request User Info**](#56-request-user-info)
		- [**6. Orders**](#6-orders)
			- [**6.1. Request Orders**](#61-request-orders)
			- [**6.2. Request Order Details**](#62-request-order-details)
			- [**6.3. Cancel Order**](#63-cancel-order)
		- [**7. Orders (ADMIN)**](#7-orders-admin)
			- [**7.1. List All Orders**](#71-list-all-orders)
			- [**7.2. Change Order Status**](#72-change-order-status)
		- [**8. Recommendations and Product Rating**](#8-recommendations-and-product-rating)
			- [**8.1. Rate Product**](#81-rate-product)
			- [**8.2. View Product Ratings**](#82-view-product-ratings)
			- [**8.3. Request Recommended Products**](#83-request-recommended-products)
			- [**8.4. Request Recommended Products by Tag**](#84-request-recommended-products-by-tag)
			- [\*\*8.4. Request User Marketing Profile \*\*](#84-request-user-marketing-profile-)
# **JSON Message Structure**
## **Main format**
```js
{
	type: "int",
	code: "int",
	content: "dict"{}
}
```
## **JSON Definitions**
---
&nbsp;
### **0. Error**
#### **0.0. Invalid Type or Code**
```js
server = 	{
				type: 0,
				code: 0,			
				content: {
					details: "str"
				}
			}
```
---
&nbsp;
### **1. User Access**
#### **1.1. Log in**
```js
client = {
	type: 1,
	code: 1,
	content: {
		email: "str",
		password: "str"
	}
}
```
```js
server = {
	type: 1,
	code: 1,
	content: {
		success: "bool",
		admin: "bool"
	}
}
```
#### **1.2. Sign up**
```js
client = {
	type: 1,
	code: 2,
	content: {
		email: "str",
		password: "str"
	}
}
```
```js
server = {
	type: 1,
	code: 2,
	content: {
		success: "bool"
	}
}
```
#### **1.3. Is user Admin**
```js
client = {
	type: 1,
	code: 3,
	content: {
		email: "str",
	}
}
```
```js
server = {
	type: 1,
	code: 3,
	content: {
		success: "bool"
	}
}
```
---
&nbsp;
### **2. Request Product(s)**
#### **2.1. Request all Products**
```js
client = {
	type: 2,
	code: 1,
	content: {}
}
```
```js
server = {
	type: 2,
	code: 1,
	content: {
		amount: "int",
		products: "list"[
			"dict"{
				id: "int", 
				name: "str", 
				description: "str", 
				image: "image",
				price: "float",
				rating: "float",
				count: "int",
				tags: "str,str,.."
			}
		]
	}
}
```
#### **2.2. Request product by ID**
```js
client = {
	type: 2,
	code: 2,
	content: {
		email: "str",
		id: "int"
	}
}
```
```js
server = {
	type: 2,
	code: 2,
	content: {
		id: "int", 
		name: "str", 
		description: "str", 
		image: "image",
		price: "float",
		rating: "float",
		count: "int",
		tags: "str,str,.."
	}
}
```
#### **2.3. Request product(s) by TAG(s)**
```js
client = {
	type: 2,
	code: 3,
	content: {
		email: "str",
		tags: "str,str,.." 
	}
}
```
```js
server = {
	type: 2,
	code: 3,
	content: {
		amount: "int",
		products: "list"[
			"dict"{
				id: "int", 
				name: "str", 
				description: "str", 
				image: "image",
				price: "float",
				rating: "float",
				count: "int",
				tags: "str,str,.."
			}
		]
	}
}
```
#### **2.4. Request all Tags**
```js
client = {
	type: 2,
	code: 4,
	content: {}
}
```
```js
server = {
	type: 2,
	code: 4,
	content: {
		tags: "list"["str"]
	}
}
```
---
&nbsp;
### **3. Manage Products (Admin)**
#### **3.1. Add new product**
```js
client = {
	type: 3,
	code: 1,
	content: {
		email: "str",
		name: "str", 
		description: "str", 
		image: "image",
		price: "float",
		tags: "str,str,.."
	}
}
```
```js
server = {
	type: 3,
	code: 1,
	content: {
		success: "bool"
	}
}
```
#### **3.2. Edit product**
```js
client = {
	type: 3,
	code: 2,
	content: {
		email: "str",
		productid: "int",
		tagop: "int", // 0 = Add, 1 = Remove | Only if "field" == "tags"
		"str"(field): "str"(value),
		"str"(field): "str"(value),
		..
	}
}
```
> *Content is a dictionary where the key is the field to edit, and the value is the value of what the new field value should be*
> *Field must be an attribute of **Product***
> *If field == "tags", value = "str,str,str,..."*
```js
server = {
	type: 3,
	code: 2,
	content: {
		success: "bool"
	}
}
```
#### **3.3. Remove product**
```js
client = {
	type: 3,
	code: 3,
	content: {
		email: "str",
		productid: "int"
	}
}
```
```js
server = {
	type: 3,
	code: 3,
	content: {
		success: "bool"
	}
}
```
#### **3.4. Add new tag**
```js
client = {
	type: 3,
	code: 4,
	content: {
		email: "str",
		tag: "str"
	}
}
```
```js
server = {
	type: 3,
	code: 4,
	content: {
		success: "bool"
	}
}
```
---
&nbsp;
### **4. Related to Cart**
#### **4.1. Create Cart**
```js
client = {
	type: 4,
	code: 1,
	content: {
		email: "str",
		cartname: "str"
	}
}
```
```js
server = {
	type: 4,
	code: 1,
	content: {
		success: "bool"
	}
}
```
#### **4.2. Edit Cart name**
```js
client = {
	type: 4,
	code: 2,
	content: {
		email: "str",
		cartid: "int",
		newname: "str"
	}
}
```
```js
server = {
	type: 4,
	code: 2,
	content: {
		success: "bool"
	}
}
```
#### **4.3. Delete Cart**
```js
client = {
	type: 4,
	code: 3,
	content: {
		email: "str",
		cartid: "int"
	}
}
```
```js
server = {
	type: 4,
	code: 3,
	content: {
		success: "bool"
	}
}
```
#### **4.4. Add product**
```js
client = {
	type: 4,
	code: 4,
	content: {
		email: "str",
		cartid: "int",
		productid: "int"
	}
}
```
```js
server = {
	type: 4,
	code: 4,
	content: {
		success: "bool"
	}
}
```
#### **4.5. Edit quantity of product**
```js
client = {
	type: 4,
	code: 5,
	content: {
		email: "str",
		cartid: "int",
		productid: "int",
		quantity: "int"
	}
}
```
```js
server = {
	type: 4,
	code: 5,
	content: {
		success: "bool"
	}
}
```
#### **4.6. Remove product**
```js
client = {
	type: 4,
	code: 6,
	content: {
		email: "str",
		cartid: "int",
		productid: "int"
	}
}
```
```js
server = {
	type: 4,
	code: 6,
	content: {
		success: "bool"
	}
}
```
#### **4.7. Request Cart Products**
```js
client = {
	type: 4,
	code: 7,
	content: {
		email: "str",
		cartid: "int",
	}
}
```
```js
server = {
	type: 4,
	code: 7,
	content: {
		success: "bool",
		amount: "int",
		total: "float",
		products: "list"[
			"dict"{
				id: "int", 
				name: "str", 
				description: "str", 
				image: "image",
				price: "float",
				tags: "str,str,..",
				quantity: "int"
			}
		]
	}
}
```
#### **4.8. Request all Carts**
```js
client = {
	type: 4,
	code: 8,
	content: {
		email: "str"
	}
}
```
```js
server = {
	type: 4,
	code: 8,
	content: {
		carts: "list"[
			"dict"{
				cartid: "int",
				cartname: "str",
				total: "float"							
			}
		]
	}
}
```
#### **4.9. Purchase**
```js
client = {
	type: 4,
	code: 9,
	content: {
		email: "str",
		cartid: "int",
	}
}
```
```js
server = {
	type: 4,
	code: 9,
	content: {
		success: "bool"
		orderid: "int"
	}
}
```
---
&nbsp;
### **5. User Info**
#### **5.1. Edit name**
```js
client = {
	type: 5,
	code: 1,
	content: {
		email: "str",
		name: "str"
	}
}
```
```js
server = {
	type: 5,
	code: 1,
	content: {
		success: "bool"
	}
}
```
#### **5.2. Edit email**
```js
client = {
	type: 5,
	code: 2,
	content: {
		email: "str",
		newemail: "str"
	}
}
```
```js
server = {
	type: 5,
	code: 2,
	content: {
		success: "bool"
	}
}
```
#### **5.3. Edit password**
```js
client = {
	type: 5,
	code: 3,
	content: {
		email: "str",
		password: "str"
	}
}
```
```js
server = {
	type: 5,
	code: 3,
	content: {
		success: "bool"
	}
}
```
#### **5.4. Edit Payment**
```js
client = {
	type: 5,
	code: 4,
	content: {
		email: "str",
		payment: "str",
	}
}
```
```js
server = {
	type: 5,
	code: 4,
	content: {
		success: "bool"
	}
}
```
#### **5.5. Edit Address**
```js
client = {
	type: 5,
	code: 5,
	content: {
		email: "str",
		address: "str",
	}
}
```
```js
server = {
	type: 5,
	code: 5,
	content: {
		success: "bool"
	}
}
```
#### **5.6. Request User Info**
```js
client = {
	type: 5,
	code: 6,
	content: {}
}
```
```js
server = {
	type: 5,
	code: 6,
	content: {
		email: "str",
		password: "str",
		name: "str",
		payment: "str",
		address: "str"
	}
}
```
---
&nbsp;
### **6. Orders**
#### **6.1. Request Orders**
```js
client = {
	type: 6,
	code: 1,
	content: {
		email: "str"
	}
}
```
```js
server = {
	type: 6,
	code: 1,
	content: {
		orders: "list"[
			"dict"{
				orderid: "int",
				date: "date",
				total: "float",
				status: "str"
			}
		]
	}
}
```
#### **6.2. Request Order Details**
```js
client = {
	type: 6,
	code: 2,
	content: {
		email: "str",
		orderid: "int"
	}
}
```
```js
server = {
	type: 6,
	code: 1,
	content: {
		success: "bool",
		orderid: "int",
		email: "str",
		address: "str",
		payment: "str",
		date: "date",
		total: "float",
		status: "str"
	}
}
```
#### **6.3. Cancel Order**
```js
client = {
	type: 6,
	code: 3,
	content: {
		email: "str",
		orderid: "int"
	}
}
```
```js
server = {
	type: 6,
	code: 3,
	content: {
		success: "bool"
	}
}
```
---
&nbsp;
### **7. Orders (ADMIN)**
#### **7.1. List All Orders**
```js
client = {
	type: 7,
	code: 1,
	content: {
		email: "str",
	}
}
```
```js
server = {
	type: 7,
	code: 1,
	content: {
		amount: "int",
		orders: "list"[
			"dict"{
				orderid: "int",
				email: "str",
				adddress: "str",
				payment: "str",
				date: "date",
				total: "float",
				status: "str"
			}
		]
	}
}
```
#### **7.2. Change Order Status**
```js
client = {
	type: 7,
	code: 2,
	content: {
		email: "str",
		orderid: "int",
		status: "int" // 0 = "Invoiced", 1 = "Prepared", 2 = "Shipped", 3 = "Out for Delivery", 
									// 4 = "Delivered", 5, "Cancelled"
	}
}
```
```js
server = {
	type: 7,
	code: 2,
	content: {
		success: "bool"
	}
}
```
---
&nbsp;
### **8. Recommendations and Product Rating**
#### **8.1. Rate Product**
```js
client = {
	type: 8,
	code: 1,
	content: {
		email: "str",
		productid: "int",
		rating: "float",
		comment: "str"(optional)
	}
}
```
```js
server = {
	type: 8,
	code: 1,
	content: {
		success: "bool"
	}
}
```
#### **8.2. View Product Ratings**
```js
client = {
	type: 8,
	code: 2,
	content: {
		productid: "int"
	}
}
```
```js
server = {
	type: 8,
	code: 2,
	content: {
		amount: "int",
		ratings: "list"[
			"dict"{
				email: "str",
				rating: "float",
				comment: "str",
				date: "date"
			}
		]
	}
}
```
#### **8.3. Request Recommended Products**
```js
client = {
	type: 8,
	code: 3,
	content: {
		email: "str"
	}
}
```
```js
server = {
	type: 8,
	code: 3,
	content: {
		amount: "int",
		products: "list"[
			"dict"{
				id: "int", 
				name: "str", 
				description: "str", 
				image: "image",
				price: "float",
				rating: "float",
				count: "int",
				tags: "str,str,.."
			}
		]
	}
}
```
#### **8.4. Request Recommended Products by Tag**
```js
client = {
	type: 8,
	code: 3,
	content: {
		email: "str",
		tags: "str,str,.." 
	}
}
```
```js
server = {
	type: 8,
	code: 3,
	content: {
		amount: "int",
		products: "list"[
			"dict"{
				id: "int", 
				name: "str", 
				description: "str", 
				image: "image",
				price: "float",
				rating: "float",
				count: "int",
				tags: "str,str,.."
			}
		]
	}
}
```
#### **8.4. Request User Marketing Profile **
```js
client = {
	type: 8,
	code: 5,
	content: {
		email: "str"
	}
}
```
```js
server = {
	type: 8,
	code: 5,
	content: {
		amount: "int",
		tags: "list"[
			"dict"{
				tag: "str",
				weight: "float",
				count: "int"
			}
		]
	}
}
```