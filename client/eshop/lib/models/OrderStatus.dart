class OrderCancelation {
  late bool success;

  OrderCancelation.fromJson(Map<String, dynamic> json) {
    success = json['success'];
  }
}
