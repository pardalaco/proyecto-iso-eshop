class DetailsOrder {
  late bool success;
  late int orderid;
  late String email;
  late String address;
  late String payment;
  late String date;
  late double total;
  late String status;

  DetailsOrder.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (success == true) {
      orderid = json['orderid'];
      email = json['email'];
      address = json['address'];
      payment = json['payment'];
      date = json['date'];
      total = json['total'].toDouble();
      status = json['status'];
    }
  }
}
