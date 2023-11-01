// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';
import 'package:eshop/jsons/contentJson.dart';

TypeJson typeFromJson(String str) => TypeJson.fromJson(json.decode(str));

String typeToJson(TypeJson data) => json.encode(data.toJson());

class TypeJson {
  int type;
  int code;
  Content content;

  TypeJson({
    required this.type,
    required this.code,
    required this.content,
  });

  factory TypeJson.fromJson(Map<String, dynamic> json) => TypeJson(
        type: json["type"],
        code: json["code"],
        content: Content.fromJson(json["content"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "code": code,
        "content": content.toJson(),
      };
}
