// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_const_constructors, no_leading_underscores_for_local_identifiers, no_logic_in_create_state, must_be_immutable, unused_element

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:eshop/sockets/connection.dart';
import 'package:eshop/models/Product.dart';

class Home extends StatefulWidget {
  Connection connection;
  Home({Key? key, required this.connection}) : super(key: key);

  @override
  State<Home> createState() => _MyPage(connection: connection);
}

class _MyPage extends State<Home> {
  Connection connection;
  _MyPage({required this.connection});

  @override
  Widget build(BuildContext context) {
    final _MyAppBar = AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        backgroundColor: Colors.amber,
        title: Text(
          "Home",
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.height * 0.05,
          ),
        ));
    return Scaffold(
      appBar: _MyAppBar,
      body: FuturaLista(context, connection),
    );
  }
}

Future<String> _getJson(Connection con) async {
  await con.query({"type": 2, "code": 1, "content": {}});
  return json.encode(con.getData());
}

Widget FuturaLista(BuildContext context, Connection connection) {
  return FutureBuilder(
    future: _getJson(connection),
    builder: (context, AsyncSnapshot<String> snapshot) {
      if (snapshot.hasData) {
        Map<String, dynamic> data = json.decode(snapshot.data!);
        var products = Products.fromJson(data);
        final productList = products.products.map((product) {
          return ListTile(
            title: Text(product.name),
            subtitle: Text(product.price.toString()),
            trailing: const Icon(Icons.arrow_forward_ios),
          );
        }).toList();
        return ListView.separated(
          padding: const EdgeInsets.all(10.0),
          itemBuilder: (context, index) => productList[index],
          separatorBuilder: (context, index) => const Divider(
            thickness: 1,
          ),
          itemCount: productList.length,
        );
      }
      return const Center(
          child: SizedBox(
        height: 150.0,
        width: 150.0,
        child: CircularProgressIndicator(
            strokeWidth: 10.0,
            valueColor: AlwaysStoppedAnimation(Colors.purple)),
      ));
    },
  );
}
