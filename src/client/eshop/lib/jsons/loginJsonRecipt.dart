// To parse this JSON data, do
//
//     final welcome = loginSend(jsonString);

import 'dart:convert';

TypeRecipt loginSend(String str) => TypeRecipt.fromJson(json.decode(str));

String loginSendToJson(TypeRecipt data) => json.encode(data.toJson());

class TypeRecipt {
  int type;
  int code;
  ContentRecipt content;

  TypeRecipt({
    required this.type,
    required this.code,
    required this.content,
  });

  factory TypeRecipt.fromJson(Map<String, dynamic> json) => TypeRecipt(
        type: json["type"],
        code: json["code"],
        content: ContentRecipt.fromJson(json["content"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "code": code,
        "content": content.toJson(),
      };
}

class ContentRecipt {
  int success;
  int admin;

  ContentRecipt({
    required this.success,
    required this.admin,
  });

  factory ContentRecipt.fromJson(Map<String, dynamic> json) => ContentRecipt(
        success: json["success"],
        admin: json["admin"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "admin": admin,
      };
}
