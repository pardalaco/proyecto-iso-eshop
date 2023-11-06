// To parse this JSON data, do
//
//     final welcome = loginSend(jsonString);

import 'dart:convert';

TypeSend loginSend(String str) => TypeSend.fromJson(json.decode(str));

String loginSendToJson(TypeSend data) => json.encode(data.toJson());

class TypeSend {
  int type;
  int code;
  ContentSend content;

  TypeSend({
    required this.type,
    required this.code,
    required this.content,
  });

  factory TypeSend.fromJson(Map<String, dynamic> json) => TypeSend(
        type: json["type"],
        code: json["code"],
        content: ContentSend.fromJson(json["content"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "code": code,
        "content": content.toJson(),
      };
}

class ContentSend {
  String email;
  String password;

  ContentSend({
    required this.email,
    required this.password,
  });

  factory ContentSend.fromJson(Map<String, dynamic> json) => ContentSend(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}

class ContentRecipt {
  String success;
  String admin;

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
