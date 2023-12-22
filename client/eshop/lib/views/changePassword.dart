import 'package:flutter/material.dart';
import 'package:eshop/style/ColorsUsed.dart';
import 'package:eshop/sockets/connection.dart';
import 'package:eshop/models/Profile.dart';
import 'package:eshop/models/Response.dart';

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
      backgroundColor: CustomColors.background,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            _buildPasswordTextField(
              "Current Password",
              Icons.lock,
              _currentPasswordController,
              true,
            ),
            _buildPasswordTextField(
              "New Password",
              Icons.lock,
              _newPasswordController,
              true,
            ),
            _buildPasswordTextField(
              "Confirm New Password",
              Icons.lock,
              _confirmNewPasswordController,
              true,
            ),
            const SizedBox(height: 16.0),
            _buildWarningText(),
          ],
        ),
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
          labelStyle: TextStyle(color: CustomColors.n1),
          prefixIcon: Icon(
            icon,
            color: CustomColors.n1,
          ),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: CustomColors.n1),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: CustomColors.n1),
          ),
          filled: true,
          fillColor: CustomColors.n2,
        ),
        cursorColor: CustomColors.n1,
        onChanged: (value) {
          setState(() {
            _hasChanges = true;
          });
        },
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return 'This field is required';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildWarningText() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: const Text(
        'Make sure to choose a secure password and keep it private.',
        style: TextStyle(
          color: Colors.red,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  void _handleBackNavigation(BuildContext context) {
    if (_hasChanges) {
      // Show a temporary message at the bottom of the screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password has not been changed.'),
        ),
      );
    }
  }

  Future<void> _saveChanges(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (_currentPasswordController.text.isEmpty ||
          _newPasswordController.text.isEmpty ||
          _confirmNewPasswordController.text.isEmpty) {
        // Show an error message if any field is empty
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill in all fields.'),
          ),
        );
      } else if (_currentPasswordController.text != profile.password) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Current password is incorrect.'),
          ),
        );
      } else if (_newPasswordController.text !=
          _confirmNewPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('New password and confirmation do not match.'),
          ),
        );
      } else if (_currentPasswordController.text ==
          _newPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('New password cannot be the same as the current one.'),
          ),
        );
      } else {
        // If all validations pass, update the password in the profile

        var data = await connection.editPassword(
            profile.email, _newPasswordController.text);
        Response response = Response.fromJson(data);

        // You can perform additional logic to save the password to your backend or wherever necessary.

        if (response.error) {
          // Show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error.'),
            ),
          );
        } else {
          profile.password = _newPasswordController.text;

          Navigator.of(context).pop();
          // Show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password changed successfully.'),
            ),
          );
        }
      }
    } else {
      // The form is not valid, meaning there are invalid fields
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please correct the invalid fields.'),
        ),
      );
    }
  }
}
