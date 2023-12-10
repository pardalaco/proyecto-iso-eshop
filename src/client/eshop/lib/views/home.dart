// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_const_constructors, no_leading_underscores_for_local_identifiers, no_logic_in_create_state, must_be_immutable, unused_element, sized_box_for_whitespace

import 'package:eshop/models/Response.dart';
import 'package:eshop/models/Tag.dart';
import 'package:eshop/views/productDetails.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:eshop/sockets/connection.dart';
import 'package:eshop/models/Product.dart';
import 'package:eshop/models/Profile.dart';
import 'package:eshop/style/ColorsUsed.dart';

class Home extends StatefulWidget {
  Connection connection;
  bool admin;
  Profile profile;
  Home(
      {Key? key,
      required this.connection,
      required this.admin,
      required this.profile})
      : super(key: key);

  @override
  State<Home> createState() =>
      _MyPage(connection: connection, admin: admin, profile: profile);
}

class _MyPage extends State<Home> {
  Connection connection;
  bool admin;
  Profile profile;
  _MyPage(
      {required this.connection, required this.admin, required this.profile});

  @override
  Widget build(BuildContext context) {
    final _MyAppBar = AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        backgroundColor: CustomColors.n1,
        centerTitle: true,
        title: Text(
          "Home",
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.height * 0.05,
          ),
        ));

    void updateState() {
      setState(() {});
    }

    return WillPopScope(
        onWillPop: () async {
          return false; // Deshabilitar el pop
        },
        child: Scaffold(
          appBar: _MyAppBar,
          drawer: _MyDrawer(context, profile, admin, updateState),
          body: _MyHomeBody(
            connection: connection,
            admin: admin,
            profile: profile,
          ),
          floatingActionButton: adminMode
              ? FloatingActionButton(
                  onPressed: () {
                    print("Add product");
                  },
                  backgroundColor: CustomColors.n1,
                  child: const Icon(Icons.add, color: Colors.white),
                )
              : null,
        ));
  }
}

class _MyHomeBody extends StatefulWidget {
  Connection connection;
  bool admin;
  Profile profile;
  _MyHomeBody(
      {Key? key,
      required this.connection,
      required this.admin,
      required this.profile});

  @override
  State<_MyHomeBody> createState() => _HomeBody();
}

bool adminMode = false;
bool searchByTag = false;
bool searchByName = false;

class _HomeBody extends State<_MyHomeBody> {
  final FocusNode _focusNode = FocusNode();
  String? textoIngresado;

  void updateState2() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsetsDirectional.symmetric(
          horizontal: size.width * 0.05, vertical: size.height * 0.03),
      color: CustomColors.background,
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.025,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: CustomColors.n1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: CustomColors.n1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: "Search a product",
                      filled: true,
                      fillColor: CustomColors.n2,
                      prefixIcon: Icon(
                        Icons.search,
                        color: _focusNode.hasFocus ? Colors.grey : Colors.white,
                      )),
                  onSubmitted: (value) => {
                    setState(() {
                      textoIngresado = value;
                      searchByName = true;
                      searchByTag = false;
                    })
                  },
                ),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            _MyAlert(context, updateState2, widget.connection));
                  },
                  icon: Icon(
                    Icons.filter_list_alt,
                    color: CustomColors.n1,
                    size: MediaQuery.of(context).size.width * 0.125,
                  ))
            ],
          ),
          SizedBox(
            height: size.height * 0.025,
          ),
          if (searchByName) ...[
            if (textoIngresado?.isEmpty ?? true) ...[
              const Text(
                "Please enter a search term",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            ] else ...[
              Expanded(
                  child:
                      FuturaLista(context, widget.connection, widget.profile))
            ]
          ] else if (searchByTag) ...[
            Text(
              "Searching by tags: " + tags.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ] else ...[
            const Text(
              "Please enter a search term",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ]
        ],
      ),
    );
  }
}

