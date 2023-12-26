// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_const_constructors, no_leading_underscores_for_local_identifiers, no_logic_in_create_state, must_be_immutable, unused_element, sized_box_for_whitespace, use_build_context_synchronously, camel_case_types
import 'package:eshop/models/Cart.dart';
import 'package:eshop/models/Response.dart';
import 'package:eshop/utils/MyWidgets.dart';
import 'package:eshop/views/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:eshop/sockets/connection.dart';
import 'package:eshop/models/Profile.dart';
import 'package:eshop/style/ColorsUsed.dart';
import 'dart:developer' as dev;

class makeOrder extends StatefulWidget {
  final Cart cart;
  final Profile profile;
  final Connection connection;
  final VoidCallback updateHome;

  const makeOrder(
      {super.key,
      required this.profile,
      required this.cart,
      required this.connection,
      required this.updateHome});

  @override
  State<makeOrder> createState() => _makeOrderState();
}

class _makeOrderState extends State<makeOrder> {
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
            "Make order",
            style: TextStyle(
              color: Colors.white,
              fontSize: constraints.maxHeight * 0.05,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              const Text(
                "Order info",
                textAlign: TextAlign.center,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.01,
              ),
              SizedBox(
                width: double.infinity,
                child: ListView.separated(
                  shrinkWrap: true,
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
                      subtitle: Text(
                        "x${widget.cart.listProducts.products[index].quantity}",
                        style: const TextStyle(fontSize: 15),
                      ),
                      textColor: Colors.white,
                      trailing: Text(
                        widget.cart.listProducts.products[index].price
                                .toStringAsFixed(2) +
                            " €",
                        style: const TextStyle(fontSize: 15),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.01,
              ),
              Text(
                "Total: ${widget.cart.total.toStringAsFixed(2)} €",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              const Text(
                "Payment method",
                textAlign: TextAlign.center,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.01,
              ),
              if (widget.profile.payment != null) ...[
                Text(
                  "${widget.profile.payment}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ] else ...[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    dev.log(("Ir a editar perfil"));
                    var route = MaterialPageRoute(
                        builder: (context) => EditProfile(
                              connection: widget.connection,
                              profile: widget.profile,
                              updateHome: widget.updateHome,
                            ));
                    Navigator.of(context).push(route);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(CustomColors.n1),
                    fixedSize: MaterialStateProperty.all<Size>(Size(
                        constraints.maxWidth * 0.25,
                        constraints.maxHeight * 0.07)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ],
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              const Text(
                "Address",
                textAlign: TextAlign.center,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.01,
              ),
              if (widget.profile.address != null) ...[
                Text(
                  "${widget.profile.address}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ] else ...[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    dev.log(("Ir a editar perfil"));
                    var route = MaterialPageRoute(
                        builder: (context) => EditProfile(
                              connection: widget.connection,
                              profile: widget.profile,
                              updateHome: widget.updateHome,
                            ));
                    Navigator.of(context).push(route);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(CustomColors.n1),
                    fixedSize: MaterialStateProperty.all<Size>(Size(
                        constraints.maxWidth * 0.25,
                        constraints.maxHeight * 0.07)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ],
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (widget.profile.address == null ||
                      widget.profile.payment == null) {
                    showDialog(
                        context: context,
                        builder: (context) => MyPopUp(context, "Error",
                            "You have to update your profile", 1));
                  } else {
                    var data = await widget.connection
                        .purchase(widget.profile.email, widget.cart.cartid);
                    Response response = Response.fromJson(data);
                    if (response.error || !response.content["success"]) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: SizedBox(
                            height: constraints.maxHeight * 0.05,
                            child: const Text(
                              'ERROR BUYING CART',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          backgroundColor: CustomColors.n1,
                        ),
                      );
                    } else {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => MyPopUp(context, "Successfully",
                              "Order placed, continue exploring", 4));
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(CustomColors.n1),
                  fixedSize: MaterialStateProperty.all<Size>(Size(
                      constraints.maxWidth * 0.45,
                      constraints.maxHeight * 0.07)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                child: const Text(
                  'Make order',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
            ],
          ),
        ),
      );
    });
  }
}
