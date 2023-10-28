import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'first_page/container.dart';
//import 'package:drovmar_pfinal/future/alert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

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
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  child: _loginButon(),
                ),
              ]),
            )
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
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese su nombre de usuario';
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
                    return 'Ingrese su contraseña';
                  }
                  return null;
                },
              ),
            ),
            Row(
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
          ],
        ),
      ),
    );
  }

  _loginButon() {
    return Container(
      width: 180,
      height: 45,
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          bottomLeft: Radius.circular(25.0),
        ),
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
}
