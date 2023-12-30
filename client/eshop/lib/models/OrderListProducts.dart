class OrderListProducts {
  late bool success;
  late int amount;
  late List<Product> products;

  OrderListProducts.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (success == true) {
      amount = json['amount'];

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
    id = json['product_id'];
    name = json['product_name'];
    description = json['product_description'];
    image = json['product_image'];
    price = json['product_price'].toDouble();
    tags = (json['tags'] as String).split(',');
    quantity = json['quantity'];
  }
}
