class Products {
  late List<Product> products;

  Products({required this.products});

  Products.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products.add(Product.fromJson(v));
      });
    }
  }
}

class Product {
  late String name;
  late String location;
  late double price;
  late String image;
  late String description;
  late int stars;

  Product(
      {required this.name,
      required this.location,
      required this.price,
      required this.image,
      required this.description,
      required this.stars});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    location = json['location'];
    price = json['price'];
    image = json['image'];
    description = json['description'];
    stars = json['stars'];
  }
}
