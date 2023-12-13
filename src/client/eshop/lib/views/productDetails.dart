// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, must_be_immutable, duplicate_ignore, unused_element, use_build_context_synchronously, prefer_final_fields
import 'dart:async';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:eshop/models/Cart.dart';
import 'package:eshop/models/Profile.dart';
import 'package:eshop/models/Response.dart';
import 'package:eshop/utils/MyWidgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:eshop/models/Comment.dart';
import 'package:eshop/sockets/connection.dart';
import 'package:flutter/material.dart';
import 'package:eshop/models/Product.dart';
import 'package:eshop/style/ColorsUsed.dart';

class DetailPage extends StatelessWidget {
  Product producto;
  Connection connection;
  Profile profile;
  DetailPage(
      {Key? key,
      required this.producto,
      required this.connection,
      required this.profile})
      : super(key: key);

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
              myDescription(context, producto, connection, profile.email),
              Container(
                padding: EdgeInsetsDirectional.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                    vertical: MediaQuery.of(context).size.height * 0.02),
                width: double.infinity,
                color: Colors.white,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => _MyAlert(
                            context, connection, profile.email, producto.id));
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(CustomColors.n1)),
                  child: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.height * 0.04,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

Widget myImage(context, Product producto) {
  final Size size = MediaQuery.of(context).size;
  final double altura = size.height;
  return SizedBox(
    height: altura * 0.25,
    width: double.infinity,
    child: const Image(
      image: AssetImage("assets/img/gatitos.jpg"),
      fit: BoxFit.cover,
    ),
  );
}

Widget myDescription(
    context, Product producto, Connection connection, String email) {
  final Size size = MediaQuery.of(context).size;
  final double altura = size.height;
  return Expanded(
      child: Container(
          width: double.infinity,
          padding: EdgeInsetsDirectional.only(
              start: size.width * 0.05,
              end: size.width * 0.05,
              top: altura * 0.05),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
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
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: altura * 0.025,
                    ),
                    Text(
                      "${producto.price} €",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
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
                    Text(
                      "Tags: ${producto.tags.toString()}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: altura * 0.025,
                    ),
                    ComAndRat(
                      connection: connection,
                      avgRate: producto.rating,
                      email: email,
                      p_id: producto.id,
                    )
                  ]),
            ),
          )));
}

Widget _MyAlert(context, Connection connection, String email, int p_id) =>
    AlertDialog(
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
                  child: _ListCart(
                    connection: connection,
                    email: email,
                    p_id: p_id,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            _MyAlertAddCart(context, connection, email));
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
  Connection connection;
  String email;
  int p_id;
  _ListCart(
      {super.key,
      required this.connection,
      required this.email,
      required this.p_id});
  @override
  State<_ListCart> createState() => _ListCartState();
}

class _ListCartState extends State<_ListCart> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.connection.getAllCarts(widget.email),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
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
                        height: MediaQuery.of(context).size.height * 0.05,
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
                        height: MediaQuery.of(context).size.height * 0.05,
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
          return ListView.builder(
            itemCount: cartsList.length,
            itemBuilder: (context, index) => cartsList[index],
          );
        }
        return Center(
            child: SizedBox(
          height: MediaQuery.of(context).size.width * 0.1,
          width: MediaQuery.of(context).size.width * 0.1,
          child: const CircularProgressIndicator(
              strokeWidth: 5,
              valueColor: AlwaysStoppedAnimation(CustomColors.n1)),
        ));
      },
    );
  }
}

Widget _MyAlertAddCart(context, Connection connection, String email) {
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
            onPressed: () async {
              if (_controller.text.isNotEmpty) {
                var data = await connection.createCart(email, _controller.text);
                Response response = Response.fromJson(data);
                if (response.error || !response.content["success"]) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
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
  double avgRate;
  String email;
  int p_id;
  ComAndRat(
      {super.key,
      required this.connection,
      required this.avgRate,
      required this.email,
      required this.p_id});

  @override
  State<ComAndRat> createState() => _ComAndRatState();
}

class _ComAndRatState extends State<ComAndRat> {
  TextEditingController _controller = TextEditingController();
  double rate = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: CustomColors.n2,
          thickness: 2,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Text(
          "Average rating: ${widget.avgRate}",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 23,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        RatingBar.builder(
          itemSize: 25,
          initialRating: 1,
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
          height: MediaQuery.of(context).size.height * 0.015,
        ),
        TextField(
          controller: _controller,
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
          height: MediaQuery.of(context).size.height * 0.025,
        ),
        ElevatedButton(
          onPressed: () async {
            var data = await widget.connection
                .rateProduct(widget.email, widget.p_id, rate, _controller.text);
            Response response = Response.fromJson(data);
            if (response.error || !response.content["success"]) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      MyPopUp(context, "Error", "Error adding the comment", 1));
            } else {
              showDialog(
                  context: context,
                  builder: (context) =>
                      MyPopUp(context, "Message", "Comment added", 1));
            }
            setState(() {});
          },
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(CustomColors.n1)),
          child: Icon(
            Icons.comment,
            color: Colors.white,
            size: MediaQuery.of(context).size.height * 0.04,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.025,
        ),
        FutureBuilder(
          future: widget.connection.viewProductRating(widget.p_id),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
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
                        height: MediaQuery.of(context).size.height * 0.01,
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
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        c.com,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList();
              return Column(
                children: commentsList,
              );
            }
            return Center(
                child: SizedBox(
              height: MediaQuery.of(context).size.width * 0.1,
              width: MediaQuery.of(context).size.width * 0.1,
              child: const CircularProgressIndicator(
                  strokeWidth: 5,
                  valueColor: AlwaysStoppedAnimation(CustomColors.n1)),
            ));
          },
        )
      ],
    );
  }
}
