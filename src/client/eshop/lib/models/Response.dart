class Response {
  bool error = false;
  late Map<String, dynamic> content;

  Response.fromJson(Map<String, dynamic> json) {
    if (json["type"] == 0) {
      error = true;
    }
    content = json["content"];
  }
}
