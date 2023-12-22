import 'package:eshop/models/Response.dart';
import 'package:flutter/material.dart';
import 'package:eshop/style/ColorsUsed.dart';
import 'package:eshop/sockets/connection.dart';
import 'package:eshop/models/Profile.dart';
import 'package:eshop/views/changePassword.dart';

class EditProfile extends StatefulWidget {
  Connection connection;
  Profile profile;
  EditProfile({Key? key, required this.connection, required this.profile})
      : super(key: key);

  @override
  State<EditProfile> createState() =>
      _EditProfile(connection: connection, profile: profile);
}

class _EditProfile extends State<EditProfile> {
  Connection connection;
  Profile profile;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cardController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _hasChanges = false;

  _EditProfile({required this.connection, required this.profile}) {
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
        backgroundColor: CustomColors.background,
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
              const SizedBox(height: 16.0),
              _buildTextFieldWithIcon(
                  "Name", Icons.person, _nameController, true),
              _buildTextFieldWithIcon(
                  "Email", Icons.email, _emailController, true),
              _buildTextFieldWithIcon(
                  "Card", Icons.credit_card, _cardController, false),
              _buildTextFieldWithIcon(
                  "Address", Icons.location_on, _addressController, false),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChangePassword(
                          connection: connection,
                          profile: profile,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.n1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Change Password",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
              ),
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

  Future<bool> _handleBackNavigation(BuildContext context) async {
    if (_hasChanges) {
      return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Discard Changes'),
            content:
                const Text('Are you sure you want to discard the changes?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text(
                  'Discard',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Cancel
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.of(context).pop(true);
      return true;
    }
  }

  Future<void> _saveChanges(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (_hasChanges) {
        var content = <String, dynamic>{};

        if (_nameController.text != profile.name) {
          content["name"] = _nameController.text;
        }

        if (_emailController.text != profile.email) {
          content["email"] = _emailController.text;
        }

        if (_cardController.text != profile.payment) {
          content["payment"] = _cardController.text;
        }

        if (_addressController.text != profile.address) {
          content["address"] = _addressController.text;
        }

        var data = await connection.dynamicUserInfoEdit(profile.email, content);
        Response response = Response.fromJson(data);

        if (response.error) {
          // Show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error.'),
            ),
          );
        } else {
          profile.name = _nameController.text;
          profile.email = _emailController.text;
          profile.payment = _cardController.text;
          profile.address = _addressController.text;

          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Changes Saved'),
                content:
                    const Text('The changes have been saved successfully.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
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
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No changes were made.'),
          ),
        );
      }
    }
  }
}
