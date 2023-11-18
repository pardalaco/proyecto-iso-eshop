// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_const_constructors, no_leading_underscores_for_local_identifiers, no_logic_in_create_state, must_be_immutable, unused_element

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:eshop/sockets/connection.dart';
import 'package:eshop/models/Product.dart';
import 'package:eshop/style/ColorsUsed.dart';

class Home extends StatefulWidget {
  Connection connection;
  bool admin;
  Home({Key? key, required this.connection, required this.admin})
      : super(key: key);

  @override
  State<Home> createState() => _MyPage(connection: connection, admin: admin);
}

class _MyPage extends State<Home> {
  Connection connection;
  bool admin;
  _MyPage({required this.connection, required this.admin});

  @override
  Widget build(BuildContext context) {
    final _MyAppBar = AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        backgroundColor: CustomColors.n1,
        centerTitle: true,
        title: Text(
          "Home",
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.height * 0.05,
          ),
        ));
    return Scaffold(
      appBar: _MyAppBar,
      body: _MyHomeBody(connection: connection, admin: admin),
    );
  }
}

class _MyHomeBody extends StatefulWidget {
  Connection connection;
  bool admin;
  _MyHomeBody({Key? key, required this.connection, required this.admin});

  @override
  State<_MyHomeBody> createState() =>
      _HomeBody(connection: connection, admin: admin);
}

class _HomeBody extends State<_MyHomeBody> {
  Connection connection;
  bool admin;
  _HomeBody({required this.connection, required this.admin});
  //TextEditingController controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  /*@override
  void dispose() {
    //controller.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsetsDirectional.symmetric(
          horizontal: size.width * 0.05, vertical: size.height * 0.03),
      color: CustomColors.background,
      child: Column(
        children: [
          TextField(
            //controller: controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 3, color: CustomColors.n1),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 3, color: CustomColors.n1),
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: "Busca en la tienda",
                filled: true,
                fillColor: CustomColors.n2,
                prefixIcon: Icon(
                  Icons.search,
                  color: _focusNode.hasFocus ? Colors.grey : Colors.white,
                )),
            onSubmitted: (value) => {
              setState(() {
                String textoIngresado = value;
                print('Texto ingresado: $textoIngresado');
              })
            },
          ),
          SizedBox(height: 20),
          /*ElevatedButton(
            onPressed: () {
              // Recoger el texto del TextField
              String textoIngresado = controller.text;
              print('Texto ingresado: $textoIngresado');
            },
            child: Text('Recoger Texto'),
          ),*/
        ],
      ),
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
