- [**JSON Message Structure**](#json-message-structure)
	- [**Main format**](#main-format)
	- [**Type and Code Meaning**](#type-and-code-meaning)
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
			- [**4.4. Purchase**](#44-purchase)
		- [**5. User Info**](#5-user-info)
			- [**5.1. Edit name**](#51-edit-name)
			- [**5.2. Edit email**](#52-edit-email)
			- [**5.3. Edit password**](#53-edit-password)
			- [**5.4. Edit Payment**](#54-edit-payment)
			- [**5.5. Edit Address**](#55-edit-address)
		- [**6. Information Requests**](#6-information-requests)
			- [**6.1. Request User Info**](#61-request-user-info)
			- [**6.2. Request Cart Info**](#62-request-cart-info)
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
## **Type and Code Meaning**
* Type 0 → Error
  - Code 0 → Invalid Type or Code 
* Type 1 → User Access:
  - Code 1 → Log in
  - Code 2 → Sign up
* Type 2 → Product(s) Request
  - Code 1 → All products
  - Code 2 → Search by ID
  - Code 3 → Search by TAG(s)
  - Code 4 → Search by Keyword
* Type 3 → Manage Products (Admin)
  - Code 1 → Add product
  - Code 2 → Edit product
  - Code 3 → Remove product
* Type 4 → Related to Carts
  - Code 1 → Create Cart
  - Code 2 → Edit Cart name
  - Code 3 → Delete Cart
	- Code 4 → Add product
	- Code 5 → Edit quantity of product
	- Code 6 → Remove product
	- Code 7 → Purchase
* Type 5 → User Info
	- Code 1 → Edit Name
	- Code 2 → Edit Email
	- Code 3 → Edit Password
	- Code 4 → Edit Payment Option
	- Code 5 → Edit Address
* Type 6 → Information Request
	- Code 1 → Request User Info
	- Code 2 → Request Cart Info
* Type 7 → Orders
	- Code 1 → 
* Type 8 → Orders (ADMIN)
	- Code 1 →
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
---
&nbsp;
### **3. Manage Products (Admin)**
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
		name: "str"
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
		prevname: "str",
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
		name: "str"
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
		cartname: "str",
		id: "int"
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
		cartname: "str",
		id: "int",
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
		cartname: "str",
		id: "int"
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
#### **4.4. Purchase**
```js
@todo
client = {
	type: 4,
	code: 7,
	content: {
		cartname: "str",
	}
}
```
```js
server = {
	type: 4,
	code: 7,
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
#### **6.2. Request Cart Info**
```js
client = {
	type: 6,
	code: 2,
	content: {
		cartname: "str"
	}
}
```
```js
server = {
	type: 6,
	code: 2,
	content: {
		total: "float",
		products: "list"["dict"{
			id: "int",
			name: "str",
			image: "@todo",
			price: "float"
		}]
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
