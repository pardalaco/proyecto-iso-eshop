// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, must_be_immutable, duplicate_ignore, unused_element, use_build_context_synchronously, prefer_final_fields, no_logic_in_create_state
import 'package:eshop/models/Cart.dart';
import 'package:eshop/models/KeyboardController.dart';
import 'package:eshop/models/Profile.dart';
import 'package:eshop/models/Response.dart';
import 'package:eshop/models/Tag.dart';
import 'package:eshop/utils/MyWidgets.dart';
import 'package:eshop/views/editProduct.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:eshop/models/Comment.dart';
import 'package:eshop/sockets/connection.dart';
import 'package:flutter/material.dart';
import 'package:eshop/models/Product.dart';
import 'package:eshop/style/ColorsUsed.dart';
import 'dart:developer' as dev;

/////////////////////////////////////////
late KeyboardController kbcontroller;
late VoidCallback updateListCart;
TextEditingController _controller = TextEditingController();
TextEditingController _controller2 = TextEditingController();
late String rawComments;
double rate = 1;
bool firstTime = true;
bool show = true;
bool pass = false;
//////////////////////////////////////////

class DetailPage extends StatefulWidget {
  Product product;
  Connection connection;
  Profile profile;
  KeyboardController kb;
  bool adminMode;

  DetailPage(
      {super.key,
      required this.product,
      required this.connection,
      required this.profile,
      required this.kb,
      required this.adminMode});

  @override
  State<DetailPage> createState() => _DetailPageState(
      product: product,
      connection: connection,
      profile: profile,
      kb: kb,
      adminMode: adminMode);
}

class _DetailPageState extends State<DetailPage> {
  Product product;
  Connection connection;
  Profile profile;
  KeyboardController kb;
  bool adminMode;

  _DetailPageState(
      {Key? key,
      required this.product,
      required this.connection,
      required this.profile,
      required this.kb,
      required this.adminMode});

  @override
  Widget build(BuildContext context) {
    kbcontroller = kb;
    void updateView() {
      setState(() {});
    }

    return WillPopScope(
      onWillPop: () async {
        firstTime = true;
        rate = 1;
        show = true;
        pass = false;
        _controller = TextEditingController();
        _controller2 = TextEditingController();
        return true;
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            appBar: AppBar(
                toolbarHeight: constraints.maxHeight * 0.1,
                backgroundColor: CustomColors.n1,
                centerTitle: true,
                title: Text(
                  "Product details",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: constraints.maxHeight * 0.05,
                  ),
                )),
            body: Container(
              color: CustomColors.background,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  myImage(context, product, constraints),
                  myDescription(context, product, connection, profile.email,
                      constraints, updateView),
                  Container(
                    padding: EdgeInsetsDirectional.symmetric(
                        horizontal: constraints.maxWidth * 0.05,
                        vertical: constraints.maxHeight * 0.02),
                    width: double.infinity,
                    color: Colors.white,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => _MyAlert(context, connection,
                                profile.email, product.id, constraints));
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              CustomColors.n1)),
                      child: Icon(
                        Icons.add_shopping_cart,
                        color: Colors.white,
                        size: constraints.maxHeight * 0.04,
                      ),
                    ),
                  )
                ],
              ),
            ),
            floatingActionButton: adminMode
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: FloatingActionButton(
                      onPressed: () async {
                        var data = await connection.getTags();
                        Response response = Response.fromJson(data);
                        if (response.error) {
                          showDialog(
                              context: context,
                              builder: (context) => MyPopUp(
                                  context, "Error", "Something went wrong", 1));
                        } else {
                          Tags allTags = Tags.fromJson(response.content, false);
                          dev.log(allTags.toString());
                          allTags.intersectionToTrue(product.tags);
                          dev.log(allTags.toString());
                          var route = MaterialPageRoute(
                              builder: (context) => editProduct(
                                    connection: connection,
                                    product: product,
                                    profile: profile,
                                    tags: allTags,
                                    kb: kb,
                                    adminMode: adminMode,
                                  ));
                          Navigator.of(context).push(route);
                        }
                      },
                      backgroundColor: CustomColors.n1,
                      child: const Icon(Icons.edit, color: Colors.white),
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }
}

Widget myImage(context, Product producto, BoxConstraints constraints) {
  return SizedBox(
    height: constraints.maxHeight * 0.25,
    width: double.infinity,
    child: const Image(
      image: AssetImage("assets/img/gatitos.jpg"),
      fit: BoxFit.cover,
    ),
  );
}

