// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:eshop/models/Product.dart';
import 'package:eshop/models/Tag.dart';

class Connection {
  late Socket client;
  late StreamSubscription<List<int>> subscription;
  late var datos;
  var debeEsperar = true;
  var first = true;

  Future<void> _firstTime(Map<String, dynamic> js) async {
    client = await Socket.connect('10.0.2.2', 32768);
    final send = jsonEncode(js);
    client.write(send);
    subscription = client.listen((List<int> data1) {
      final jsonData = utf8.decode(data1);
      datos = jsonData;
      debeEsperar = false;
    }, onDone: () {
      client.destroy();
    });
    while (debeEsperar) {
      await Future.delayed(const Duration(milliseconds: 500));
    }
    debeEsperar = true;
    subscription.pause();
  }

  Future<void> _otherTime(Map<String, dynamic> js) async {
    final send = jsonEncode(js);
    client.write(send);
    subscription.resume();
    while (debeEsperar) {
      await Future.delayed(const Duration(milliseconds: 500));
    }
    debeEsperar = true;
    subscription.pause();
  }

  String getData() {
    return datos;
  }

  Future<void> closeConnection() async {
    client.destroy();
  }

  Future<void> query(Map<String, dynamic> js) async {
    if (first) {
      await _firstTime(js);
      first = false;
    } else {
      await _otherTime(js);
    }
  }

//METODOS DEFINIDOS EN EL JSON

// 1.USER ACCESS

  Future<String> logIn(String email, String password) async {
    /*return json.encode({
      "type": 1,
      "code": 1,
      "content": {
        "success": true,
        "admin": true,
      }
    });*/
    //@todo
    await query({
      "type": 1,
      "code": 1,
      "content": {"email": email, "password": password}
    });
    return getData();
  }

  Future<String> signUp(String email, String password) async {
    /*return json.encode({
      "type": 1,
      "code": 2,
      "content": {
        "success": true,
      }
    });*/
    //@todo
    await query({
      "type": 1,
      "code": 2,
      "content": {"email": email, "password": password}
    });
    return getData();
  }

  Future<String> isAdmin(String email) async {
    return json.encode({
      "type": 1,
      "code": 3,
      "content": {
        "success": true,
      }
    });
    //@todo
  }

  // 2.REQUEST PRODUCTS

  Future<String> getAllProducts() async {
    /*await Future.delayed(const Duration(seconds: 1));
    return json.encode({
      "type": 2,
      "code": 1,
      "content": {
        "amount": 2,
        "products": [
          {
            "id": 1,
            "name": "iPhone 12",
            "description": "Movil que funciona de maravilla pero radioactivo",
            "image": "/imagenes/iPhone12",
            "price": 799.99,
            "rating": 5,
            "count": 10,
            "tags": "tecnologia"
          },
          {
            "id": 2,
            "name": "Air Jordan Zoom",
            "description": "Zapatillas para saltar mucho",
            "image": "/imagenes/Jordan",
            "price": 180,
            "rating": 4.5,
            "count": 12,
            "tags": "ropa"
          }
        ]
      }
    });*/
    //@todo
    await query({"type": 2, "code": 1, "content": {}});
    return getData();
  }

  Future<String> getProductByID(String email, int p_id) async {
    await Future.delayed(const Duration(seconds: 1));
    return json.encode({
      "type": 2,
      "code": 2,
      "content": {
        "id": 1,
        "name": "iPhone 12",
        "description": "Movil que funciona de maravilla pero radioactivo",
        "image": "/imagenes/iPhone12",
        "price": 799.99,
        "rating": 5,
        "count": 10,
        "tags": "tecnologia"
      }
    });
    //@todo
  }

  Future<String> getProductByTags(String email, Tags tags) async {
    await Future.delayed(const Duration(seconds: 1));
    return json.encode({
      "type": 2,
      "code": 3,
      "content": {
        {
          "id": 1,
          "name": "iPhone 12",
          "description": "Movil que funciona de maravilla pero radioactivo",
          "image": "/imagenes/iPhone12",
          "price": 799.99,
          "rating": 5,
          "count": 10,
          "tags": "tecnologia"
        },
      }
    });
    //@todo
  }

  Future<String> getTags() async {
    /*return json.encode({
      "type": 2,
      "code": 4,
      "content": {
        "tags": ["Tag 1", "Tag 2", "Tag 3", "Tag 4"]
      }
    });*/
    //@todo
    await query({"type": 2, "code": 4, "content": {}});
    return getData();
  }

  // 3.Manage Product Admin

  Future<String> addNewProduct(Product product) async {
    return json.encode({
      "type": 3,
      "code": 1,
      "content": {
        "success": true,
      }
    });
    //@todo
  }

  Future<String> editProduct(Map<String, dynamic> content) async {
    return json.encode({
      "type": 3,
      "code": 2,
      "content": {
        "success": true,
      }
    });
    //@todo
  }

