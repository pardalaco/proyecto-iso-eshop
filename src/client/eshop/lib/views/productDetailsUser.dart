// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, must_be_immutable, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:eshop/models/Product.dart';
import 'package:eshop/style/ColorsUsed.dart';

class DetailPage extends StatelessWidget {
  Product producto;
  DetailPage({Key? key, required this.producto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _MyAppBar = AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        backgroundColor: CustomColors.n1,
        centerTitle: true,
        title: Text(
          "Product details",
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.height * 0.05,
          ),
        ));

    return Scaffold(
        appBar: _MyAppBar,
        body: Container(
          color: CustomColors.background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              myImage(context, producto),
              myDescription(context, producto),
            ],
          ),
        ));
  }
}

Widget myImage(context, Product producto) {
  final Size size = MediaQuery.of(context).size;
  final double altura = size.height;
  return Container(
      margin: EdgeInsetsDirectional.symmetric(vertical: altura * 0.05),
      padding: EdgeInsetsDirectional.symmetric(
          horizontal: size.width * 0.025, vertical: altura * 0.05),
      height: altura * 0.35,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 80, 79, 79),
            blurRadius: 10.0,
            spreadRadius: 1,
            offset: Offset(0.0, 0.0),
          )
        ],
      ),
      child: Hero(
        tag: producto.name,
        child: Image(
          image: const AssetImage("assets/img/User.jpg"),
          width: size.width * 0.15,
          height: altura * 0.2,
        ),
      ));
}

Widget myDescription(context, Product producto) {
  final Size size = MediaQuery.of(context).size;
  final double altura = size.height;
  return Expanded(
      child: Container(
          width: double.infinity,
          padding: EdgeInsetsDirectional.symmetric(
              horizontal: size.width * 0.05, vertical: altura * 0.05),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 80, 79, 79),
                blurRadius: 8.0,
                spreadRadius: 0.5,
                offset: Offset(0.0, 0.0),
              )
            ],
          ),
          child: SizedBox(
            height: altura * 0.5,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      producto.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                      ),
                    ),
                    SizedBox(
                      height: altura * 0.025,
                    ),
                    Text(
                      "${producto.price} €",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: altura * 0.025,
                    ),
                    Text(
                      producto.description,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: altura * 0.025,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => _MyAlert(context));
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              CustomColors.n1)),
                      child: Icon(
                        Icons.add_shopping_cart,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.height * 0.04,
                      ),
                    )
                  ]),
            ),
          )));
}

Widget _MyAlert(context) => AlertDialog(
    title: const Text(
      "Select a cart",
      textAlign: TextAlign.center,
    ),
    content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.15,
        height: MediaQuery.of(context).size.height * 0.25,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              child: _ListCart(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => _MyAlertAddCart(context));
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(CustomColors.n1)),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: MediaQuery.of(context).size.height * 0.04,
              ),
            ),
          ],
        )));

class _ListCart extends StatefulWidget {
  //const _ListCart({super.key});

  @override
  State<_ListCart> createState() => _ListCartState();
}

//@todo Un metodo para generar una lista de carritos
List<String> items = ["Carrito 1", "Carrito 2"];

class _ListCartState extends State<_ListCart> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index]),
          onTap: () {
            //@todo Llamar al server para añadir al carrito
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Add to ${items[index]}'),
                backgroundColor: CustomColors.n1,
              ),
            );
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}

Widget _MyAlertAddCart(context) {
  TextEditingController _controller = TextEditingController();
  return AlertDialog(
      title: const Text(
        "Create a cart",
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.15,
          height: MediaQuery.of(context).size.height * 0.07,
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'New cart name',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: CustomColors.n1),
              ),
            ),
            cursorColor: CustomColors.n1,
          )),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Cancel",
              style: TextStyle(
                  color: CustomColors.n1,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            )),
        TextButton(
            onPressed: () {
              if (_controller.text.isEmpty) {
                Navigator.of(context).pop();
              } else {
                items.add(_controller.text);
                //@todo crear carrito en servidor
                Navigator.of(context).pop();
              }
            },
            child: const Text(
              "Create",
              style: TextStyle(
                  color: CustomColors.n1,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            )),
      ]);
}
