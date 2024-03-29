// ignore_for_file: use_build_context_synchronously

import 'package:eshop/models/DetailsOrder.dart';
import 'package:eshop/views/home.dart';
import 'package:flutter/material.dart';

import 'package:eshop/sockets/connection.dart';

import 'package:eshop/models/Order.dart';
import 'package:eshop/models/Response2.dart';
import 'package:eshop/models/Profile.dart';
import 'package:eshop/models/OrderCancelation.dart';

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
        body: widget.admin ? buildOrderListAdmin() : buildOrderListBody(),
        floatingActionButton: widget.admin ? buildSearchButton() : null,
      );
    });
  }

  // Lista de ordenes del usuario / consulta de ordenes de usuario
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

  // Lista de ordenes del Administrador / consulta de ordenes de administrador
  Widget buildOrderListAdmin() {
    return FutureBuilder(
      future: widget.connection.listAllOrders(widget.profile.email),
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

  // Pinta todas las ordenes en pantalla
  Widget buildOrderListView(Orders orders) {
    return ListView.separated(
      padding: const EdgeInsets.all(5.0),
      itemCount: orders.orders.length,
      itemBuilder: (context, index) {
        Order order = orders.orders[index];
        return ListTile(
          title: Text(
            "Pedido #${order.orderid}",
            style: const TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total:",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${order.total.toStringAsFixed(2)} €",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Estado:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    order.status,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          onTap: () async {
            // Implementa tu lógica para navegar según el modo (admin / no admin)
            if (!adminMode) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderDetails(
                    connection: widget.connection,
                    email: widget.profile.email,
                    order: order,
                  ),
                ),
              );
            } else {
              var dataQuery = await widget.connection
                  .requestOrderDetails(widget.profile.email, order.orderid);

              Response response = Response.fromJson(dataQuery);
              if (response.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Error'),
                  ),
                );
              } else {
                DetailsOrder orderState =
                    DetailsOrder.fromJson(response.content);
                if (orderState.success) {
                  showChangeOrderState(orderState);
                } else {
                  showOrderNotSuccess(orderState.orderid);
                }
              }
            }
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(
        thickness: 2,
        color: Colors.white,
      ),
    );
  }

  // Bóton de busqueda del administrador
  FloatingActionButton buildSearchButton() {
    return FloatingActionButton(
      onPressed: () async {
        await showSearchOrder();
      },
      backgroundColor: CustomColors.n1,
      child: const Icon(Icons.search, color: Colors.white),
    );
  }

  // Pop up de busqueda de la order
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
            keyboardType: TextInputType
                .number, // Configura el teclado para aceptar solo números
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                // Implementar función del servidor
                var dataQuery = await widget.connection.requestOrderDetails(
                    widget.profile.email, int.parse(searchController.text));
                Response response = Response.fromJson(dataQuery);
                if (response.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error'),
                    ),
                  );
                } else {
                  DetailsOrder order = DetailsOrder.fromJson(response.content);
                  if (order.success) {
                    showChangeOrderState(order);
                  } else {
                    showOrderNotSuccess(int.parse(searchController.text));
                  }
                }
              },
              child: const Text("Search"),
            ),
          ],
        );
      },
    );
  }

  // Aviso de order not found
  Future<void> showOrderNotSuccess(int orderID) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Order Not Found"),
          content: Text("The order with ID ${orderID} was not found."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // Pop up de cambiar estado de la orden
  Future<void> showChangeOrderState(DetailsOrder order) async {
    String selectedOption = '';
    int state = 0;

    ListTile _buildListTile(String title, int option) {
      return ListTile(
        title: Text(title),
        onTap: () async {
          selectedOption = title;
          state = option;

          Navigator.of(context).pop();

          var dataOrderState = await widget.connection
              .changeOrderStatus(widget.profile.email, order.orderid, state);
          Response responseOrderState = Response.fromJson(dataOrderState);

          if (responseOrderState.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error'),
              ),
            );
          } else {
            OrderCancelation orderCancelation =
                OrderCancelation.fromJson(responseOrderState.content);

            if (orderCancelation.success) {
              order.status = selectedOption;
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => OrderList(
                      connection: widget.connection,
                      profile: widget.profile,
                      admin: widget.admin),
                ),
              );

              showSnackBar(order.orderid, selectedOption);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Error'),
                ),
              );
            }
          }
        },
      );
    }

    List<ListTile> buildDialogOptions() {
      return [
        _buildListTile('Invoiced', 0),
        _buildListTile('Prepared', 1),
        _buildListTile('Shipped', 2),
        _buildListTile('Out for Delivery', 3),
        _buildListTile('Delivered', 4),
        _buildListTile('Cancelled', 5),
      ];
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text("Change status to ${order.orderid} id"),
          children: buildDialogOptions(),
        );
      },
    );
  }

  // Mensaje de avido de que la orden ya ha sido cambiada
  void showSnackBar(int order, String selectedOption) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('The order $order id has changed status to $selectedOption'),
      ),
    );
  }
}
