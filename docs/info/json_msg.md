
- [JSON Message Structure](#json-message-structure)
	- [Main format](#main-format)
	- [Type and code explanation](#type-and-code-explanation)
	- [JSON Definitions](#json-definitions)
		- [**User Access**](#user-access)
			- [**Log in**](#log-in)
			- [**Sign up**](#sign-up)
		- [**Request Product(s)**](#request-products)
			- [**Request all Products**](#request-all-products)
			- [**Request product(s) by ID**](#request-products-by-id)
			- [**Request product(s) by TAG(s)**](#request-products-by-tags)
# JSON Message Structure
## Main format
```js
{
	type: <int>,
	code: <int>,
	content: <dict{}>
}
```
## Type and code explanation
* Type 1 → User Access:
  - Code 1 → Log in
  - Code 2 → Sign up
* Type 2 → Product(s) Request
  - Code 1 → All products
  - Code 2 → Search by ID
  - Code 3 → Search by TAG(s)
## JSON Definitions
### **User Access**
#### **Log in**
* Sent from client
```js
{
	type: 1,
	code: 1,
	content: {
		email: <str>
		password: <str>
	}
}
```
* Sent from server
```js
{
	type: 1,
	code: 1,
	content: {
		success: <bool>,
		admin: <bool>
	}
}
```
#### **Sign up**
* Sent from client
```js
{
	type: 1,
	code: 2,
	content: {
		username: <str>,
		email: <str>,
		password: <str>
	}
}
```
* Sent from server
```js
{
	type: 1,
	code: 2,
	content: {
		success: <bool>
	}
}
```

---
### **Request Product(s)**
* Always sent from server
```js
{
	type: 2,
	code: 1,
	content: {
		amount: <int>,
		products: <list[<dict{id: <int>, name: <str>, description: <str>, price: <float>, tags: <list[<str>]>}>]>
	}
}
```
#### **Request all Products**
* Sent from client
```js
{
	type: 2,
	code: 1,
	content: {}
}
```
#### **Request product(s) by ID**
* Sent from client
```js
{

}
```
#### **Request product(s) by TAG(s)**
* Sent from client
```js
{

}
```