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
          backgroundColor: CustomColors.background,
          appBar: SimpleAppBar(constraints, "Order Details"),
          body: buildOrderDetails(),
          bottomNavigationBar: _buildCancelButton(),
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
              child: Card(
                color: CustomColors.n2,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Order ID', order.orderid.toString()),
                      _buildDetailRow('Email', order.email),
                      _buildDetailRow('Address', order.address),
                      _buildDetailRow('Payment', order.payment),
                      _buildDetailRow('Date', order.date),
                      _buildDetailRow(
                          'Total', '${order.total.toStringAsFixed(2)} €'),
                      _buildDetailRow('Status', order.status),
                      _buildDetailRow('Success', order.success.toString()),
                    ],
                  ),
                ),
              ),
            );
          }
        } else {
          return MyLoadingWidget();
        }
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Material(
      color:
          CustomColors.n2, // Puedes ajustar este color según tus preferencias
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors
                    .white, // Puedes ajustar este color según tus preferencias
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors
                    .white, // Puedes ajustar este color según tus preferencias
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCancelButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          // Aquí puedes agregar la lógica para cancelar la orden
          // Puedes mostrar un diálogo de confirmación, realizar la cancelación, etc.
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
          padding: EdgeInsets.symmetric(vertical: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Cancel Order',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
