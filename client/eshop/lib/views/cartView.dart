// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_const_constructors, no_leading_underscores_for_local_identifiers, no_logic_in_create_state, must_be_immutable, unused_element, sized_box_for_whitespace, use_build_context_synchronously, camel_case_types
import 'package:eshop/models/Cart.dart';
import 'package:eshop/models/Product.dart';
import 'package:eshop/models/Response.dart';
import 'package:flutter/material.dart';
import 'package:eshop/sockets/connection.dart';
import 'package:eshop/models/Profile.dart';
import 'package:eshop/style/ColorsUsed.dart';
import 'dart:developer' as dev;

class cartView extends StatefulWidget {
  final Cart cart;
  final Profile profile;
  final Connection connection;
  final VoidCallback reloadCartList;

  const cartView(
      {super.key,
      required this.profile,
      required this.cart,
      required this.connection,
      required this.reloadCartList});

  @override
  State<cartView> createState() => _cartViewState();
}

class _cartViewState extends State<cartView> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: CustomColors.background,
        appBar: AppBar(
          toolbarHeight: constraints.maxHeight * 0.1,
          backgroundColor: CustomColors.n1,
          centerTitle: true,
          title: Text(
            widget.cart.cartname,
            style: TextStyle(
              color: Colors.white,
              fontSize: constraints.maxHeight * 0.05,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                dev.log("Editar nombre o eliminar carrito");
              },
            ),
            SizedBox(width: constraints.maxWidth * 0.1),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            if (widget.cart.listProducts.amount == 0) ...[
              Center(
                child: const Text(
                  "There aren't any product",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              )
            ] else ...[
              SizedBox(
                height: constraints.maxHeight * 0.5,
                width: double.infinity,
                child: ListView.separated(
                  itemCount: widget.cart.listProducts.amount,
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        widget.cart.listProducts.products[index].name,
                        style: const TextStyle(fontSize: 25),
                      ),
                      textColor: Colors.white,
                      subtitle: Text(
                        widget.cart.listProducts.products[index].price
                                .toStringAsFixed(2) +
                            " €",
                        style: const TextStyle(fontSize: 20),
                      ),
                      trailing: FittedBox(
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  dev.log(
                                      "Eliminar un item de ${widget.cart.listProducts.products[index].name}");
                                  widget.cart.listProducts.products[index]
                                      .quantity -= 1;
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                )),
                            Text(
                              widget.cart.listProducts.products[index].quantity
                                  .toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                            IconButton(
                                onPressed: () async {
                                  dev.log(
                                      "Añadir un item de ${widget.cart.listProducts.products[index].name}");
                                  widget.cart.listProducts.products[index]
                                      .quantity += 1;
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                            SizedBox(
                              width: constraints.maxWidth * 0.1,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                            title: Text(
                                              "Message",
                                              textAlign: TextAlign.center,
                                            ),
                                            content: Text("Are you sure?",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                                textAlign: TextAlign.center),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    "NO",
                                                    style: TextStyle(
                                                        color: CustomColors.n1,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  )),
                                              TextButton(
                                                  onPressed: () async {
                                                    dev.log(
                                                        "Eliminar producto");
                                                    var data = await widget
                                                        .connection
                                                        .removeProductFromCart(
                                                            widget
                                                                .profile.email,
                                                            widget.cart.cartid,
                                                            widget
                                                                .cart
                                                                .listProducts
                                                                .products[index]
                                                                .id);
                                                    Response response =
                                                        Response.fromJson(data);
                                                    if (response.error ||
                                                        !response.content[
                                                            "success"]) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: SizedBox(
                                                            height: constraints
                                                                    .maxHeight *
                                                                0.05,
                                                            child: const Text(
                                                              'ERROR REMOVING PRODUCT',
                                                              style: TextStyle(
                                                                  fontSize: 25),
                                                            ),
                                                          ),
                                                          backgroundColor:
                                                              CustomColors.n1,
                                                        ),
                                                      );
                                                    }
                                                    Navigator.of(context).pop();
                                                    setState(() {});
                                                  },
                                                  child: const Text(
                                                    "YES",
                                                    style: TextStyle(
                                                        color: CustomColors.n1,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  )),
                                            ]));
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          CustomColors.n1)),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: constraints.maxHeight * 0.04,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ]
          ],
        ),
      );
    });
  }
}
