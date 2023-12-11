import 'package:flutter/material.dart';
import 'package:eshop/style/ColorsUsed.dart';
import 'package:eshop/sockets/connection.dart';
import 'package:eshop/models/Profile.dart';

class ChangePassword extends StatefulWidget {
  Connection connection;
  Profile profile;
  ChangePassword({
    Key? key,
    required this.connection,
    required this.profile,
  }) : super(key: key);

  @override
  State<ChangePassword> createState() =>
      _ChangePassword(connection: connection, profile: profile);
}

class _ChangePassword extends State<ChangePassword> {
  Connection connection;
  Profile profile;
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _hasChanges = false;

  _ChangePassword({
    required this.connection,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final _MyAppBar = AppBar(
      toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      backgroundColor: CustomColors.n1,
      centerTitle: true,
      title: Text(
        "Change Password",
        style: TextStyle(
          color: Colors.white,
          fontSize: MediaQuery.of(context).size.height * 0.05,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
          _handleBackNavigation(context);
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

    return Scaffold(
      appBar: _MyAppBar,
      body: Column(
        children: [
          const SizedBox(height: 16.0),
          _buildPasswordTextField(
            "Contraseña Actual",
            Icons.lock,
            _currentPasswordController,
            true,
          ),
          _buildPasswordTextField(
            "Nueva Contraseña",
            Icons.lock,
            _newPasswordController,
            true,
          ),
          _buildPasswordTextField(
            "Confirmar Nueva Contraseña",
            Icons.lock,
            _confirmNewPasswordController,
            true,
          ),
          const SizedBox(height: 16.0),
          _buildWarningText(),
        ],
      ),
    );
  }

  Widget _buildPasswordTextField(
    String labelText,
    IconData icon,
    TextEditingController controller,
    bool isRequired,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
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
        obscureText: true, // Para ocultar la contraseña
      ),
    );
  }

  Widget _buildWarningText() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: const Text(
        'Asegúrate de elegir una contraseña segura y mantenerla privada.',
        style: TextStyle(
          color: Colors.red,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  void _handleBackNavigation(BuildContext context) {
    if (_hasChanges) {
      // Mostrar un mensaje temporal en la parte inferior de la pantalla
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('La contraseña no ha sido cambiada.'),
        ),
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  Future<void> _saveChanges(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Lógica para guardar cambios en la contraseña
      // ...
    }
  }
}
