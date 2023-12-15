import 'package:eshop/models/Profile.dart';
import 'package:flutter/material.dart';
import 'views/logIn.dart';
import 'views/home.dart';
import 'sockets/connection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'eShop',
        debugShowCheckedModeBanner: false,
        /*home: Home(
            connection: Connection(),
            admin: true,
            profile: Profile(
                email: "psegmar1@gmail.com",
                password: "1234",
                name: "Pablo",
                payment: "null",
                address: "null")),*/
        home: logIn(),
      );
}
