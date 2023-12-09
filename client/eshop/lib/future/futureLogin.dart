import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:eshop/products_list_view.dart';

// Json
import 'package:eshop/jsons/loginJsonSend.dart';
import 'package:eshop/jsons/loginJsonRecipt.dart';

// Conexion
import 'package:eshop/sockets/connection.dart';

Future<List<dynamic>> _data(
    Connection connection, String user, String pwd) async {
  LoginSend data = LoginSend(
      type: 1, code: 1, content: ContentSend(email: user, password: pwd));

  //print(data.toJson().toString());
  print("---> ENVIADO: " + data.toJson().toString());
  await connection.query(data.toJson());

  // Recipt data from the server
  var dataRecipt = connection.getData();
  print("<--- RECIBIDO: " + dataRecipt.toString());

  LoginRecipt dataReturn = LoginRecipt.fromJson(dataRecipt);

  // Create a List with the boolean and the string

  if (dataReturn.type != 1) {
    return [false, "Server error. Type error."];
  } else if (dataReturn.code != 1) {
    return [false, "Server error. Code error."];
  } else if (!dataReturn.content.success) {
    return [false, "Authentication error."];
  }

  return [dataReturn.content.success, "All good"];
}

class FutureLogin extends StatelessWidget {
  Connection connection;
  String user, pwd;

  FutureLogin(
      {super.key,
      required this.connection,
      required this.user,
      required this.pwd});

  AlertDialog createAlert(BuildContext context, String message) => AlertDialog(
        title: const Text("Error"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
              onPressed: () {
                debugPrint("Press Accept");
                Navigator.of(context).pop();
              },
              child: const Text("Accept")),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<dynamic>>(
        // Cambia el tipo de AsyncSnapshot
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            bool success = snapshot.data![0];
            String message = snapshot.data![1];

            if (success) {
              // Si es un éxito, muestra lo que desees
              return ProductsPage(
                connection: connection,
              );
            } else {
              // Si hay un error, muestra el AlertDialog
              return createAlert(context, message);
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
        future: _data(connection, user, pwd),
      ),
    );
  }
}
