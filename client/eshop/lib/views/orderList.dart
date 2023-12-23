import 'package:flutter/material.dart';
import 'package:eshop/models/Cart.dart';
import 'package:eshop/models/Response.dart';
import 'package:eshop/sockets/connection.dart';
import 'package:eshop/models/Profile.dart';
import 'package:eshop/style/ColorsUsed.dart';

class OrderList extends StatefulWidget {
  final Connection connection;
  final Profile profile;

  const OrderList({Key? key, required this.connection, required this.profile})
      : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: CustomColors.background,
        appBar: AppBar(
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
        ),
        body: FutureBuilder(
          future: widget.connection.getAllCarts(widget.profile.email),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              Response response = Response.fromJson(snapshot.data!);
              if (response.error) {
                return Center(
                  child: Text(
                    "Something went wrong",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              } else {
                Carts carts = Carts.fromJson(response.content);
                if (carts.carts.isEmpty) {
                  return Center(
                    child: Text(
                      "There aren't any orders",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: carts.carts.length,
                    itemBuilder: (context, index) {
                      Cart cart = carts.carts[index];
                      return ListTile(
                        title: Text(
                          cart.cartname,
                          style: TextStyle(fontSize: 25),
                        ),
                        subtitle: Text(
                          cart.total.toStringAsFixed(2) + " €",
                          style: TextStyle(fontSize: 20),
                        ),
                        onTap: () async {
                          // Implement your logic to navigate to the order details view
                        },
                      );
                    },
                  );
                }
              }
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(CustomColors.n1),
                ),
              );
            }
          },
        ),
      );
    });
  }
}
