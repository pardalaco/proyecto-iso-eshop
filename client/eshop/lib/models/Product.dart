// ignore_for_file: file_names

import 'package:eshop/models/Tag.dart';

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
  late String image;
  late double price;
  late double rating;
  late int count;
  late Tags tags;
  late int quantity; //In cart

  Product(
      {required this.name,
      required this.description,
      required this.image,
      required this.price,
      required this.tags});

  Product.fromJson(Map<String, dynamic> json, bool inCart) {
    tags = Tags.fromJson(json, true);
    if (inCart) {
      id = json['product_id'];
      name = json['product_name'];
      price = json['product_price'].toDouble();
      description = json['product_description'];
      image = json['product_image'];
      quantity = json['quantity'];
    } else {
      id = json['id'];
      name = json['name'];
      price = json['price'].toDouble();
      description = json['description'];
      image = json['image'];
      rating = json['rating'].toDouble();
      count = json['count'];
    }
  }
}
