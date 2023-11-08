

// Conexion
import 'package:eshop/sockets/connection.dart';

// Future
import 'package:eshop/future/futureLogin.dart';

import 'package:eshop/signUpPage.dart';
import 'package:flutter/material.dart';


//import 'first_page/container.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  Connection connection;

  LoginPage({Key? key, required this.connection}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final TextEditingController _usernameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                // Login button
                GestureDetector(
                  onTap: () async {
                    // Sending data to the server

                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FutureLogin(
                              connection: widget.connection,
                              user: _usernameController.text.toString(),
                              pwd: _passwordController.text.toString(),
                            ),
                          ));
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
          MaterialPageRoute(
              builder: (context) => SignUpPage(
                    connection: widget.connection,
                  )),
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
}
