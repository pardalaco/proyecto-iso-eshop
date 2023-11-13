// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, camel_case_types, constant_identifier_names, sized_box_for_whitespace, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:eshop/sockets/connection.dart';
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
      backgroundColor: const Color.fromARGB(255, 35, 34, 34),
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
String? surnames;
String? email;
String? password;

class _MyFormR extends State<_MyBodyR> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        color: const Color.fromARGB(255, 35, 34, 34),
        padding: EdgeInsetsDirectional.symmetric(
            horizontal: size.width * 0.05, vertical: size.height * 0.03),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Regístrate',
            style: TextStyle(
                color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: size.height * 0.0275),
          Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Nombre',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.01),
              TextFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 3, color: Color.fromARGB(255, 255, 174, 0)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: "Tu nombre",
                  filled: true,
                  fillColor: const Color.fromARGB(255, 123, 123, 123),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Campo obligatorio';
                  return null;
                },
                onSaved: (value) => name = value,
              ),
              SizedBox(height: size.height * 0.05),
              const Text(
                'Apellidos',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.01),
              TextFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 3, color: Color.fromARGB(255, 255, 174, 0)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: "Tus apellidos",
                  filled: true,
                  fillColor: const Color.fromARGB(255, 123, 123, 123),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Campo obligatorio';
                  return null;
                },
                onSaved: (value) => surnames = value,
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
                    borderSide: const BorderSide(
                        width: 3, color: Color.fromARGB(255, 255, 174, 0)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: "Tu email",
                  filled: true,
                  fillColor: const Color.fromARGB(255, 123, 123, 123),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Campo obligatorio';
                  return null;
                },
                onSaved: (value) => email = value,
              ),
              SizedBox(height: size.height * 0.05),
              const Text(
                'Contraseña',
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
                    borderSide: const BorderSide(
                        width: 3, color: Color.fromARGB(255, 255, 174, 0)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: "Tu contraseña",
                  filled: true,
                  fillColor: const Color.fromARGB(255, 123, 123, 123),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Campo obligatorio';
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
                    Connection connection = Connection();
                    await connection.query({
                      "type": 1,
                      "code": 2,
                      "content": {
                        "email": email,
                        "password": password,
                        "username": name,
                      }
                    });
                    showDialog(
                      context: context,
                      builder: (context) => Home(connection: connection),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Formulario inválido'),
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 255, 174, 0)),
                  fixedSize: MaterialStateProperty.all<Size>(
                      Size(size.width, size.height * 0.07)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                child: const Text(
                  'Registrarse',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              ListTile(
                title: const Text(
                  "Ya tienes cuenta? Inicia sesión",
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
