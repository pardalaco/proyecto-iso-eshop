// To parse this JSON data, do
//
//     final welcome = loginSend(jsonString);

import 'dart:convert';

LoginRecipt loginSend(String str) => LoginRecipt.fromJson(json.decode(str));

String loginSendToJson(LoginRecipt data) => json.encode(data.toJson());

class LoginRecipt {
  int type;
  int code;
  ContentRecipt content;

  LoginRecipt({
    required this.type,
    required this.code,
    required this.content,
  });

  factory LoginRecipt.fromJson(Map<String, dynamic> json) => LoginRecipt(
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
  bool success;
  bool admin;

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
