import 'package:flutter/material.dart';
import 'package:eshop/models/Order.dart';
import 'package:eshop/models/Response.dart';
import 'package:eshop/sockets/connection.dart';
import 'package:eshop/models/Profile.dart';
import 'package:eshop/style/ColorsUsed.dart';
import 'package:eshop/utils/MyWidgets.dart';

class OrderList extends StatefulWidget {
  final Connection connection;
  final Profile profile;
  final bool admin;

  const OrderList({
    Key? key,
    required this.connection,
    required this.profile,
    required this.admin,
  }) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: CustomColors.background,
        appBar: buildAppBar(constraints),
        body: buildOrderListBody(),
        floatingActionButton: widget.admin ? buildSearchButton() : null,
      );
    });
  }

  AppBar buildAppBar(BoxConstraints constraints) {
    return AppBar(
      toolbarHeight: constraints.maxHeight * 0.1,
      backgroundColor: CustomColors.n1,
      centerTitle: true,
      title: Text(
        "Order List",
        style: TextStyle(
          color: Colors.white,
          fontSize: constraints.maxHeight * 0.05,
        ),
      ),
    );
  }

  Widget buildOrderListBody() {
    return FutureBuilder(
      future: widget.connection.requestOrders(widget.profile.email),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          Response response = Response.fromJson(snapshot.data!);
          if (response.error) {
            return buildErrorWidget("Something went wrong");
          } else {
            Orders orders = Orders.fromJson(response.content);
            if (orders.orders.isEmpty) {
              return buildErrorWidget("There aren't any orders");
            } else {
              return buildOrderListView(orders);
            }
          }
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget buildOrderListView(Orders orders) {
    return ListView.builder(
      itemCount: orders.orders.length,
      itemBuilder: (context, index) {
        Order order = orders.orders[index];
        return ListTile(
          title: Text(
            order.orderid.toString(),
            style: const TextStyle(
              fontSize: 25,
              color: Colors.white, // Agregar el color aquí
            ),
          ),
          subtitle: Text(
            order.total.toStringAsFixed(2) + " €",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white, // Agregar el color aquí
            ),
          ),
          onTap: () async {
            // Implementa tu lógica para navegar a la vista de detalles de la orden
          },
        );
      },
    );
  }

  Widget buildErrorWidget(String errorMessage) {
    return Center(
      child: Text(
        errorMessage,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(CustomColors.n1),
      ),
    );
  }

  FloatingActionButton buildSearchButton() {
    return FloatingActionButton(
      onPressed: () async {
        // Aquí implementa la lógica para el botón
      },
      backgroundColor: CustomColors.n1,
      child: const Icon(Icons.search, color: Colors.white),
    );
  }
}
