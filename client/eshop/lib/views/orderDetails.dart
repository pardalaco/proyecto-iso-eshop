import 'package:eshop/sockets/connection.dart';
import 'package:flutter/material.dart';

import 'package:eshop/models/Order.dart';
import 'package:eshop/models/DetailsOrder.dart';
import 'package:eshop/models/Response.dart';
import 'package:eshop/models/Profile.dart';

import 'package:eshop/style/ColorsUsed.dart';

import 'package:eshop/utils/MyWidgets.dart';

class OrderDetails extends StatefulWidget {
  final Connection connection;
  final Profile profile;
  final Order order;

  const OrderDetails(
      {Key? key,
      required this.connection,
      required this.profile,
      required this.order})
      : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: SimpleAppBar(constraints, "Order Details"),
          body: buildOrderDetails(),
        );
      },
    );
  }

  Widget buildOrderDetails() {
    return FutureBuilder(
      future: widget.connection
          .requestOrderDetails(widget.profile.email, widget.order.orderid),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          Response response = Response.fromJson(snapshot.data!);
          if (response.error) {
            return MyErrorWidget("Something went wrong");
          } else {
            DetailsOrder order = DetailsOrder.fromJson(response.content);
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order ID: ${order.orderid}'),
                  Text('Email: ${order.email}'),
                  Text('Address: ${order.address}'),
                  Text('Payment: ${order.payment}'),
                  Text('Date: ${order.date}'),
                  Text('Total: ${order.total.toStringAsFixed(2)} €'),
                  Text('Status: ${order.status}'),
                  Text('Success: ${order.success}'),
                ],
              ),
            );
          }
        } else {
          return MyLoadingWidget();
        }
      },
    );
  }
}
