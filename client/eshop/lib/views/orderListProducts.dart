// ignore_for_file: use_build_context_synchronously

import 'package:eshop/sockets/connection.dart';
import 'package:flutter/material.dart';

import 'package:eshop/models/OrderListProducts.dart';
import 'package:eshop/models/Response.dart';

import 'package:eshop/style/ColorsUsed.dart';

import 'package:eshop/utils/MyWidgets.dart';

class OrderListProductsView extends StatefulWidget {
  final Connection connection;
  final String email;
  final int idOrder;

  const OrderListProductsView(
      {Key? key,
      required this.connection,
      required this.email,
      required this.idOrder})
      : super(key: key);

  @override
  _OrderListProductsViewState createState() => _OrderListProductsViewState();
}

class _OrderListProductsViewState extends State<OrderListProductsView> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: CustomColors.background,
          appBar: SimpleAppBar(
              constraints, "Order #${widget.idOrder} List products"),
          body: buildListProducts(),
        );
      },
    );
  }

  Widget buildListProducts() {
    return FutureBuilder(
      future:
          widget.connection.requestOrderProducts(widget.email, widget.idOrder),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          Response response =  Response.fromJson(snapshot.data!);
          if (response.error) {
            return MyErrorWidget("Something went wrong");
          } else {
            OrderListProducts orderList =
                OrderListProducts.fromJson(response.content);
            if (orderList.success) {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: orderList.products.length,
                separatorBuilder: (context, index) => const Divider(
                  thickness: 1,
                  color: Colors.white,
                ),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      orderList.products[index].name,
                      style: const TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      "x${orderList.products[index].quantity}",
                      style: const TextStyle(fontSize: 15),
                    ),
                    textColor: Colors.white,
                    trailing: Text(
                      orderList.products[index].price.toStringAsFixed(2) + " €",
                      style: const TextStyle(fontSize: 15),
                    ),
                  );
                },
              );
            } else {
              return const Text("Error");
            }
          }
        } else {
          return MyLoadingWidget();
        }
      },
    );
  }
}
