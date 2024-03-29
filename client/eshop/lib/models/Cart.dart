// ignore_for_file: file_names

import 'package:eshop/models/Product.dart';

class Carts {
  late List<Cart> carts;

  Carts.fromJson(Map<String, dynamic> json) {
    carts = <Cart>[];
    var a = json['carts'];
    a.forEach((v) {
      carts.add(Cart.fromJson(v, false));
    });
  }
}

class Cart {
  late int cartid;
  late String cartname;
  late double total;
  late Products listProducts;

  Cart.fromJson(Map<String, dynamic> json, bool loadList) {
    total = json['total'].toDouble();
    if (loadList) {
      listProducts = Products.fromJson(json, true);
    } else {
      cartid = json['cartid'];
      cartname = json['cartname'];
    }
  }
}
