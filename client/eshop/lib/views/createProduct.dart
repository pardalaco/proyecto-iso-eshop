// ignore_for_file: camel_case_types, use_build_context_synchronously, must_be_immutable

import 'package:eshop/models/Product.dart';
import 'package:eshop/models/Response.dart';
import 'package:eshop/models/Tag.dart';
import 'package:eshop/utils/MyWidgets.dart';
import 'package:eshop/sockets/connection.dart';
import 'package:flutter/material.dart';
import 'package:eshop/style/ColorsUsed.dart';
import 'dart:developer' as dev;

////////////////////////////////////////
String? name;
String? description;
double? price;
TextEditingController _controller = TextEditingController();
////////////////////////////////////////

class createProduct extends StatefulWidget {
  final Tags tags;
  final Connection connection;
  final String email;

  const createProduct(
      {super.key,
      required this.connection,
      required this.tags,
      required this.email});

  @override
  State<createProduct> createState() => createProductState();
}

class createProductState extends State<createProduct> {
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
              "Add product",
              style: TextStyle(
                color: Colors.white,
                fontSize: constraints.maxHeight * 0.05,
              ),
            )),
        body: SingleChildScrollView(
            child: MyForm(
          connection: widget.connection,
          email: widget.email,
          tags: widget.tags,
          constraints: constraints,
        )),
      );
    });
  }
}

class MyForm extends StatefulWidget {
  final String email;
  final Tags tags;
  final Connection connection;
  final BoxConstraints constraints;

  const MyForm({
    super.key,
    required this.connection,
    required this.email,
    required this.tags,
    required this.constraints,
  });

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
          const Text(
            'Create a new product',
            style: TextStyle(
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
                onSaved: (value) => name = value,
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
                onSaved: (value) => description = value,
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
                onSaved: (value) => price = double.tryParse(value!),
              ),
              SizedBox(
                height: widget.constraints.maxHeight * 0.03,
              ),
              Row(
                children: [
                  const Text(
                    'Tags',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: widget.constraints.maxWidth * 0.1,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                  title: const Text(
                                    "Create a tag",
                                    textAlign: TextAlign.center,
                                  ),
                                  content: SizedBox(
                                      width: widget.constraints.maxWidth * 0.15,
                                      height:
                                          widget.constraints.maxHeight * 0.07,
                                      child: TextField(
                                        controller: _controller,
                                        decoration: const InputDecoration(
                                          hintText: 'New tag name',
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: CustomColors.n1),
                                          ),
                                        ),
                                        cursorColor: CustomColors.n1,
                                      )),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
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
                                            String s =
                                                _controller.text.toUpperCase();
                                            if (s.length > 1) {
                                              s = s.substring(0, 1) +
                                                  s.substring(1).toLowerCase();
                                            }
                                            var data = await widget.connection
                                                .addNewTag(widget.email, s);
                                            Response response =
                                                Response.fromJson(data);
                                            if (response.error ||
                                                !response.content["success"]) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: SizedBox(
                                                    height: widget.constraints
                                                            .maxHeight *
                                                        0.05,
                                                    child: const Text(
                                                      'Error creating tag',
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      CustomColors.n1,
                                                ),
                                              );
                                            } else {
                                              widget.tags.tags
                                                  .add(Tag.fromJson(s, false));
                                              _controller.clear();
                                              setState(() {});
                                            }
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
                                  ]));
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(CustomColors.n1)),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: widget.constraints.maxHeight * 0.04,
                    ),
                  )
                ],
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
                  if (widget.tags.onlyTrues() != "" &&
                      (formState?.validate() ?? false)) {
                    formState!.save();
                    dev.log(
                        "Name = $name, description = $description, price = $price");
                    Product product = Product(
                        name: name!,
                        description: description!,
                        image: "Nada",
                        price: price!,
                        tags: widget.tags);
                    var data = await widget.connection
                        .addNewProduct(product, widget.email);
                    Response response = Response.fromJson(data);
                    if (response.error || !response.content["success"]) {
                      showDialog(
                          context: context,
                          builder: (context) => MyPopUp(
                              context, "Error", "Something went wrong", 1));
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => MyPopUp(
                              context, "Successfully", "Product created", 2));
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
                  'Create product',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ]),
          )
        ]));
  }
}
