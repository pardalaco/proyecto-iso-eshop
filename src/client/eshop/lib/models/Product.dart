// ignore_for_file: file_names

class Products {
  late List<Product> products;
  late int amount;

  Products({required this.products});

  Products.fromJson(Map<String, dynamic> json, bool inCart) {
    products = <Product>[];
    amount = json['amount'];
    var a = json['products'];
    a.forEach((v) {
      products.add(Product.fromJson(v, inCart));
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
