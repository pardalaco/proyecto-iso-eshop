import 'dart:async';
import 'dart:io';
import 'dart:convert';

class Connection {
  late Socket client;
  late StreamSubscription<List<int>> subscription;
  late var datos;
  var debeEsperar = true;
  var first = true;

  Future<void> _firstTime(Map<String, dynamic> js) async {
    client = await Socket.connect('10.0.2.2', 32768);
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
      await Future.delayed(const Duration(milliseconds: 500));
    }
    debeEsperar = true;
    subscription.pause();
  }

  Future<void> _otherTime(Map<String, dynamic> js) async {
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

  Future<void> query(Map<String, dynamic> js) async {
    if (first) {
      await _firstTime(js);
      first = false;
    } else {
      await _otherTime(js);
    }
  }

//Devolver json.encode() para poder recibirlo en el future: del futureBuilder
  Future<String> getComments() async {
    return json.encode({
      "amount": 1,
      "ratings": [
        {
          "email": "Pablo@gmail.com",
          "rating": 4.5,
          "comment": "Buen producto",
          "date": "ayer"
        },
        {
          "email": "Joan@gmail.com",
          "rating": 3.5,
          "comment": "Mal producto",
          "date": "ayer"
        }
      ]
    });
    //@todo Decir lo de la fecha
  }

//Devolver json.encode() para poder recibirlo en el future: del futureBuilder
  Future<String> getProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    return json.encode({
      "amount": 2,
      "products": [
        {
          "id": 1,
          "name": "iPhone 12",
          "description": "Movil que funciona de maravilla pero radioactivo",
          "image": "/imagenes/iPhone12",
          "price": 799.99,
          "rating": 5,
          "tags": "tecnologia"
        },
        {
          "id": 2,
          "name": "Air Jordan Zoom",
          "description": "Zapatillas para saltar mucho",
          "image": "/imagenes/Jordan",
          "price": 180,
          "rating": 4.5,
          "tags": "ropa"
        }
      ]
    });
    //@todo
  }

  Future<String> getTags() async {
    return json.encode({
      "tags": ["Tag 1", "Tag 2", "Tag 3", "Tag 4"]
    });
  }
}
