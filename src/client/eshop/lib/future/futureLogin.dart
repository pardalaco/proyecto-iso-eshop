// Connection
import 'package:eshop/sockets/connection.dart';

// Jsons
import 'package:eshop/jsons/typeJson.dart';
import 'package:eshop/jsons/contentJson.dart';
import 'package:eshop/jsons/loginJson.dart';

class ConnectionLogin {
  Connection connection;
  String email, password;

  ConnectionLogin(
      {required this.connection, required this.email, required this.password}) {
    // Sending data to the server
    Content content = jsonLoginSend(email: email, password: password);
    TypeJson data = TypeJson(type: 1, code: 1, content: content);
    connection.query(data.toJson());

    // Recipt data to the server
    var json = connection.getData();

    TypeJson j = TypeJson.fromJson(json);
  }
}