  Future<String> removeProduct(String email, int p_id) async {
    return json.encode({
      "type": 3,
      "code": 3,
      "content": {
        "success": true,
      }
    });
    //@todo
  }

  Future<String> addNewTag(String email, String tag) async {
    return json.encode({
      "type": 3,
      "code": 4,
      "content": {
        "success": true,
      }
    });
    //@todo
  }

  // 4.RELATED TO CART

  Future<String> createCart(String email, String cartname) async {
    /*return json.encode({
      "type": 4,
      "code": 1,
      "content": {
        "success": true,
      }
    });*/
    //@todo
    await query({
      "type": 4,
      "code": 1,
      "content": {"email": email, "cartname": cartname}
    });
    return getData();
  }

  Future<String> editCart(String email, int c_id, String newName) async {
    return json.encode({
      "type": 4,
      "code": 2,
      "content": {
        "success": true,
      }
    });
    //@todo
  }

  Future<String> deleteCart(String email, int c_id) async {
    return json.encode({
      "type": 4,
      "code": 3,
      "content": {
        "success": true,
      }
    });
    //@todo
  }

  Future<String> addToCart(String email, int c_id, int p_id) async {
    /*return json.encode({
      "type": 4,
      "code": 4,
      "content": {
        "success": true,
      }
    });*/
    //@todo
    await query({
      "type": 4,
      "code": 4,
      "content": {"email": email, "cartid": c_id, "productid": p_id}
    });
    return getData();
  }

  Future<String> editQuantity(String email, int c_id, int p_id, int q) async {
    return json.encode({
      "type": 4,
      "code": 5,
      "content": {
        "success": true,
      }
    });
    //@todo
  }

  Future<String> removeProductFromCart(String email, int c_id, int p_id) async {
    return json.encode({
      "type": 4,
      "code": 6,
      "content": {
        "success": true,
      }
    });
    //@todo
  }

  Future<String> requestCartProducts(String email, int c_id) async {
    return json.encode({
      "type": 4,
      "code": 4,
      "content": {
        "success": true,
        "amount": 2,
        "total": 12.14,
        "products": [
          {
            "id": 1,
            "name": "iPhone 12",
            "description": "Movil que funciona de maravilla pero radioactivo",
            "image": "/imagenes/iPhone12",
            "price": 799.99,
            "tags": "tecnologia",
            "quantity": 4
          },
          {
            "id": 2,
            "name": "Air Jordan Zoom",
            "description": "Zapatillas para saltar mucho",
            "image": "/imagenes/Jordan",
            "price": 180,
            "tags": "ropa",
            "quantity": 4
          }
        ]
      }
    });
    //@todo
  }

  Future<String> getAllCarts(String email) async {
    /*return json.encode({
      "type": 4,
      "code": 6,
      "content": {
        "carts": [
          {"cartid": 1, "cartname": "Cart 1", "total": 50.45},
          {"cartid": 2, "cartname": "Cart 2", "total": 20}
        ]
      }
    });*/
    //@todo
    await query({
      "type": 4,
      "code": 8,
      "content": {"email": email}
    });
    return getData();
  }

  Future<String> purchase(String email, int c_id) async {
    return json.encode({
      "type": 4,
      "code": 9,
      "content": {
        "success": true,
        "orderid": 1,
      }
    });
    //@todo
  }

  // 5.USER INFO

  Future<String> editName(String email, String name) async {
    return json.encode({
      "type": 5,
      "code": 1,
      "content": {
        "success": true,
      }
    });
    //@todo
  }

  Future<String> editEmail(String email, String newEmail) async {
    return json.encode({
      "type": 5,
      "code": 2,
      "content": {
        "success": true,
      }
    });
    //@todo
  }

  Future<String> editPassword(String email, String password) async {
    return json.encode({
      "type": 5,
      "code": 3,
      "content": {
        "success": true,
      }
    });
    //@todo
  }

  Future<String> editPayment(String email, String payment) async {
    return json.encode({
      "type": 5,
      "code": 4,
      "content": {
        "success": true,
      }
    });
    //@todo
  }

  Future<String> editAddress(String email, String address) async {
    return json.encode({
      "type": 5,
      "code": 5,
      "content": {
        "success": true,
      }
    });
    //@todo
  }

  Future<String> requestUserInfo(String email) async {
    /*return json.encode({
      "type": 5,
      "code": 1,
      "content": {
        "email": "Pablo@gmail.com",
        "password": "1234",
        "name": "Pablo",
        "payment": "00012457",
        "address": "Calle Ave del Paraiso",
      }
    });*/
    //@todo
    await query({
      "type": 5,
      "code": 6,
      "content": {"email": email}
    });
    return getData();
  }

  // 6.ORDERS

