class OrderListProducts {
  late bool success;
  late int amount;
  late double total;
  late List<Product> products;

  OrderListProducts.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (success) {
      amount = json['amount'];
      total = json['total'].toDouble();

      var productList = json['products'] as List;
      products = productList
          .map((productData) => Product.fromJson(productData))
          .toList();
    }
  }
}

class Product {
  late int id;
  late String name;
  late String description;
  late String image;
  late double price;
  late List<String> tags;
  late int quantity;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    price = json['price'].toDouble();
    tags = (json['tags'] as String).split(',');
    quantity = json['quantity'];
  }
}
