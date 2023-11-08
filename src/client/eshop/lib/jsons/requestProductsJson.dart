// To parse this JSON data, do
//
//     final welcome = requestProductsSend(jsonString);

import 'dart:convert';

RequestProductsSend requestProductsSend(String str) =>
    RequestProductsSend.fromJson(json.decode(str));

String requestProductsSendToJson(RequestProductsSend data) => json.encode(data.toJson());

class RequestProductsSend {
  int type;
  int code;
  int content;

  RequestProductsSend({
    required this.type,
    required this.code,
    required this.content,
  });

  factory RequestProductsSend.fromJson(Map<String, dynamic> json) => RequestProductsSend(
      type: json["type"], code: json["code"], content: json["content"]);

  Map<String, dynamic> toJson() => {
        "type": type,
        "code": code,
        "content": content,
      };
}