Widget myDescription(context, Product product, Connection connection,
    String email, BoxConstraints constraints, VoidCallback updateView) {
  return Expanded(
      child: Container(
          width: double.infinity,
          padding: EdgeInsetsDirectional.only(
              start: constraints.maxWidth * 0.05,
              end: constraints.maxWidth * 0.05,
              top: constraints.maxHeight * 0.05),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: SizedBox(
            height: constraints.maxHeight * 0.5,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                          itemSize: 20,
                          initialRating: product.rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          ignoreGestures: true,
                          onRatingUpdate: (_rating) {},
                        ),
                        Text(
                          "(${product.count})",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.025,
                    ),
                    Text(
                      "${product.price.toStringAsFixed(2)} €",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.025,
                    ),
                    Text(
                      product.description,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.025,
                    ),
                    Text(
                      product.tags.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.025,
                    ),
                    ComAndRat(
                      connection: connection,
                      email: email,
                      p_id: product.id,
                      constraints: constraints,
                      product: product,
                      updateView: updateView,
                    )
                  ]),
            ),
          )));
}

Widget _MyAlert(context, Connection connection, String email, int p_id,
    BoxConstraints constraints) {
  return AlertDialog(
      title: const Text(
        "Select a cart",
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
          width: constraints.maxWidth * 0.15,
          height: constraints.maxHeight * 0.25,
          child: Column(children: [
            SizedBox(
              height: constraints.maxHeight * 0.15,
              child: _ListCart(
                connection: connection,
                email: email,
                p_id: p_id,
                constraints: constraints,
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.03,
            ),
            ElevatedButton(
              onPressed: () {
                show = false;
                showDialog(
                    context: context,
                    builder: (context) => _MyAlertAddCart(
                        context, connection, email, constraints));
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(CustomColors.n1)),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: constraints.maxHeight * 0.04,
              ),
            ),
          ])));
}

class _ListCart extends StatefulWidget {
  Connection connection;
  String email;
  int p_id;
  BoxConstraints constraints;
  _ListCart(
      {super.key,
      required this.connection,
      required this.email,
      required this.p_id,
      required this.constraints});
  @override
  State<_ListCart> createState() => _ListCartState();
}

class _ListCartState extends State<_ListCart> {
  @override
  void initState() {
    updateListCart = updateState;
    super.initState();
  }

  void updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (show) {
      return FutureBuilder(
        future: widget.connection.getAllCarts(widget.email),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData && pass) {
            pass = false;
            dev.log("Estoy en _ListCartState (if)");
            Response response = Response.fromJson(snapshot.data!);
            var carts = Carts.fromJson(response.content);
            final cartsList = carts.carts.map((c) {
              return ListTile(
                title: Text(c.cartname),
                onTap: () async {
                  var data = await widget.connection
                      .addToCart(widget.email, c.cartid, widget.p_id);
                  Response response = Response.fromJson(data);
                  bool success = response.content["success"];
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: SizedBox(
                          height: widget.constraints.maxHeight * 0.05,
                          child: Text(
                            'Add to ${c.cartname}',
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        backgroundColor: CustomColors.n1,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: SizedBox(
                          height: widget.constraints.maxHeight * 0.05,
                          child: const Text(
                            'ERROR ADDING PRODUCT',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        backgroundColor: CustomColors.n1,
                      ),
                    );
                  }
                  Navigator.of(context).pop();
                },
              );
            }).toList();
            return Scrollbar(
                trackVisibility: true,
                thumbVisibility: true,
                child: ListView.builder(
                  itemCount: cartsList.length,
                  itemBuilder: (context, index) => cartsList[index],
                ));
          } else {
            pass = true;
            dev.log("Estoy en _ListCartState (else)");
            return Center(
                child: SizedBox(
              height: widget.constraints.maxWidth * 0.1,
              width: widget.constraints.maxWidth * 0.1,
              child: const CircularProgressIndicator(
                  strokeWidth: 5,
                  valueColor: AlwaysStoppedAnimation(CustomColors.n1)),
            ));
          }
        },
      );
    } else {
      return SizedBox(
        child: IconButton(
          onPressed: () {
            show = true;
            setState(() {});
          },
          icon: Icon(
            Icons.refresh,
            color: CustomColors.n1,
            size: widget.constraints.maxHeight * 0.04,
          ),
        ),
      );
    }
  }
}

