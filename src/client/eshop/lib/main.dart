import 'package:flutter/material.dart';
import 'views/logIn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(
        title: 'eShop',
        debugShowCheckedModeBanner: false,
        home: logIn(),
      );
}
