import 'package:flutter/material.dart';
import 'package:eshop/future/drawer.dart';
import 'package:eshop/models/user_model.dart';

class ProductsPage extends StatefulWidget {
  final List productsJson;
  const ProductsPage({super.key, required this.productsJson});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const FutureReservas()),
              // );
            },
          ),
        ],
      ),
      drawer: DrawerWidget(
        user: User(name: "name", phone: "phone"),
      ),
      body: ListView.builder(
        itemCount: widget.productsJson.length,
        itemBuilder: (context, i) => widget.productsJson[i],
      ),
    );
  }
}
