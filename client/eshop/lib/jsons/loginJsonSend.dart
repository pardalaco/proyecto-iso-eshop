// To parse this JSON data, do
//
//     final welcome = loginSend(jsonString);

import 'dart:convert';

LoginSend loginSend(String str) => LoginSend.fromJson(json.decode(str));

String loginSendToJson(LoginSend data) => json.encode(data.toJson());

class LoginSend {
  int type;
  int code;
  ContentSend content;

  LoginSend({
    required this.type,
    required this.code,
    required this.content,
  });

  factory LoginSend.fromJson(Map<String, dynamic> json) => LoginSend(
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
