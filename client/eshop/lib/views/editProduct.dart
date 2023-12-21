// ignore_for_file: camel_case_types, use_build_context_synchronously, must_be_immutable

import 'package:eshop/models/KeyboardController.dart';
import 'package:eshop/models/Profile.dart';
import 'package:eshop/models/Response.dart';
import 'package:eshop/models/Tag.dart';
import 'package:eshop/utils/MyWidgets.dart';
import 'package:eshop/sockets/connection.dart';
import 'package:eshop/views/productDetails.dart';
import 'package:flutter/material.dart';
import 'package:eshop/models/Product.dart';
import 'package:eshop/style/ColorsUsed.dart';
import 'dart:developer' as dev;

////////////////////////////////////////
String? newName;
String? newDescription;
double? newPrice;
////////////////////////////////////////

class editProduct extends StatefulWidget {
  Product product;
  final Tags tags;
  final Connection connection;
  final Profile profile;
  final KeyboardController kb;
  final bool adminMode;

  editProduct(
      {super.key,
      required this.connection,
      required this.product,
      required this.tags,
      required this.profile,
      required this.kb,
      required this.adminMode});

  @override
  State<editProduct> createState() => _editProductState();
}

class _editProductState extends State<editProduct> {
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
              "Edit product",
              style: TextStyle(
                color: Colors.white,
                fontSize: constraints.maxHeight * 0.05,
              ),
            )),
        body: SingleChildScrollView(
            child: MyForm(
          connection: widget.connection,
          product: widget.product,
          email: widget.profile.email,
          tags: widget.tags,
          constraints: constraints,
          profile: widget.profile,
          kb: widget.kb,
          adminMode: widget.adminMode,
        )),
      );
    });
  }
}

class MyForm extends StatefulWidget {
  Product product;
  final String email;
  final Tags tags;
  final Connection connection;
  final Profile profile;
  final BoxConstraints constraints;
  final KeyboardController kb;
  final bool adminMode;

  MyForm(
      {super.key,
      required this.connection,
      required this.product,
      required this.email,
      required this.tags,
      required this.constraints,
      required this.profile,
      required this.adminMode,
      required this.kb});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.constraints.maxWidth,
        color: CustomColors.background,
        padding: EdgeInsetsDirectional.symmetric(
            horizontal: widget.constraints.maxWidth * 0.05,
            vertical: widget.constraints.maxHeight * 0.03),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: widget.constraints.maxHeight * 0.01),
          Text(
            'Product ${widget.product.id.toString()}',
            style: const TextStyle(
                color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: widget.constraints.maxHeight * 0.03),
          Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Name',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: widget.constraints.maxHeight * 0.01),
              TextFormField(
                initialValue: widget.product.name,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.n1),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.n1),
                  ),
                  filled: true,
                  fillColor: CustomColors.n2,
                ),
                cursorColor: CustomColors.n1,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Required';
                  return null;
                },
                onSaved: (value) => newName = value,
              ),
              SizedBox(height: widget.constraints.maxHeight * 0.03),
              const Text(
                'Description',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: widget.constraints.maxHeight * 0.01),
              TextFormField(
                initialValue: widget.product.description,
                maxLines: null,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.n1),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.n1),
                  ),
                  filled: true,
                  fillColor: CustomColors.n2,
                ),
                cursorColor: CustomColors.n1,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Required';
                  return null;
                },
                onSaved: (value) => newDescription = value,
              ),
              SizedBox(
                height: widget.constraints.maxHeight * 0.03,
              ),
              const Text(
                'Price',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: widget.constraints.maxHeight * 0.01),
              TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                initialValue: widget.product.price.toString(),
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.n1),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.n1),
                  ),
                  filled: true,
                  fillColor: CustomColors.n2,
                ),
                cursorColor: CustomColors.n1,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Required';
                  return null;
                },
                onSaved: (value) => newPrice = double.tryParse(value!),
              ),
              SizedBox(
                height: widget.constraints.maxHeight * 0.03,
              ),
              const Text(
                'Tags',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: widget.constraints.maxHeight * 0.01),
              SizedBox(
                height: widget.constraints.maxHeight * 0.15,
                child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                    children: widget.tags.tags.map((t) {
                      return CheckboxListTile(
                        title: Text(t.name,
                            style: const TextStyle(color: Colors.white)),
                        value: t.choose,
                        side: const BorderSide(color: Colors.white),
                        activeColor: CustomColors.n1,
                        onChanged: (bool? value) {
                          t.choose = value ?? false;
                          setState(() {});
                        },
                      );
                    }).toList()),
              ),
              SizedBox(
                height: widget.constraints.maxHeight * 0.03,
              ),
              ElevatedButton(
                onPressed: () async {
                  final formState = _formKey.currentState;
                  if ((formState?.validate() ?? false)) {
                    bool success = true;
                    formState!.save(); // Guarda valores en var. de estado
                    dev.log(
                        "Name = $newName\nDescription = $newDescription\nPrice = $newPrice\nTags = ${widget.tags.onlyTrues()}");
                    Map<String, dynamic> json = {
                      "email": widget.email,
                      "productid": widget.product.id,
                      "name": newName,
                      "description": newDescription,
                      "price": newPrice.toString()
                    };
                    var data = await widget.connection.editProduct(json);
                    Response response = Response.fromJson(data);
                    success = success && !response.error;
                    if (response.error || !response.content["success"]) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: SizedBox(
                            height: widget.constraints.maxHeight * 0.05,
                            child: const Text(
                              'Error editing name, description or price',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          backgroundColor: CustomColors.n1,
                        ),
                      );
                    }
                    data = await widget.connection.changeProductSetTags(
                        widget.email,
                        widget.product.id,
                        widget.tags.onlyTrues());
                    response = Response.fromJson(data);
                    success = success && !response.error;
                    if (response.error || !response.content["success"]) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: SizedBox(
                            height: widget.constraints.maxHeight * 0.05,
                            child: const Text(
                              'Error editing tags',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          backgroundColor: CustomColors.n1,
                        ),
                      );
                    }
                    data = await widget.connection
                        .getProductByID(widget.email, widget.product.id);
                    response = Response.fromJson(data);
                    if (!response.error) {
                      widget.product =
                          Product.fromJson(response.content, false);
                      dev.log("Ya tengo los datos del producto");
                    }
                    if (success) {
                      dev.log("Todo OK");
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                  title: const Text(
                                    "Successfully",
                                    textAlign: TextAlign.center,
                                  ),
                                  content: const Text("Everything it's okey",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      textAlign: TextAlign.center),
                                  actions: [
                                    Center(
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                            var route = MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailPage(
                                                      connection:
                                                          widget.connection,
                                                      product: widget.product,
                                                      profile: widget.profile,
                                                      adminMode:
                                                          widget.adminMode,
                                                      kb: widget.kb,
                                                    ));
                                            Navigator.of(context)
                                                .pushReplacement(route);
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
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => MyPopUp(
                              context, "Error", "Something went wrong", 1));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Invalid form',
                          style: TextStyle(fontSize: 20),
                        ),
                        backgroundColor: CustomColors.n1,
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(CustomColors.n1),
                  fixedSize: MaterialStateProperty.all<Size>(Size(
                      widget.constraints.maxWidth,
                      widget.constraints.maxHeight * 0.07)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                child: const Text(
                  'Save changes',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ]),
          )
        ]));
  }
}
