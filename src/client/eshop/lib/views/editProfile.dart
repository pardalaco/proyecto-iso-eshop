import 'package:flutter/material.dart';
import 'package:eshop/style/ColorsUsed.dart';
import 'package:eshop/sockets/connection.dart';
import 'package:eshop/models/Profile.dart';

class EditProfile extends StatefulWidget {
  Connection connection;
  bool admin;
  Profile profile;
  EditProfile(
      {Key? key,
      required this.connection,
      required this.admin,
      required this.profile})
      : super(key: key);

  @override
  State<EditProfile> createState() =>
      _EditProfile(connection: connection, admin: admin, profile: profile);
}

class _EditProfile extends State<EditProfile> {
  Connection connection;
  bool admin;
  Profile profile;
  _EditProfile(
      {required this.connection, required this.admin, required this.profile});

  @override
  Widget build(BuildContext context) {
    final _MyAppBar = AppBar(
      toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      backgroundColor: CustomColors.n1,
      centerTitle: true,
      title: Text(
        "Edit Profile",
        style: TextStyle(
          color: Colors.white,
          fontSize: MediaQuery.of(context).size.height * 0.05,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          // Agrega aquí la lógica para volver a la pestaña anterior
          Navigator.of(context).pop();
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () {
            // Agrega aquí la lógica para guardar los cambios
          },
        ),
      ],
    );

    return Scaffold(appBar: _MyAppBar, body: Text("hola"));
  }
}
