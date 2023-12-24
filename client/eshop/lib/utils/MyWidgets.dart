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

AppBar SimpleAppBar(BoxConstraints constraints, String text) {
  return AppBar(
    toolbarHeight: constraints.maxHeight * 0.1,
    backgroundColor: CustomColors.n1,
    centerTitle: true,
    title: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: constraints.maxHeight * 0.05,
      ),
    ),
  );
}

Widget MyErrorWidget(String errorMessage) {
  return Center(
    child: Text(
      errorMessage,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget MyLoadingWidget() {
  return const Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(CustomColors.n1),
    ),
  );
}
