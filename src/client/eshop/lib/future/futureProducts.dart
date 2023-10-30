import 'dart:developer' as dev;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

Future<String> getProducts(BuildContext context) async {
  //var data = await DefaultAssetBundle.of(context)
  //   .loadString("assets/json/products.json'");
  dev.log('HOLA');
  try {
    var data = await rootBundle.loadString('assets/json/products.json');
    //var file = File('assets/json/products.json');
    //var data = await file.readAsString();

    dev.log(data.toString());
    //return data;
    return data;
  } catch (e) {
    dev.log(e.toString());

    return '';
  }
}

class FutureJson extends StatelessWidget {
  const FutureJson({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder(
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.toString());
        } else {
          return const CircularProgressIndicator();
        }
      },
      future: getProducts(context),
    ));
  }
}
