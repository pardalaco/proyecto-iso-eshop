import 'package:flutter/material.dart';
import 'package:eshop/models/user_model.dart';

class DrawerWidget extends StatelessWidget {
  final User user;
  const DrawerWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.name),
            accountEmail: Text(user.phone),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/img/profile.png'),
            ),
          ),
          ListTile(
            title: const Text('Reservas'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const FutureReservas()),
              // );
            },
          ),
          const Spacer(),
          Container(
            color: Colors.black,
            child: ListTile(
              title: const Center(
                child: Text(
                  'Sing out',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: () {
                Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName));
              },
            ),
          ),
        ],
      ),
    );
  }
}
