// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, constant_identifier_names, file_names, must_be_immutable, camel_case_types, sized_box_for_whitespace, use_build_context_synchronously, non_constant_identifier_names
import 'package:eshop/models/Profile.dart';
import 'package:eshop/sockets/connection.dart';
import 'package:eshop/style/ColorsUsed.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'home.dart';

class logIn extends StatefulWidget {
  const logIn({Key? key}) : super(key: key);

  @override
  State<logIn> createState() => _MyPage();
}

class _MyPage extends State<logIn> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            myImage(context, size),
            _MyBody(),
          ],
        ),
      ),
    );
  }
}

Widget myImage(context, Size size) {
  return Container(
      height: size.height * 0.35,
      width: size.width,
      child: Image.asset(
        'assets/img/logo.jpg',
        fit: BoxFit.cover,
      ));
}

class _MyBody extends StatefulWidget {
  const _MyBody({Key? key}) : super(key: key);

  @override
  State<_MyBody> createState() => _MyForm();
}

String? email;
String? password;

class _MyForm extends State<_MyBody> {
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
          const Text(
            'Log in',
            style: TextStyle(
                color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Log in with your eShop account',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          SizedBox(height: size.height * 0.03),
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
                  //label: Text('Email'),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 3, color: CustomColors.n1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.n1),
                  ),
                  hintText: "user@youremail.com",
                  filled: true,
                  fillColor: CustomColors.n2,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Required';
                  return null;
                },
                onSaved: (value) => email = value,
              ),
              SizedBox(height: size.height * 0.03),
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
                      "code": 1,
                      "content": {"email": email, "password": password}
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
                        builder: (context) => Home(
                          connection: connection,
                          admin: d["content"]["admin"],
                          profile: ,
                        ),
                        var route = MaterialPageRoute(
                        builder: (context) => Home(
                          perfil: perfil,
                        ),
                      );
                      Navigator.of(context).push(route);
                      );
                    }*/
                    var route = MaterialPageRoute(
                      builder: (context) => Home(
                          connection: Connection(),
                          admin: true,
                          profile: Profile(
                              email: "psegmar1@gmail.com",
                              name: "Pablo",
                              surname: "Segovia",
                              payments: ["PayPal"],
                              addresses: ["Calle Ave del paraiso"])),
                    );
                    Navigator.of(context).push(route);
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
                  'Log in',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              ListTile(
                title: Text(
                  "Don't have an account? Sign up",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                onTap: () {
                  _goToRegister(context);
                },
              ),
            ]),
          )
        ]));
  }
}

void _goToRegister(BuildContext context) {
  var route = MaterialPageRoute(
    builder: (context) => const register(),
  );
  Navigator.of(context).push(route);
}

Widget _MyAlert(context) => AlertDialog(
        title: const Text("Error"),
        content: const Text(
          "Wrong user or password",
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
