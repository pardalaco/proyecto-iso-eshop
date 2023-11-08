// To parse this JSON data, do
//
//     final welcome = singUpSend(jsonString);

import 'dart:convert';

SingUpSend singUpSend(String str) => SingUpSend.fromJson(json.decode(str));

String loginSendToJson(SingUpSend data) => json.encode(data.toJson());

class SingUpSend {
  int type;
  int code;
  ContentSend content;

  SingUpSend({
    required this.type,
    required this.code,
    required this.content,
  });

  factory SingUpSend.fromJson(Map<String, dynamic> json) => SingUpSend(
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
  String username;
  String email;
  String password;

  ContentSend({
    required this.username,
    required this.email,
    required this.password,
  });

  factory ContentSend.fromJson(Map<String, dynamic> json) => ContentSend(
        username: json["username"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
      };
}
