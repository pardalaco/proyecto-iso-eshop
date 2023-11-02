import 'package:eshop/jsons/contentJson.dart';

class jsonLoginSend extends Content {
  String email;
  String password;

  jsonLoginSend({
    required this.email,
    required this.password,
  });

  factory jsonLoginSend.fromJson(Map<String, dynamic> json) => jsonLoginSend(
        email: json["email"],
        password: json["password"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}

class jsonLoginReceive extends Content {
  int success;
  int admin;

  jsonLoginReceive({
    required this.success,
    required this.admin,
  });

  factory jsonLoginReceive.fromJson(Map<String, dynamic> json) =>
      jsonLoginReceive(
        success: json["success"],
        admin: json["admin"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "email": success,
        "password": admin,
      };
}
