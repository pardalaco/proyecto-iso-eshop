import 'package:eshop/jsons/requestProductsJson%20copy.dart';
import 'package:flutter/material.dart';
import 'package:eshop/future/drawer.dart';
import 'package:eshop/models/user_model.dart';

import 'package:eshop/future/futureProducts.dart';

// Conexion
import 'package:eshop/sockets/connection.dart';

// Json
import 'package:eshop/jsons/requestProductsJson.dart';

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
      body: Text(_data().toString()),
      // body: ListView.builder(
      //   itemCount: widget.productsJson.length,
      //   itemBuilder: (context, i) => widget.productsJson[i],
      // ),
    );
  }

  Future<String> _data() async {
    RequestProductsSend data =
        RequestProductsSend(type: 1, code: 1, content: 1);

    //print(data.toJson().toString());

    await widget.connection.query(data.toJson());
    print("---> ENVIADO: " + data.toString());

    // Recipt data from the server
    var dataRecipt = widget.connection.getData();
    print("<--- RECIBIDO: " + dataRecipt.toString());

    RequestProductsRecipt dataReturn =
        RequestProductsRecipt.fromJson(dataRecipt);

    // Create a List with the boolean and the string

    return dataReturn.content;
  }
}
