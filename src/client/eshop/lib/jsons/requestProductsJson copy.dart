// To parse this JSON data, do
//
//     final welcome = requestProductsRecipt(jsonString);

import 'dart:convert';

RequestProductsRecipt requestProductsRecipt(String str) =>
    RequestProductsRecipt.fromJson(json.decode(str));

String requestProductsReciptToJson(RequestProductsRecipt data) =>
    json.encode(data.toJson());

class RequestProductsRecipt {
  int type;
  int code;
  String content;

  RequestProductsRecipt({
    required this.type,
    required this.code,
    required this.content,
  });

  factory RequestProductsRecipt.fromJson(Map<String, dynamic> json) =>
      RequestProductsRecipt(
          type: json["type"], code: json["code"], content: json["content"]);

  Map<String, dynamic> toJson() => {
        "type": type,
        "code": code,
        "content": content,
      };
}
