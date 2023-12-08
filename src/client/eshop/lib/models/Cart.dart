// ignore_for_file: file_names

class Carts {
  late List<Cart> carts;

  Carts.fromJson(Map<String, dynamic> json) {
    carts = <Cart>[];
    var a = json['carts'];
    a.forEach((v) {
      carts.add(Cart.fromJson(v));
    });
  }
}

class Cart {
  late int cartid;
  late String cartname;
  late double total;

  Cart.fromJson(Map<String, dynamic> json) {
    cartid = json['cartid'];
    cartname = json['cartname'];
    total = json['total'].toDouble();
  }
}
