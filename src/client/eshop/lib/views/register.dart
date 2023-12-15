// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, camel_case_types, constant_identifier_names, sized_box_for_whitespace, use_build_context_synchronously, non_constant_identifier_names

import 'package:eshop/models/Response.dart';
import 'package:eshop/utils/MyWidgets.dart';
import 'package:flutter/material.dart';
import 'package:eshop/sockets/connection.dart';
import 'package:eshop/style/ColorsUsed.dart';
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

class _MyFormR extends State<_MyBodyR> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? email;
  String? password;
  String? password2;
  bool mostrarContrasenya = false;

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
              SizedBox(height: size.height * 0.025),
              const Text(
                'Password',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.01),
              TextFormField(
                obscureText: !mostrarContrasenya,
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
              SizedBox(height: size.height * 0.025),
              const Text(
                'Confirm password',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.01),
              TextFormField(
                obscureText: !mostrarContrasenya,
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
                onSaved: (value) => password2 = value,
              ),
              Row(
                children: [
                  Checkbox(
                    value: mostrarContrasenya,
                    activeColor: CustomColors.n1,
                    side: BorderSide(color: Colors.white),
                    onChanged: (value) {
                      setState(() {
                        mostrarContrasenya = value!;
                      });
                    },
                  ),
                  Text(
                    'Show password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              ElevatedButton(
                onPressed: () async {
                  final formState = _formKey.currentState;

                  if ((formState?.validate() ?? false)) {
                    formState!.save(); // Guarda valores en var. de estado
                    if (password != password2) {
                      showDialog(
                        context: context,
                        builder: (context) => MyPopUp(
                            context, "Error", "Passwords don't match", 1),
                      );
                    } else {
                      Connection connection = Connection();
                      var data = await connection.signUp(email!, password!);
                      Response response = Response.fromJson(data);
                      if (response.error) {
                        showDialog(
                          context: context,
                          builder: (context) => MyPopUp(
                              context, "Error", response.content["details"], 1),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => MyPopUp(context, "Message",
                              "Successful resgistration", 2),
                        );
                      }
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Invalid form',
                          style: TextStyle(fontSize: 20),
                        ),
                        backgroundColor: CustomColors.n1,
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
