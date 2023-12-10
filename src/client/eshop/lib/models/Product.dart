// ignore_for_file: file_names

class Products {
  late List<Product> products;
  late int amount;

  Products({required this.products});

  Products.fromJson(
    Map<String, dynamic> json,
  ) {
    products = <Product>[];
    amount = json['content']['amount'];
    var a = json['content']['products'];
    a.forEach((v) {
      products.add(Product.fromJson(v, false));
    });
  }
  Products.fromJsonInCart(Map<String, dynamic> json) {
    products = <Product>[];
    amount = json['amount'];
    var a = json['products'];
    a.forEach((v) {
      products.add(Product.fromJson(v, true));
    });
  }
}

class Product {
  late int id;
  late String name;
  late String description;
  late double price;
  late double rating;
  late int count;
  late String tags;
  late int quantity; //In cart

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.tags});

  Product.fromJson(Map<String, dynamic> json, bool inCart) {
    id = json['id'];
    name = json['name'];
    price = json['price'].toDouble();
    description = json['description'];
    tags = json['tags'];

    if (inCart) {
      quantity = json['quantity'];
    } else {
      rating = json['rating'].toDouble();
      count = json['count'];
    }
  }
}
