class Orders {
  late List<Order> orders;

  Orders.fromJson(Map<String, dynamic> json) {
    orders = <Order>[];
    var orderList = json['orders'] as List;
    orderList.forEach((orderData) {
      orders.add(Order.fromJson(orderData));
    });
  }
}

class Order {
  late int orderid;
  late String date;
  late double total;
  late String status;

  Order.fromJson(Map<String, dynamic> json) {
    orderid = json['orderid'];
    date = json['date'];
    total = json['total'].toDouble();
    status = json['status'];
  }
}
