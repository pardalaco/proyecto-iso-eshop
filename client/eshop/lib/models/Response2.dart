import 'dart:convert';

class Response {
  bool error = false;
  late Map<String, dynamic> content;

  Response.fromJson(String jsonRaw) {
    Map<String, dynamic> data = json.decode(jsonRaw);
    if (data["type"] == 0) {
      error = true;
    }
    if (data["content"] != null) {
      content = data["content"];
    } else {
      content = {"success": false};
    }
  }
}
