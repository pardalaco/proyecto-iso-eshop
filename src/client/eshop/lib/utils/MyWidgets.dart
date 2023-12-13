// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:eshop/style/ColorsUsed.dart';

Widget MyPopUp(context, String title, String msg, int numberPops) =>
    AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        content: Text(msg,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
            textAlign: TextAlign.center),
        actions: [
          Center(
            child: TextButton(
                onPressed: () {
                  for (int i = 0; i < numberPops; i++) {
                    Navigator.of(context).pop();
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
        ]);
