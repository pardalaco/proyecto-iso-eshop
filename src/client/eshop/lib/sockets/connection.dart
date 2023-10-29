// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:io';
import 'dart:convert';

class Connection {
  late Socket client;
  late StreamSubscription<List<int>> subscription;
  late var datos;
  var debeEsperar = true;

  Connection();

  Future<void> logIn(Map<String, dynamic> js) async {
    client = await Socket.connect('localhost', 12345);
    final send = jsonEncode(js);
    client.write(send);
    subscription = client.listen((List<int> data1) {
      final jsonData = utf8.decode(data1);
      datos = json.decode(jsonData);
      debeEsperar = false;
    }, onDone: () {
      client.destroy();
    });
    while (debeEsperar) {
      await Future.delayed(Duration(milliseconds: 500));
    }
    debeEsperar = true;
    subscription.pause();
  }

  Future<void> query(Map<String, dynamic> js) async {
    final send = jsonEncode(js);
    client.write(send);
    subscription.resume();
    while (debeEsperar) {
      await Future.delayed(Duration(milliseconds: 500));
    }
    debeEsperar = true;
    subscription.pause();
  }

  Map<String, dynamic> getData() {
    return datos;
  }

  Future<void> closeConnection() async {
    client.close();
  }
}
