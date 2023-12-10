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
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _cardController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  _EditProfile(
      {required this.connection, required this.admin, required this.profile}) {
    _nameController.text = profile.name;
    _emailController.text = profile.email;
    _cardController.text = profile.payment ?? '';
    _addressController.text = profile.address ?? '';
  }

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
          Navigator.of(context).pop();
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () {
            _saveChanges(context);
          },
        ),
      ],
    );

    return Scaffold(
      appBar: _MyAppBar,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              alignment: Alignment.center,
              child: ClipOval(
                child: Image.asset(
                  'assets/img/User.jpg',
                  width: 120.0,
                  height: 120.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          _buildTextFieldWithIcon("Nombre", Icons.person, _nameController),
          _buildTextFieldWithIcon("Email", Icons.email, _emailController),
          _buildTextFieldWithIcon(
              "Tarjeta", Icons.credit_card, _cardController),
          _buildTextFieldWithIcon(
              "Dirección", Icons.location_on, _addressController),
        ],
      ),
    );
  }

  Widget _buildTextFieldWithIcon(
      String labelText, IconData icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Future<void> _saveChanges(BuildContext context) async {
    // Verificar si ha habido cambios
    if (_nameController.text != profile.name ||
        _emailController.text != profile.email ||
        _cardController.text != profile.payment ||
        _addressController.text != profile.address) {
      // Guardar cambios
      profile.name = _nameController.text;
      profile.email = _emailController.text;
      profile.payment = _cardController.text;
      profile.address = _addressController.text;

      // Mostrar un mensaje informativo
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Los cambios se han guardado'),
      ));
    } else {
      // Si no hay cambios, mostrar un mensaje informativo
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No se realizaron cambios.'),
        ),
      );
    }
  }
}
