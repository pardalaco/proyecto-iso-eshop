import 'package:flutter/material.dart';

// Json
import 'package:eshop/jsons/requestProductsJsonSend.dart';
import 'package:eshop/jsons/requestProductsJsonReturn.dart';

// Conexion
import 'package:eshop/sockets/connection.dart';

Future<String> _data(Connection connection) async {
  RequestProductsSend data = RequestProductsSend(type: 2, code: 1, content: {});

  //print(data.toJson().toString());

  print("---> ENVIADO: " + data.toJson().toString());
  await connection.query(data.toJson());

  // Recipt data from the server
  var dataRecipt = connection.getData();
  print("<--- RECIBIDO: " + dataRecipt.toString());

  RequestProductsRecipt dataReturn = RequestProductsRecipt.fromJson(dataRecipt);

  // Create a List with the boolean and the string

  return dataReturn.content.toString();
}

class FutureJson extends StatelessWidget {
  Connection connection;

  FutureJson({super.key, required this.connection});

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
      future: _data(connection),
    ));
  }
}
