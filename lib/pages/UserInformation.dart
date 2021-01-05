import 'dart:convert';

import 'package:OrderIt/database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../cities.dart';

class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final email = Hive.box('current_user_email').get('email');
  final data =
      Hive.box('current_user').get(Hive.box('current_user_email').get('email'));

  var phoneMaskFormatter = new MaskTextInputFormatter(
      mask: '(##) ##### - ####', filter: {"#": RegExp(r'[0-9]')});

  var city;
  var phone;
  var cities = new List<Cities>();
  var filteredCities = new List<Cities>();

  @override
  Widget build(BuildContext context) {
    _selectedCityText(int index) {
      setState(() {
        city = filteredCities[index].city;
      });
    }

    Widget _buildList() {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return FlatButton(
              child: Text(filteredCities[index].city),
              onPressed: () {
                setState(() {
                  _selectedCityText(index);
                  Navigator.pop(context);
                });
              },
            );
          },
          itemCount: filteredCities.length,
        ),
      );
    }

    _getCitiesToList() {
    Cities().getCities().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        cities = list.map((model) => Cities.fromJson(model)).toList();
        filteredCities = cities;        
      });
    });
  }

    _UserInformationState() {
      _getCitiesToList();
    }

    return SafeArea(
      child: FutureBuilder(
        future: Hive.openBox('current_user_email'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return Scaffold(
                  backgroundColor: Colors.amber[300],
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(60),
                    child: AppBar(
                      centerTitle: true,
                      backgroundColor: Colors.amber[400],
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      title: Text(
                        'Suas informações',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(top: 10),
                            child: ListTile(
                              leading: Icon(
                                Icons.face,
                                color: Colors.black,
                              ),
                              title: Text("Nome: " + data['name']),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: FlatButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    isDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return SafeArea(
                                        child: Scaffold(
                                          body: Wrap(children: [
                                            Container(
                                              margin: EdgeInsets.all(20),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: TextField(
                                                  autocorrect: true,
                                                  textInputAction:
                                                      TextInputAction.search,
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      hintText: "Procure aqui",
                                                      icon: Icon(Icons.search)),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      filteredCities = cities
                                                          .where((element) => (element
                                                                  .city
                                                                  .toLowerCase()
                                                                  .contains(value
                                                                      .toLowerCase()) ||
                                                              element.city
                                                                  .toUpperCase()
                                                                  .contains(value
                                                                      .toUpperCase())))
                                                          .toList();
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: SingleChildScrollView(
                                                  child: _buildList()),
                                            ),
                                          ]),
                                        ),
                                      );
                                    });
                              },
                              child: ListTile(
                                leading: Icon(
                                  Icons.location_city,
                                  color: Colors.black,
                                ),
                                title: Text("Cidade: " + data['city']),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: FlatButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return new AlertDialog(
                                      title: Text('Editar telefone'),
                                      content: TextField(),
                                      actions: [
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancelar')),
                                        FlatButton(
                                            onPressed: () {
                                              
                                            },
                                            child: Text('Editar')),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: ListTile(
                                leading: Icon(
                                  Icons.phone,
                                  color: Colors.black,
                                ),
                                title: Text("Telefone: " + data['phone']),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(top: 10),
                            child: ListTile(
                              leading: Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                              title: Text("E-mail: " + data['email']),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(top: 10),
                            child: ListTile(
                              leading: Icon(
                                Icons.assignment,
                                color: Colors.black,
                              ),
                              title: Text("CPF: " + data['cpf']),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
            }
          } else {
            return CircularProgressIndicator(
              backgroundColor: Colors.white,              
            );
          }
        },
      ),
    );
  }
}