  Future<String> requestOrders(String email) async {
    return json.encode({
      "type": 6,
      "code": 1,
      "content": {
        "orders": [
          {
            "orderid": 1013,
            "date": "Today",
            "total": 10.74,
            "status": "invoiced"
          }
        ],
      }
    });
    //@todo
  }

  Future<String> requestOrderDetails(String email, int o_id) async {
    return json.encode({
      "type": 6,
      "code": 2,
      "content": {
        "success": true,
        "orderid": 1013,
        "email": email,
        "address": "Av",
        "payment": "14574",
        "date": "Yesterday",
        "total": 10.32,
        "status": "delivered"
      }
    });
    //@todo
  }

  Future<String> cancelOrder(String email, int o_id) async {
    return json.encode({
      "type": 6,
      "code": 3,
      "content": {
        "success": true,
      }
    });
    //@todo
  }

  // 7.ORDERSADMIN

  Future<String> listAllOrders(String email) async {
    return json.encode({
      "type": 7,
      "code": 1,
      "content": {
        "amount": 1,
        "orders": [
          {
            "orderid": 1013,
            "email": email,
            "address": "Av",
            "payment": "14574",
            "date": "Yesterday",
            "total": 10.32,
            "status": "delivered"
          }
        ]
      }
    });
    //@todo
  }

  Future<String> changeOrderStatus(String email, int p_id, int status) async {
    return json.encode({
      "type": 7,
      "code": 2,
      "content": {
        "success": true,
      }
    });
    //@todo
  }

  // 8.RECOMENDATIONS AND PRODUCT RATING

  Future<String> rateProduct(
      String email, int p_id, double rating, String comment) async {
    /*return json.encode({
      "type": 8,
      "code": 1,
      "content": {
        "success": true,
      }
    });*/
    //@todo
    await query({
      "type": 8,
      "code": 1,
      "content": {
        "email": email,
        "productid": p_id,
        "rating": rating,
        "comment": comment
      }
    });
    return getData();
  }

  Future<String> viewProductRating(int p_id) async {
    /*await Future.delayed(const Duration(seconds: 1));
    return json.encode({
      "type": 8,
      "code": 2,
      "content": {
        "amount": 1,
        "ratings": [
          {
            "email": "Pablo@gmail.com",
            "rating": 4.5,
            "comment": "Buen producto",
            "date": "ayer"
          },
          {
            "email": "Joan@gmail.com",
            "rating": 3.5,
            "comment": "Mal producto",
            "date": "ayer"
          }
        ]
      }
    });*/
    //@todo
    await query({
      "type": 8,
      "code": 2,
      "content": {"productid": p_id}
    });
    return getData();
  }

  Future<String> requestRecommendedProducts(String email) async {
    /*await Future.delayed(const Duration(seconds: 1));
    return json.encode({
      "type": 8,
      "code": 3,
      "content": {
        "amount": 3,
        "products": [
          {
            "id": 1,
            "name": "iPhone 14",
            "description": "Movil que funciona de maravilla pero radioactivo",
            "image": "/imagenes/iPhone12",
            "price": 799.99,
            "rating": 5,
            "count": 10,
            "tags": "tecnologia"
          },
          {
            "id": 2,
            "name": "Air Jordan Magic",
            "description": "Zapatillas para saltar mucho",
            "image": "/imagenes/Jordan",
            "price": 180,
            "rating": 4.5,
            "count": 12,
            "tags": "ropa"
          },
          {
            "id": 3,
            "name": "Sudadera",
            "description": "Abriga mucho",
            "image": "/imagenes/sudadera",
            "price": 180,
            "rating": 4.5,
            "count": 12,
            "tags": "ropa"
          }
        ]
      }
    });*/
    //@todo
    await query({
      "type": 8,
      "code": 3,
      "content": {"email": email}
    });
    return getData();
  }

  Future<String> requestRecommendedProductsByTags(
      String email, Tags tags) async {
    /*await Future.delayed(const Duration(seconds: 1));
    return json.encode({
      "type": 8,
      "code": 3,
      "content": {
        "amount": 2,
        "products": [
          {
            "id": 1,
            "name": "iPhone 14",
            "description": "Movil que funciona de maravilla pero radioactivo",
            "image": "/imagenes/iPhone12",
            "price": 799.99,
            "rating": 5,
            "count": 10,
            "tags": "tecnologia"
          },
          {
            "id": 2,
            "name": "Air Jordan Magic",
            "description": "Zapatillas para saltar mucho",
            "image": "/imagenes/Jordan",
            "price": 180,
            "rating": 4.5,
            "count": 12,
            "tags": "ropa"
          }
        ]
      }
    });*/
    //@todo
    await query({
      "type": 8,
      "code": 4,
      "content": {"email": email, "tags": tags.onlyTrues()}
    });
    return getData();
  }
}
