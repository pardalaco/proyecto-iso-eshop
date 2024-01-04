class UserInfoEdit {
  late bool success;

  UserInfoEdit.fromJson(Map<String, dynamic> json) {
    success = json['success'];
  }
}
