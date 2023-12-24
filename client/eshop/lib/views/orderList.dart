import 'package:flutter/material.dart';
import 'package:eshop/models/Order.dart';
import 'package:eshop/models/Response.dart';
import 'package:eshop/sockets/connection.dart';
import 'package:eshop/models/Profile.dart';
import 'package:eshop/style/ColorsUsed.dart';
import 'package:eshop/utils/MyWidgets.dart';
import 'package:eshop/views/orderDetails.dart';

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
        appBar: SimpleAppBar(constraints, "Order List"),
        body: buildOrderListBody(),
        floatingActionButton: widget.admin ? buildSearchButton() : null,
      );
    });
  }

  Widget buildOrderListBody() {
    return FutureBuilder(
      future: widget.connection.requestOrders(widget.profile.email),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          Response response = Response.fromJson(snapshot.data!);
          if (response.error) {
            return MyErrorWidget("Something went wrong");
          } else {
            Orders orders = Orders.fromJson(response.content);
            if (orders.orders.isEmpty) {
              return MyErrorWidget("There aren't any orders");
            } else {
              return buildOrderListView(orders);
            }
          }
        } else {
          return MyLoadingWidget();
        }
      },
    );
  }

  Widget buildOrderListView(Orders orders) {
    return ListView.separated(
      padding: const EdgeInsets.all(5.0),
      itemCount: orders.orders.length,
      itemBuilder: (context, index) {
        Order order = orders.orders[index];
        return ListTile(
          title: Text(
            "ID order: ${order.orderid}",
            style: const TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            order.total.toStringAsFixed(2) + " €",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          onTap: () async {
            // Implementa tu lógica para navegar a la vista de detalles de la orden
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderDetails(
                    connection: widget.connection,
                    profile: widget.profile,
                    order: order),
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(
        thickness: 2,
        color: Colors.white,
      ),
    );
  }

  FloatingActionButton buildSearchButton() {
    return FloatingActionButton(
      onPressed: () async {
        //await showSearchOrder();
        //-------------
        showChangeOrderState(1);
      },
      backgroundColor: CustomColors.n1,
      child: const Icon(Icons.search, color: Colors.white),
    );
  }

  Future<void> showSearchOrder() async {
    TextEditingController searchController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Search Order"),
          content: TextField(
            controller: searchController,
            decoration: const InputDecoration(labelText: "Enter the order ID"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                showChangeOrderState(1);
              },
              child: const Text("Search"),
            ),
          ],
        );
      },
    );
  }

  Future<void> showChangeOrderState(int orderId) async {
    String selectedOption = '';
    int sendOption;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text("Cambiar estado del pedido $orderId"),
          children: [
            ListTile(
              title: const Text('Invoiced'),
              onTap: () {
                setState(() {
                  selectedOption = 'Invoiced';
                  sendOption = 0;
                });
                Navigator.of(context).pop();
                showSnackBar(orderId, selectedOption);
              },
            ),
            ListTile(
              title: const Text('Prepared'),
              onTap: () {
                setState(() {
                  selectedOption = 'Prepared';
                  sendOption = 1;
                });
                Navigator.of(context).pop();
                showSnackBar(orderId, selectedOption);
              },
            ),
            ListTile(
              title: const Text('Shipped'),
              onTap: () {
                setState(() {
                  selectedOption = 'Shipped';
                  sendOption = 2;
                });
                Navigator.of(context).pop();
                showSnackBar(orderId, selectedOption);
              },
            ),
            ListTile(
              title: const Text('Out for Delivery'),
              onTap: () {
                setState(() {
                  selectedOption = 'Out for Delivery';
                  sendOption = 3;
                });
                Navigator.of(context).pop();
                showSnackBar(orderId, selectedOption);
              },
            ),
            ListTile(
              title: const Text('Delivered'),
              onTap: () {
                setState(() {
                  selectedOption = 'Delivered';
                  sendOption = 4;
                });
                Navigator.of(context).pop();
                showSnackBar(orderId, selectedOption);
              },
            ),
            ListTile(
              title: const Text('Cancelled'),
              onTap: () {
                setState(() {
                  selectedOption = 'Cancelled';
                  sendOption = 5;
                });
                Navigator.of(context).pop();
                showSnackBar(orderId, selectedOption);
              },
            ),
          ],
        );
      },
    );
  }

  void showSnackBar(int orderId, String selectedOption) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('El pedido $orderId ha cambiado a $selectedOption'),
      ),
    );
  }
}
