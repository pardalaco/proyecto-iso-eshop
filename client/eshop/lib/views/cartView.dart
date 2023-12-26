// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_const_constructors, no_leading_underscores_for_local_identifiers, no_logic_in_create_state, must_be_immutable, unused_element, sized_box_for_whitespace, use_build_context_synchronously, camel_case_types
import 'package:eshop/models/Cart.dart';
import 'package:eshop/models/Response.dart';
import 'package:eshop/utils/MyWidgets.dart';
import 'package:eshop/views/makeOrder.dart';
import 'package:flutter/material.dart';
import 'package:eshop/sockets/connection.dart';
import 'package:eshop/models/Profile.dart';
import 'package:eshop/style/ColorsUsed.dart';
import 'dart:developer' as dev;

/////////////////////////////////
TextEditingController _controller = TextEditingController();
////////////////////////////////

class cartView extends StatefulWidget {
  final Cart cart;
  final Profile profile;
  final Connection connection;
  final VoidCallback reloadCartList;
  final VoidCallback updateHome;

  const cartView(
      {super.key,
      required this.profile,
      required this.cart,
      required this.connection,
      required this.reloadCartList,
      required this.updateHome});

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
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                        title: Text(
                          "Settings",
                          textAlign: TextAlign.center,
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: const Text("Remove cart",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                  textAlign: TextAlign.center),
                              onTap: () async {
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
                                                    dev.log("Eliminar carrito");
                                                    var data = await widget
                                                        .connection
                                                        .deleteCart(
                                                            widget
                                                                .profile.email,
                                                            widget.cart.cartid);
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
                                                              'ERROR REMOVING CART',
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
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                    widget.reloadCartList();
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
                            ),
                            ListTile(
                              title: const Text("Rename cart",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                  textAlign: TextAlign.center),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                            title: const Text(
                                              "Rename a cart",
                                              textAlign: TextAlign.center,
                                            ),
                                            content: SizedBox(
                                                width:
                                                    constraints.maxWidth * 0.15,
                                                height: constraints.maxHeight *
                                                    0.07,
                                                child: TextField(
                                                  controller: _controller,
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: 'New cart name',
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              CustomColors.n1),
                                                    ),
                                                  ),
                                                  cursorColor: CustomColors.n1,
                                                )),
                                            actions: [
                                              TextButton(
                                                  onPressed: () async {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        color: CustomColors.n1,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  )),
                                              TextButton(
                                                  onPressed: () async {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    if (_controller
                                                        .text.isNotEmpty) {
                                                      var data = await widget
                                                          .connection
                                                          .editCart(
                                                              widget.profile
                                                                  .email,
                                                              widget
                                                                  .cart.cartid,
                                                              _controller.text);
                                                      Response response =
                                                          Response.fromJson(
                                                              data);
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
                                                                'ERROR RENAMING CART',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        25),
                                                              ),
                                                            ),
                                                            backgroundColor:
                                                                CustomColors.n1,
                                                          ),
                                                        );
                                                      }
                                                      widget.cart.cartname =
                                                          _controller.text;
                                                      _controller.clear();
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pop();
                                                      widget.reloadCartList();
                                                      setState(() {});
                                                    }
                                                  },
                                                  child: const Text(
                                                    "Create",
                                                    style: TextStyle(
                                                        color: CustomColors.n1,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  )),
                                            ]));
                              },
                            ),
                          ],
                        )));
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
                  itemCount: widget.cart.listProducts.products.length,
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        widget.cart.listProducts.products[index].name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      textColor: Colors.white,
                      subtitle: Text(
                        widget.cart.listProducts.products[index].price
                                .toStringAsFixed(2) +
                            " €",
                        style: const TextStyle(fontSize: 15),
                      ),
                      trailing: FittedBox(
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  dev.log(
                                      "Eliminar un item de ${widget.cart.listProducts.products[index].name}");
                                  if (widget.cart.listProducts.products[index]
                                          .quantity !=
                                      0) {
                                    int q = widget.cart.listProducts
                                            .products[index].quantity -
                                        1;
                                    if (q == 0) {
                                      var data = await widget.connection
                                          .removeProductFromCart(
                                              widget.profile.email,
                                              widget.cart.cartid,
                                              widget.cart.listProducts
                                                  .products[index].id);
                                      Response response =
                                          Response.fromJson(data);
                                      if (response.error ||
                                          !response.content["success"]) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: SizedBox(
                                              height:
                                                  constraints.maxHeight * 0.05,
                                              child: const Text(
                                                'ERROR REMOVING PRODUCT',
                                                style: TextStyle(fontSize: 25),
                                              ),
                                            ),
                                            backgroundColor: CustomColors.n1,
                                          ),
                                        );
                                      } else {
                                        widget.cart.total -= widget.cart
                                            .listProducts.products[index].price;
                                        widget.cart.listProducts.products
                                            .removeAt(index);
                                        widget.reloadCartList();
                                      }
                                    } else {
                                      var data = await widget.connection
                                          .editQuantity(
                                              widget.profile.email,
                                              widget.cart.cartid,
                                              widget.cart.listProducts
                                                  .products[index].id,
                                              q);
                                      Response response =
                                          Response.fromJson(data);
                                      if (response.error ||
                                          !response.content["success"]) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: SizedBox(
                                              height:
                                                  constraints.maxHeight * 0.05,
                                              child: const Text(
                                                'ERROR EDITING QUANTITY',
                                                style: TextStyle(fontSize: 25),
                                              ),
                                            ),
                                            backgroundColor: CustomColors.n1,
                                          ),
                                        );
                                      } else {
                                        widget.cart.listProducts.products[index]
                                            .quantity -= 1;
                                        widget.cart.total -= widget.cart
                                            .listProducts.products[index].price;
                                        widget.reloadCartList();
                                      }
                                    }
                                    setState(() {});
                                  }
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 15,
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
                                  int q = widget.cart.listProducts
                                          .products[index].quantity +
                                      1;
                                  var data = await widget.connection
                                      .editQuantity(
                                          widget.profile.email,
                                          widget.cart.cartid,
                                          widget.cart.listProducts
                                              .products[index].id,
                                          q);
                                  Response response = Response.fromJson(data);
                                  if (response.error ||
                                      !response.content["success"]) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: SizedBox(
                                          height: constraints.maxHeight * 0.05,
                                          child: const Text(
                                            'ERROR EDITING QUANTITY',
                                            style: TextStyle(fontSize: 25),
                                          ),
                                        ),
                                        backgroundColor: CustomColors.n1,
                                      ),
                                    );
                                  } else {
                                    widget.cart.listProducts.products[index]
                                        .quantity += 1;
                                    widget.cart.total += widget.cart
                                        .listProducts.products[index].price;
                                    widget.reloadCartList();
                                  }
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 15,
                                )),
                            SizedBox(
                              width: constraints.maxWidth * 0.02,
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
                                                    } else {
                                                      widget
                                                          .cart.total -= (widget
                                                              .cart
                                                              .listProducts
                                                              .products[index]
                                                              .quantity *
                                                          widget
                                                              .cart
                                                              .listProducts
                                                              .products[index]
                                                              .price);
                                                      widget.cart.listProducts
                                                          .products
                                                          .removeAt(index);
                                                      widget.reloadCartList();
                                                      setState(() {});
                                                    }
                                                    Navigator.of(context).pop();
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
              ),
              const Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        dev.log(("Ir a pagar"));
                        if (widget.cart.listProducts.products.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (context) => MyPopUp(context, "Error",
                                  "You don't have any product", 1));
                        } else {
                          var route = MaterialPageRoute(
                              builder: (context) => makeOrder(
                                  profile: widget.profile,
                                  cart: widget.cart,
                                  connection: widget.connection,
                                  updateHome: widget.updateHome));
                          Navigator.of(context).push(route);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(CustomColors.n1),
                        fixedSize: MaterialStateProperty.all<Size>(Size(
                            constraints.maxWidth * 0.45,
                            constraints.maxHeight * 0.07)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Pay',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.1,
                    ),
                    Text(
                      "${widget.cart.total.toStringAsFixed(2)} €",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ]
          ],
        ),
      );
    });
  }
}