Widget _MyDrawer(
    context, Profile perfil, bool admin, VoidCallback updateState) {
  return Drawer(
      child: Container(
    color: CustomColors.background,
    child: Column(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
          color: CustomColors.n1,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("assets/img/User.jpg"))),
              ),
              Text(
                perfil.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.height * 0.04,
                ),
              ),
              Text(
                perfil.email,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        ListTile(
          title: Text(
            "Edit profile",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          leading: Icon(
            Icons.edit,
            size: MediaQuery.of(context).size.height * 0.04,
            color: Colors.white,
          ),
          onTap: () {
            //_goToProfilePage(context, perfil);
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        ListTile(
          title: Text(
            "My orders",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          leading: Icon(
            Icons.shopping_basket,
            size: MediaQuery.of(context).size.height * 0.04,
            color: Colors.white,
          ),
          onTap: () {
            //_goToEditProfile(context, perfil);
          },
        ),
        Expanded(child: Container()),
        if (admin) ...[
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Text(
                "Admin",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              MySwitch(
                updateState: updateState,
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
        ],
        ListTile(
          title: Text(
            "Log out",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          leading: Icon(
            Icons.logout_outlined,
            size: MediaQuery.of(context).size.height * 0.04,
            color: Colors.white,
          ),
          onTap: () {
            //_goToLogIn(context);
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
      ],
    ),
  ));
}

class MySwitch extends StatefulWidget {
  final VoidCallback updateState;
  const MySwitch({Key? key, required this.updateState}) : super(key: key);
  @override
  State<MySwitch> createState() => _MySwitchState(updateState: updateState);
}

class _MySwitchState extends State<MySwitch> {
  final VoidCallback updateState;
  _MySwitchState({required this.updateState});
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: 1.5,
        child: Switch.adaptive(
            thumbColor: MaterialStateProperty.all(CustomColors.n1),
            activeTrackColor: CustomColors.n1.withOpacity(0.4),
            value: adminMode,
            onChanged: (newValue) => setState(() {
                  adminMode = newValue;
                  updateState();
                })));
  }
}

//@toDo Manejar errores cuando el server este OK
Widget FuturaLista(
    BuildContext context, Connection connection, Profile profile) {
  return FutureBuilder(
    future: connection.getProducts(profile.email),
    builder: (context, AsyncSnapshot<String> snapshot) {
      if (snapshot.hasData) {
        Map<String, dynamic> data = json.decode(snapshot.data!);
        Response response = Response.fromJson(data);
        var products = Products.fromJson(response.content, false);
        final productList = products.products.map((product) {
          return ListTile(
            title: Text(product.name),
            textColor: Colors.white,
            subtitle: Text(product.price.toString()),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            onTap: () {
              var route = MaterialPageRoute(
                builder: (context) => DetailPage(
                  producto: product,
                  connection: connection,
                  profile: profile,
                ),
              );
              Navigator.of(context).push(route);
            },
          );
        }).toList();
        if (productList.isEmpty) {
          return const Text(
            "No products found",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          );
        } else {
          return ListView.separated(
            padding: const EdgeInsets.all(10.0),
            itemBuilder: (context, index) => productList[index],
            separatorBuilder: (context, index) => const Divider(
              thickness: 1,
              color: Colors.white,
            ),
            itemCount: productList.length,
          );
        }
      }
      return Center(
          child: SizedBox(
        height: MediaQuery.of(context).size.width * 0.25,
        width: MediaQuery.of(context).size.width * 0.25,
        child: CircularProgressIndicator(
            strokeWidth: 10.0,
            valueColor: AlwaysStoppedAnimation(CustomColors.n1)),
      ));
    },
  );
}

Widget _MyAlert(
        context, final VoidCallback updateState2, Connection connection) =>
    AlertDialog(
        title: const Text(
          "Select tags",
          textAlign: TextAlign.center,
        ),
        content: Container(
            width: MediaQuery.of(context).size.width * 0.15,
            height: MediaQuery.of(context).size.height * 0.15,
            child: _TagsList(
              connection: connection,
            )),
        actions: [
          Center(
            child: TextButton(
                onPressed: () {
                  searchByName = false;
                  searchByTag = false;
                  for (Tag t in tags.tags) {
                    searchByTag = searchByTag || t.choose;
                  }
                  updateState2();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Search",
                  style: TextStyle(
                      color: CustomColors.n1,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                )),
          )
        ]);

class _TagsList extends StatefulWidget {
  Connection connection;
  _TagsList({super.key, required this.connection});
  @override
  State<_TagsList> createState() => _TagsListState();
}

late Tags tags;
bool firstTime =
    true; //Para evitar que al reconstruir el widget se me ponga a false "choose"

class _TagsListState extends State<_TagsList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.connection.getTags(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> data = json.decode(snapshot.data!);
          Response response = Response.fromJson(data);
          if (firstTime) {
            tags = Tags.fromJson(response.content);
            firstTime = false;
          }
          final tagsList = tags.tags.map((t) {
            return CheckboxListTile(
              title: Text(t.name),
              value: t.choose,
              activeColor: CustomColors.n1,
              onChanged: (bool? value) {
                t.choose = value ?? false;
                setState(() {});
                print('Checkbox ${t.name}: ${t.choose}');
              },
            );
          }).toList();
          return ListView.builder(
            itemCount: tagsList.length,
            itemBuilder: (context, index) => tagsList[index],
          );
        }
        return Center(
            child: SizedBox(
          height: MediaQuery.of(context).size.width * 0.1,
          width: MediaQuery.of(context).size.width * 0.1,
          child: CircularProgressIndicator(
              strokeWidth: 5,
              valueColor: AlwaysStoppedAnimation(CustomColors.n1)),
        ));
      },
    );
  }
}