Widget _MyAlertAddCart(
    context, Connection connection, String email, BoxConstraints constraints) {
  return AlertDialog(
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
                borderSide: BorderSide(color: CustomColors.n1),
              ),
            ),
            cursorColor: CustomColors.n1,
          )),
      actions: [
        TextButton(
            onPressed: () async {
              FocusScope.of(context).unfocus();
              while (kbcontroller.keyboardOpen) {
                await Future.delayed(const Duration(milliseconds: 500));
              }
              show = true;
              updateListCart();
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
                var data = await connection.createCart(email, _controller.text);
                Response response = Response.fromJson(data);
                if (response.error || !response.content["success"]) {
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
              }
              _controller.clear();
              while (kbcontroller.keyboardOpen) {
                await Future.delayed(const Duration(milliseconds: 500));
              }
              show = true;
              updateListCart();
              Navigator.of(context).pop();
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

class ComAndRat extends StatefulWidget {
  Connection connection;
  String email;
  int p_id;
  Product product;
  BoxConstraints constraints;
  VoidCallback updateView;
  ComAndRat(
      {super.key,
      required this.connection,
      required this.email,
      required this.p_id,
      required this.constraints,
      required this.product,
      required this.updateView});

  @override
  State<ComAndRat> createState() => _ComAndRatState();
}

Future<String> getComments(Connection connection, int p_id) async {
  if (firstTime) {
    rawComments = await connection.viewProductRating(p_id);
    firstTime = false;
  }
  return rawComments;
}

class _ComAndRatState extends State<ComAndRat> {
  FocusNode _textFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _textFieldFocusNode.addListener(() async {
      if (_textFieldFocusNode.hasFocus) {
        dev.log("TextField seleccionado");
      } else {
        dev.log("TextField no seleccionado");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Divider(
        color: CustomColors.n2,
        thickness: 2,
      ),
      SizedBox(
        height: widget.constraints.maxHeight * 0.01,
      ),
      const Text(
        "Rate product",
        style: TextStyle(
          color: Colors.black,
          fontSize: 23,
        ),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: widget.constraints.maxHeight * 0.01,
      ),
      RatingBar.builder(
        itemSize: 25,
        initialRating: rate,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (_rating) {
          rate = _rating;
        },
      ),
      SizedBox(
        height: widget.constraints.maxHeight * 0.015,
      ),
      TextField(
        controller: _controller2,
        focusNode: _textFieldFocusNode,
        decoration: const InputDecoration(
          hintText: "Optional comment",
          filled: true,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: CustomColors.n1),
          ),
        ),
        cursorColor: CustomColors.n1,
      ),
      SizedBox(
        height: widget.constraints.maxHeight * 0.025,
      ),
      Center(
        child: ElevatedButton(
          onPressed: () async {
            var data = await widget.connection.rateProduct(
                widget.email, widget.p_id, rate, _controller2.text);
            Response response = Response.fromJson(data);
            if (response.error || !response.content["success"]) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      MyPopUp(context, "Error", "Error adding the comment", 1));
            } else {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                          title: const Text(
                            "Message",
                            textAlign: TextAlign.center,
                          ),
                          content: const Text("Comment added",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                              textAlign: TextAlign.center),
                          actions: [
                            Center(
                              child: TextButton(
                                  onPressed: () async {
                                    firstTime = true;
                                    data = await widget.connection
                                        .getProductByID(
                                            widget.email, widget.product.id);
                                    response = Response.fromJson(data);
                                    if (!response.error) {
                                      widget.product = Product.fromJson(
                                          response.content, false);
                                      dev.log(widget.product.count.toString());
                                      firstTime = true;
                                      rate = 1;
                                      show = true;
                                      pass = false;
                                      _controller = TextEditingController();
                                      _controller2 = TextEditingController();
                                      Navigator.of(context).pop();
                                      widget.updateView();
                                    }
                                  },
                                  child: const Text(
                                    "OK",
                                    style: TextStyle(
                                        color: CustomColors.n1,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  )),
                            )
                          ]));
            }
          },
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(CustomColors.n1)),
          child: Icon(
            Icons.comment,
            color: Colors.white,
            size: widget.constraints.maxHeight * 0.04,
          ),
        ),
      ),
      SizedBox(
        height: widget.constraints.maxHeight * 0.025,
      ),
      FutureBuilder(
        future: getComments(widget.connection, widget.p_id),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            dev.log("Estoy en el ComRat dentro del if");
            Response response = Response.fromJson(snapshot.data!);
            var comments = Comments.fromJson(response.content);
            final commentsList = comments.comments.map((c) {
              return Container(
                padding: const EdgeInsetsDirectional.all(20),
                margin: const EdgeInsetsDirectional.only(bottom: 10),
                decoration: BoxDecoration(
                    color: CustomColors.n2.withOpacity(0.3),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    )),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.email,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: widget.constraints.maxHeight * 0.01,
                    ),
                    Row(
                      children: [
                        RatingBar.builder(
                          itemSize: 25,
                          initialRating: c.rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          ignoreGestures: true,
                          onRatingUpdate: (_rating) {},
                        ),
                        Text(
                          c.date,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: widget.constraints.maxHeight * 0.01,
                    ),
                    if (c.com != null) ...[
                      Text(
                        c.com!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ]
                  ],
                ),
              );
            }).toList();
            return Column(
              children: commentsList,
            );
          }
          dev.log("Estoy en el ComRat fuera del if");
          return Center(
              child: SizedBox(
            height: widget.constraints.maxWidth * 0.1,
            width: widget.constraints.maxWidth * 0.1,
            child: const CircularProgressIndicator(
                strokeWidth: 5,
                valueColor: AlwaysStoppedAnimation(CustomColors.n1)),
          ));
        },
      )
    ]);
  }
}
