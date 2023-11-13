// ignore_for_file: file_names

class Products {
  late List<Product> products;

  Products({required this.products});

  Products.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      products = <Product>[];
      var a = json['content'];
      a['products'].forEach((v) {
        products.add(Product.fromJson(v));
      });
    }
  }
}

class Product {
  late String name;
  late String description;
  late double price;
  late String tags;

  Product(
      {required this.name,
      required this.description,
      required this.price,
      required this.tags});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['product_name'];
    price = json['product_price'].toDouble();
    description = json['product_description'];
    tags = json['tags'];
  }
}
