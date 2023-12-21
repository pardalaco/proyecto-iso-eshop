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
    await query({
      "type": 1,
      "code": 1,
      "content": {"email": email, "password": password}
    });
    return getData();
  }

  Future<String> signUp(String email, String password) async {
    await query({
      "type": 1,
      "code": 2,
      "content": {"email": email, "password": password}
    });
    return getData();
  }

  Future<String> isAdmin(String email) async {
    await query({
      "type": 1,
      "code": 3,
      "content": {"email": email}
    });
    return getData();
  }

  // 2.REQUEST PRODUCTS

  Future<String> getAllProducts() async {
    await query({"type": 2, "code": 1, "content": {}});
    return getData();
  }

  Future<String> getProductByID(String email, int p_id) async {
    await query({
      "type": 2,
      "code": 2,
      "content": {"email": email, "id": p_id}
    });
    return getData();
  }

  Future<String> getProductByTags(String email, Tags tags) async {
    await query({
      "type": 2,
      "code": 3,
      "content": {"email": email, "password": tags.onlyTrues()}
    });
    return getData();
  }

  Future<String> getTags() async {
    await query({"type": 2, "code": 4, "content": {}});
    return getData();
  }

  // 3.MANAGE PRODUCT ADMIN

  Future<String> addNewProduct(Product product, String email) async {
    await query({
      "type": 3,
      "code": 1,
      "content": {
        "email": email,
        "name": product.name,
        "description": product.description,
        "image": product.image,
        "price": product.price,
        "tags": product.tags.onlyTrues(),
      }
    });
    return getData();
  }

  Future<String> editProduct(Map<String, dynamic> content) async {
    await query({"type": 3, "code": 2, "content": content});
    return getData();
  }

  Future<String> removeProduct(String email, int p_id) async {
    await query({
      "type": 3,
      "code": 3,
      "content": {
        "email": email,
        "productid": p_id,
      }
    });
    return getData();
  }

  Future<String> addNewTag(String email, String tag) async {
    await query({
      "type": 3,
      "code": 4,
      "content": {
        "email": email,
        "tag": tag,
      }
    });
    return getData();
  }

  // 4.RELATED TO CART

  Future<String> createCart(String email, String cartname) async {
    await query({
      "type": 4,
      "code": 1,
      "content": {"email": email, "cartname": cartname}
    });
    return getData();
  }

  Future<String> editCart(String email, int c_id, String newName) async {
    await query({
      "type": 4,
      "code": 2,
      "content": {"email": email, "cartid": c_id, "newname": newName}
    });
    return getData();
  }

  Future<String> deleteCart(String email, int c_id) async {
    await query({
      "type": 4,
      "code": 3,
      "content": {
        "email": email,
        "cartid": c_id,
      }
    });
    return getData();
  }

  Future<String> addToCart(String email, int c_id, int p_id) async {
    await query({
      "type": 4,
      "code": 4,
      "content": {"email": email, "cartid": c_id, "productid": p_id}
    });
    return getData();
  }

  Future<String> editQuantity(String email, int c_id, int p_id, int q) async {
    await query({
      "type": 4,
      "code": 5,
      "content": {
        "email": email,
        "cartid": c_id,
        "productid": p_id,
        "quantity": q,
      }
    });
    return getData();
  }

  Future<String> removeProductFromCart(String email, int c_id, int p_id) async {
    await query({
      "type": 4,
      "code": 6,
      "content": {
        "email": email,
        "cartid": c_id,
        "productid": p_id,
      }
    });
    return getData();
  }

  Future<String> requestCartProducts(String email, int c_id) async {
    await query({
      "type": 4,
      "code": 7,
      "content": {
        "email": email,
        "cartid": c_id,
      }
    });
    return getData();
  }

  Future<String> getAllCarts(String email) async {
    await query({
      "type": 4,
      "code": 8,
      "content": {"email": email}
    });
    return getData();
  }

  Future<String> purchase(String email, int c_id) async {
    await query({
      "type": 4,
      "code": 9,
      "content": {
        "email": email,
        "cartid": c_id,
      }
    });
    return getData();
  }

  // 5.USER INFO

  Future<String> editName(String email, String name) async {
    await query({
      "type": 5,
      "code": 1,
      "content": {
        "email": email,
        "name": name,
      }
    });
    return getData();
  }

  Future<String> editEmail(String email, String newEmail) async {
    await query({
      "type": 5,
      "code": 2,
      "content": {
        "email": email,
        "newemail": newEmail,
      }
    });
    return getData();
  }

  Future<String> editPassword(String email, String password) async {
    await query({
      "type": 5,
      "code": 3,
      "content": {
        "email": email,
        "password": password,
      }
    });
    return getData();
  }

  Future<String> editPayment(String email, String payment) async {
    await query({
      "type": 5,
      "code": 4,
      "content": {
        "email": email,
        "payment": payment,
      }
    });
    return getData();
  }

  Future<String> editAddress(String email, String address) async {
    await query({
      "type": 5,
      "code": 5,
      "content": {
        "email": email,
        "address": address,
      }
    });
    return getData();
  }

  Future<String> requestUserInfo(String email) async {
    await query({
      "type": 5,
      "code": 6,
      "content": {"email": email}
    });
    return getData();
  }

  // 6.ORDERS

  Future<String> requestOrders(String email) async {
    await query({
      "type": 6,
      "code": 1,
      "content": {
        "email": email,
      }
    });
    return getData();
  }

  Future<String> requestOrderDetails(String email, int o_id) async {
    await query({
      "type": 6,
      "code": 2,
      "content": {
        "email": email,
        "orderid": o_id,
      }
    });
    return getData();
  }

  Future<String> cancelOrder(String email, int o_id) async {
    await query({
      "type": 6,
      "code": 3,
      "content": {
        "email": email,
        "orderid": o_id,
      }
    });
    return getData();
  }

  // 7.ORDERS ADMIN

  Future<String> listAllOrders(String email) async {
    await query({
      "type": 7,
      "code": 1,
      "content": {
        "email": email,
      }
    });
    return getData();
  }

  Future<String> changeOrderStatus(String email, int o_id, int status) async {
    await query({
      "type": 7,
      "code": 2,
      "content": {
        "email": email,
        "orderid": o_id,
        "status": status,
      }
    });
    return getData();
  }

  // 8.RECOMENDATIONS AND PRODUCT RATING

  Future<String> rateProduct(
      String email, int p_id, double rating, String comment) async {
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
    await query({
      "type": 8,
      "code": 2,
      "content": {"productid": p_id}
    });
    return getData();
  }

  Future<String> requestRecommendedProducts(String email) async {
    await query({
      "type": 8,
      "code": 3,
      "content": {"email": email}
    });
    return getData();
  }

  Future<String> requestRecommendedProductsByTags(
      String email, Tags tags) async {
    await query({
      "type": 8,
      "code": 4,
      "content": {"email": email, "tags": tags.onlyTrues()}
    });
    return getData();
  }

  Future<String> requestUserMarketingProfile(String email) async {
    await query({
      "type": 8,
      "code": 5,
      "content": {
        "email": email,
      }
    });
    return getData();
  }

  // 9. Optimized and Additional Funcitonality

  Future<String> changeProductSetTags(
      String email, int p_id, String tags) async {
    var tagList = tags.isEmpty ? [] : tags.split(",");
    await query({
      "type": 9,
      "code": 1,
      "content": {
        "email": email,
        "productid": p_id,
        "tags": tagList,
      }
    });
    return getData();
  }

  Future<String> dynamicUserInfoEdit(
      String email, Map<String, dynamic> content) async {
    await query({
      "type": 9,
      "code": 2,
      "content": content,
    });
    return getData();
  }
}
