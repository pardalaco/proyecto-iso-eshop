import 'package:eshop/jsons/typeJson.dart';
import 'package:eshop/jsons/contentJson.dart';
import 'package:eshop/jsons/loginJson.dart';

import 'package:eshop/signUpPage.dart';
import 'package:flutter/material.dart';
import 'package:eshop/products_list_view.dart';
import 'package:eshop/models/user_model.dart';

//import 'first_page/container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final TextEditingController _usernameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final bool login = true;

final Content c = jsonLogin(
    email: _usernameController.toString(),
    password: _passwordController.toString());

final TypeJson datal = TypeJson(type: 1, code: 1, content: c);

bool _showPassword =
    false; // Variable to track whether the password should be shown or hidden.

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          //color: Colors.blue,
          child: Column(children: [
            Container(
                width: double.infinity,
                height: 120,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 5),
                //color: Colors.amber,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Eshop",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Image.asset(
                        'assets/img/logo.png',
                        //width: 30,
                      ),
                    ])),
            _LoginBox(),
            const SizedBox(height: 20),
            _singUpTag(),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (login) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProductsPage()),
                        );
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => createAlert(
                                  context,
                                ));
                      }
                    }
                  },
                  child: _loginButton(),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }

  _shadow() {
    return const BoxShadow(
      color: Color.fromARGB(69, 39, 39, 39),
      spreadRadius: 5,
      blurRadius: 7,
      offset: Offset(-5, 5),
    );
  }

  // ignore: non_constant_identifier_names
  _LoginBox() {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 70),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [_shadow()],
        color: Colors.white,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Input your nametag';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                ),
                obscureText: !_showPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Input your password';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 10, bottom: 10),
              child: Row(
                children: [
                  Checkbox(
                    value: _showPassword,
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          _showPassword = value;
                        });
                      }
                    },
                  ),
                  const Text('Show Password'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loginButton() {
    return Container(
      width: 180,
      height: 45,
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: const Center(
        child: Text(
          "LOGIN",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  _singUpTag() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignUpPage()),
        );
      },
      child: const Text(
        "Don't have an account? Sign up",
        style: TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  AlertDialog createAlert(BuildContext context) => AlertDialog(
        title: const Text("Authentication error"),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Incorrect username or password",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
              onPressed: () {
                debugPrint("Press Accept");
                Navigator.of(context).pop();
              },
              child: const Text("Accept")),
        ],
      );
}
