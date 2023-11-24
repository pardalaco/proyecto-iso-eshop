- [**JSON Message Structure**](#json-message-structure)
	- [**Main format**](#main-format)
	- [**JSON Definitions**](#json-definitions)
		- [**0. Error**](#0-error)
			- [**0.0. Invalid Type or Code**](#00-invalid-type-or-code)
		- [**1. User Access**](#1-user-access)
			- [**1.1. Log in**](#11-log-in)
			- [**1.2. Sign up**](#12-sign-up)
		- [**2. Request Product(s)**](#2-request-products)
			- [**2.1. Request all Products**](#21-request-all-products)
			- [**2.2. Request product by ID**](#22-request-product-by-id)
			- [**2.3. Request product(s) by TAG(s)**](#23-request-products-by-tags)
			- [**2.4. Request product(s) by Keyword**](#24-request-products-by-keyword)
			- [**2.5. Request all Tags**](#25-request-all-tags)
		- [**3. Manage Products (Admin)**](#3-manage-products-admin)
			- [**3.1. Add new product**](#31-add-new-product)
			- [**3.2. Edit product**](#32-edit-product)
			- [**3.3. Remove product**](#33-remove-product)
		- [**4. Related to Cart**](#4-related-to-cart)
			- [**4.1. Create Cart**](#41-create-cart)
			- [**4.2. Edit Cart name**](#42-edit-cart-name)
			- [**4.3. Delete Cart**](#43-delete-cart)
			- [**4.4. Add product**](#44-add-product)
			- [**4.5. Edit quantity of product**](#45-edit-quantity-of-product)
			- [**4.6. Remove product**](#46-remove-product)
			- [**4.6. Request Cart Products**](#46-request-cart-products)
			- [**4.8. Request all Carts**](#48-request-all-carts)
			- [**4.9. Purchase**](#49-purchase)
		- [**5. User Info**](#5-user-info)
			- [**5.1. Edit name**](#51-edit-name)
			- [**5.2. Edit email**](#52-edit-email)
			- [**5.3. Edit password**](#53-edit-password)
			- [**5.4. Edit Payment**](#54-edit-payment)
			- [**5.5. Edit Address**](#55-edit-address)
		- [**6. Information Requests**](#6-information-requests)
			- [**6.1. Request User Info**](#61-request-user-info)
		- [**7. Orders**](#7-orders)
			- [**7.1. @todo**](#71-todo)
		- [**8. Orders (ADMIN)**](#8-orders-admin)
			- [**8.1. @todo**](#81-todo)
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
				image: "@todo",
				price: "float",
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
		image: "@todo",
		price: "float",
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
				image: "@todo",
				price: "float",
				tags: "str,str,.."
			}
		]
	}
}
```
#### **2.4. Request product(s) by Keyword**
```js
client = {
	type: 2,
	code: 4,
	content: {
		keyword: "str"
	}
}
```
```js
server = {
	type: 2,
	code: 4,
	content: {
		amount: "int",
		products: "list"[
			"dict"{
				id: "int", 
				name: "str", 
				description: "str", 
				image: "@todo",
				price: "float",
				tags: "str,str*,.."
			}
		]
	}
}
```
#### **2.5. Request all Tags**
```js
client = {
	type: 2,
	code: 5,
	content: {}
}
```
```js
server = {
	type: 2,
	code: 5,
	content: {
		tags: "list"["str"]
	}
}
```
---
&nbsp;
### **3. Manage Products (Admin)**
@todo these should send mail to check if admin = true
#### **3.1. Add new product**
```js
client = {
	type: 3,
	code: 1,
	content: {
		id: "int", 
		name: "str", 
		description: "str", 
		image: "@todo",
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
		"str"(field): "str"(value),
		"str"(field): "str"(value),
		..
	}
}
```
> *Content is a dictionary where the key is the field to edit, and the value is the value of what the new field value should be*
> *Field must be an attribute of **Product***
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
		id: "int"
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
#### **4.6. Request Cart Products**
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
		products: "list"[
			"dict"{
				id: "int", 
				name: "str", 
				description: "str", 
				image: "@todo",
				price: "float",
				tags: "str,str,.."
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
				cartname: "str"							
			}
		]
	}
}
```
#### **4.9. Purchase**
```js
@todo
client = {
	type: 4,
	code: 9,
	content: {
		cartname: "str",
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
@todo this ones should send the user email always
#### **5.1. Edit name**
```js
client = {
	type: 5,
	code: 1,
	content: {
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
		email: "str"
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
		op: "int", // 0: add, 1: remove
		payment: "str"
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
		op: "int", // 0: add, 1: remove
		address: "str"
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
---
&nbsp;
### **6. Information Requests**
#### **6.1. Request User Info**
```js
client = {
	type: 6,
	code: 1,
	content: {}
}
```
```js
server = {
	type: 6,
	code: 1,
	content: {
		email: "str",
		name: "str",
		surname: "str",
		payments: "list"["str"],
		addresses: "list"["str"]
	}
}
```
---
&nbsp;
### **7. Orders**
#### **7.1. @todo**

---
&nbsp;
### **8. Orders (ADMIN)**
#### **8.1. @todo**
