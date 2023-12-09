import 'package:flutter/material.dart';
import 'package:eshop/future/drawer.dart';
import 'package:eshop/models/user_model.dart';

import 'package:eshop/future/futureProducts.dart';

// Conexion
import 'package:eshop/sockets/connection.dart';

class ProductsPage extends StatefulWidget {
  Connection connection;

  ProductsPage({super.key, required this.connection
      // required this.productsJson
      });

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
        user: User(name: "name", email: "phone"),
      ),
      body: FutureJson(
        connection: widget.connection,
      ),
      // body: ListView.builder(
      //   itemCount: widget.productsJson.length,
      //   itemBuilder: (context, i) => widget.productsJson[i],
      // ),
    );
  }
}
