// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_const_constructors, no_leading_underscores_for_local_identifiers, no_logic_in_create_state, must_be_immutable, unused_element, sized_box_for_whitespace, use_build_context_synchronously, camel_case_types
import 'package:eshop/models/Cart.dart';
import 'package:eshop/models/Response.dart';
import 'package:eshop/utils/MyWidgets.dart';
import 'package:eshop/views/cartView.dart';
import 'package:flutter/material.dart';
import 'package:eshop/sockets/connection.dart';
import 'package:eshop/models/Profile.dart';
import 'package:eshop/style/ColorsUsed.dart';
import 'dart:developer' as dev;

/////////////////////////////////
TextEditingController _controller = TextEditingController();
////////////////////////////////

class cartList extends StatefulWidget {
  final Connection connection;
  final Profile profile;

  const cartList({super.key, required this.connection, required this.profile});

  @override
  State<cartList> createState() => _cartListState();
}

class _cartListState extends State<cartList> {
  void reloadCartList() {
    setState(() {});
  }

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
              "Carts",
              style: TextStyle(
                color: Colors.white,
                fontSize: constraints.maxHeight * 0.05,
              ),
            )),
        body: FutureBuilder(
            future: widget.connection.getAllCarts(widget.profile.email),
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                Response response = Response.fromJson(snapshot.data!);
                if (response.error) {
                  return Center(
                    child: const Text(
                      "Something went wrong",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                } else {
                  Carts carts = Carts.fromJson(response.content);
                  if (carts.carts.isEmpty) {
                    return Center(
                      child: const Text(
                        "There aren't any cart",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  } else {
                    final allCarts = carts.carts.map((c) {
                      return ListTile(
                        title: Text(
                          c.cartname,
                          style: const TextStyle(fontSize: 25),
                        ),
                        textColor: Colors.white,
                        subtitle: Text(
                          c.total.toStringAsFixed(2) + " €",
                          style: const TextStyle(fontSize: 20),
                        ),
                        onTap: () async {
                          dev.log("Ir a la vista del carrito");
                          var data = await widget.connection
                              .requestCartProducts(
                                  widget.profile.email, c.cartid);
                          Response response = Response.fromJson(data);
                          if (response.error || !response.content["success"]) {
                            showDialog(
                                context: context,
                                builder: (context) => MyPopUp(context, "Error",
                                    "Something went wrong", 1));
                          } else {
                            Cart cart = Cart.fromJson(response.content, true);
                            cart.cartid = c.cartid;
                            cart.cartname = c.cartname;
                            var route = MaterialPageRoute(
                              builder: (context) => cartView(
                                  profile: widget.profile,
                                  cart: cart,
                                  connection: widget.connection,
                                  reloadCartList: reloadCartList),
                            );
                            Navigator.of(context).push(route);
                          }
                        },
                        trailing: ElevatedButton(
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
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              )),
                                          TextButton(
                                              onPressed: () async {
                                                dev.log("Eliminar carrito");
                                                var data = await widget
                                                    .connection
                                                    .deleteCart(
                                                        widget.profile.email,
                                                        c.cartid);
                                                Response response =
                                                    Response.fromJson(data);
                                                if (response.error ||
                                                    !response
                                                        .content["success"]) {
                                                  ScaffoldMessenger.of(context)
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
                                                setState(() {});
                                              },
                                              child: const Text(
                                                "YES",
                                                style: TextStyle(
                                                    color: CustomColors.n1,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              )),
                                        ]));
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  CustomColors.n1)),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: constraints.maxHeight * 0.04,
                          ),
                        ),
                      );
                    }).toList();
                    return ListView.separated(
                      padding: const EdgeInsets.all(5.0),
                      itemBuilder: (context, index) => allCarts[index],
                      separatorBuilder: (context, index) => const Divider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                      itemCount: allCarts.length,
                    );
                  }
                }
              } else {
                return Center(
                    child: SizedBox(
                  height: constraints.maxWidth * 0.25,
                  width: constraints.maxWidth * 0.25,
                  child: const CircularProgressIndicator(
                      strokeWidth: 5,
                      valueColor: AlwaysStoppedAnimation(CustomColors.n1)),
                ));
              }
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                        title: const Text(
                          "Create a cart",
                          textAlign: TextAlign.center,
                        ),
                        content: SizedBox(
                            width: constraints.maxWidth * 0.15,
                            height: constraints.maxHeight * 0.07,
                            child: TextField(
                              controller: _controller,
                              decoration: const InputDecoration(
                                hintText: 'New cart name',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: CustomColors.n1),
                                ),
                              ),
                              cursorColor: CustomColors.n1,
                            )),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
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
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                if (_controller.text.isNotEmpty) {
                                  var data = await widget.connection.createCart(
                                      widget.profile.email, _controller.text);
                                  Response response = Response.fromJson(data);
                                  if (response.error ||
                                      !response.content["success"]) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: SizedBox(
                                          height: constraints.maxHeight * 0.05,
                                          child: const Text(
                                            'ERROR CREATING CART',
                                            style: TextStyle(fontSize: 25),
                                          ),
                                        ),
                                        backgroundColor: CustomColors.n1,
                                      ),
                                    );
                                  }
                                  _controller.clear();
                                  Navigator.of(context).pop();
                                  setState(() {});
                                }
                              },
                              child: const Text(
                                "Create",
                                style: TextStyle(
                                    color: CustomColors.n1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              )),
                        ]));
          },
          backgroundColor: CustomColors.n1,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      );
    });
  }
}
