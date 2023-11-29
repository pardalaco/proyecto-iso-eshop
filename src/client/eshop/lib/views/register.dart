// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, camel_case_types, constant_identifier_names, sized_box_for_whitespace, use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:eshop/sockets/connection.dart';
import 'package:eshop/style/ColorsUsed.dart';
import 'home.dart';
import 'logIn.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _MyPage();
}

class _MyPage extends State<register> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.background,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: _MyBodyR(),
      ),
    );
  }
}

class _MyBodyR extends StatefulWidget {
  const _MyBodyR({Key? key}) : super(key: key);

  @override
  State<_MyBodyR> createState() => _MyFormR();
}

String? name;
String? email;
String? password;

class _MyFormR extends State<_MyBodyR> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        color: CustomColors.background,
        padding: EdgeInsetsDirectional.symmetric(
            horizontal: size.width * 0.05, vertical: size.height * 0.03),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          const Text(
            'Register',
            style: TextStyle(
                color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: size.height * 0.0275),
          Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Name',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.01),
              TextFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 3, color: CustomColors.n1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.n1),
                  ),
                  hintText: "Your name",
                  filled: true,
                  fillColor: CustomColors.n2,
                ),
                cursorColor: CustomColors.n1,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Required';
                  return null;
                },
                onSaved: (value) => name = value,
              ),
              SizedBox(height: size.height * 0.05),
              const Text(
                'Email',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.01),
              TextFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 3, color: CustomColors.n1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.n1),
                  ),
                  hintText: "Your email",
                  filled: true,
                  fillColor: CustomColors.n2,
                ),
                cursorColor: CustomColors.n1,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Required';
                  return null;
                },
                onSaved: (value) => email = value,
              ),
              SizedBox(height: size.height * 0.05),
              const Text(
                'Password',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.01),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 3, color: CustomColors.n1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.n1),
                  ),
                  hintText: "Your password",
                  filled: true,
                  fillColor: CustomColors.n2,
                ),
                cursorColor: CustomColors.n1,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Required';
                  return null;
                },
                onSaved: (value) => password = value,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              ElevatedButton(
                onPressed: () async {
                  final formState = _formKey.currentState;

                  if ((formState?.validate() ?? false)) {
                    formState!.save(); // Guarda valores en var. de estado
                    /*Connection connection = Connection();
                    await connection.query({
                      "type": 1,
                      "code": 2,
                      "content": {
                        "email": email,
                        "password": password,
                        "username": name,
                      }
                    });
                    var d = connection.getData();
                    if (d["code"] == 0 || d["content"]["success"] == false) {
                      showDialog(
                        context: context,
                        builder: (context) => _MyAlert(context),
                      );
                    } else {
                      //@todo pedir perfil
                      
                      showDialog(
                        context: context,
                        builder: (context) =>
                            Home(connection: connection, admin: false),
                      );
                    }*/
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Invalid form'),
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(CustomColors.n1),
                  fixedSize: MaterialStateProperty.all<Size>(
                      Size(size.width, size.height * 0.07)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                child: const Text(
                  'Create account',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              ListTile(
                title: const Text(
                  "Already have an acount? Log in",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                onTap: () {
                  _goToLogIn(context);
                },
              ),
            ]),
          ),
        ]));
  }
}

void _goToLogIn(BuildContext context) {
  var route = MaterialPageRoute(
    builder: (context) => const logIn(),
  );
  Navigator.of(context).push(route);
}

Widget _MyAlert(context) => AlertDialog(
        title: const Text("Error"),
        content: const Text(
          "Unsuccessful registration",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        actions: [
          Center(
            child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  "OK",
                  style: TextStyle(
                      color: CustomColors.n1,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                )),
          )
        ]);
