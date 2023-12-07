// To parse this JSON data, do
//
//     final welcome = singUpRecipt(jsonString);

import 'dart:convert';

SingUpRecipt singUpRecipt(String str) =>
    SingUpRecipt.fromJson(json.decode(str));

String loginSendToJson(SingUpRecipt data) => json.encode(data.toJson());

class SingUpRecipt {
  int type;
  int code;
  ContentRecipt content;

  SingUpRecipt({
    required this.type,
    required this.code,
    required this.content,
  });

  factory SingUpRecipt.fromJson(Map<String, dynamic> json) => SingUpRecipt(
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

  ContentRecipt({
    required this.success,
  });

  factory ContentRecipt.fromJson(Map<String, dynamic> json) => ContentRecipt(
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
      };
}
