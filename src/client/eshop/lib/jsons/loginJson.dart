import 'package:eshop/jsons/contentJson.dart';

class jsonLogin extends Content {
  String email;
  String password;

  jsonLogin({
    required this.email,
    required this.password,
  });

  factory jsonLogin.fromJson(Map<String, dynamic> json) => jsonLogin(
        email: json["email"],
        password: json["password"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
