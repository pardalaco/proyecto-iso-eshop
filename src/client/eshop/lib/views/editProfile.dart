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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cardController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _hasChanges = false;

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
        icon: const Icon(Icons.arrow_back),
        onPressed: () async {
          await _handleBackNavigation(context);
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.save),
          onPressed: () {
            _saveChanges(context);
          },
        ),
      ],
    );

    return WillPopScope(
      onWillPop: () async {
        return await _handleBackNavigation(context);
      },
      child: Scaffold(
        appBar: _MyAppBar,
        body: Form(
          key: _formKey,
          child: Column(
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
              _buildTextFieldWithIcon(
                  "Nombre", Icons.person, _nameController, true),
              _buildTextFieldWithIcon(
                  "Email", Icons.email, _emailController, true),
              _buildTextFieldWithIcon(
                  "Tarjeta", Icons.credit_card, _cardController, false),
              _buildTextFieldWithIcon(
                  "Dirección", Icons.location_on, _addressController, false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldWithIcon(String labelText, IconData icon,
      TextEditingController controller, bool isRequired) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          setState(() {
            _hasChanges = true;
          });
        },
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return 'Este campo es necesario';
          }
          return null;
        },
      ),
    );
  }

  Future<bool> _handleBackNavigation(BuildContext context) async {
    if (_hasChanges) {
      return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Descartar Cambios'),
            content: const Text('¿Seguro que quieres descartar los cambios?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Descartar cambios
                },
                child: const Text(
                  'Descartar',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Cancelar
                },
                child: const Text('Cancelar'),
              ),
            ],
          );
        },
      );
    }
    return true; // Si no hay cambios, permitir regresar
  }

  Future<void> _saveChanges(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (_nameController.text != profile.name ||
          _emailController.text != profile.email ||
          _cardController.text != profile.payment ||
          _addressController.text != profile.address) {
        profile.name = _nameController.text;
        profile.email = _emailController.text;
        profile.payment = _cardController.text;
        profile.address = _addressController.text;

        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Cambios Guardados'),
              content: const Text('Los cambios se han guardado correctamente.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );

        setState(() {
          _hasChanges = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No se realizaron cambios.'),
          ),
        );
      }
    }
  }
}
