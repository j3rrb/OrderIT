import 'package:OrderIt/database.dart';
import 'package:OrderIt/pages/BottomNav.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class TappedRestaurant extends StatefulWidget {
  String nome;
  String rua;

  TappedRestaurant({this.nome, this.rua, Key key}) : super(key: key);

  @override
  _TappedRestaurantState createState() => _TappedRestaurantState();
}

class _TappedRestaurantState extends State<TappedRestaurant> {
  @override
  void initState() {
    super.initState();
  }

    final data =
      Hive.box('current_user').get(Hive.box('current_user_email').get('email'));

  var _current;
  var _current2;

  var finalValue = 0.0;
  var tableCode;
  var selectedFood;


  List<Map<dynamic, dynamic>> pratos = [
    {
      'codigo': 0009,
      'custo': 50.5,
      'descricao': "Restaurante Pé de fava",
      'nome': "Bolo",
      'status': true
    },
    {
      'codigo': 0001,
      'custo': 0.04,
      'descricao': "a",
      'nome': "pão",
      'status': true
    },
    {
      'codigo': 0006,
      'custo': 15.5,
      'descricao': "feijão precto",
      'nome': "Feijoada",
      'status': true
    }
  ];

  List<Map<dynamic, dynamic>> mesas = [
    {
      'codigo': 001,
      'lugares': 5,
      'valor': 1350.1,
    },
    {
      'codigo': 002,
      'lugares': 4,
      'valor': 120.2,
    },
    {
      'codigo': 004,
      'lugares': 4,
      'valor': 150.2,
    }
  ];

  @override
  Widget build(BuildContext context) {
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
            title: Padding(
              padding: const EdgeInsets.only(right: 0),
              child: Text(
                "${widget.nome}",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Descrição',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      pratos[0]['descricao'].toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Pratos',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Container(
                        height: 50,
                        width: 200,
                        child: DropdownButtonHideUnderline(                          
                          child: DropdownButton(
                            isExpanded: true,
                            itemHeight: 200,
                            iconSize: 26,
                            onChanged: (value) {
                              setState(() {
                                _current = value;
                              });
                            },
                            value: _current,
                            items: [
                              DropdownMenuItem(
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [                                        
                                        Text(
                                          "Preço: " +
                                              pratos[0]['custo'].toString(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "Nome: " +
                                              pratos[0]['nome'].toString(),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                value: pratos[0]['codigo'],
                                onTap: () {
                                  finalValue = pratos[0]['custo'];
                                  selectedFood = pratos[0]['nome'];
                                },
                              ),
                              DropdownMenuItem(
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: Column(
                                    children: [                                      
                                      Text("Preço: " +
                                          pratos[1]['custo'].toString()),
                                      Text("Nome: " +
                                          pratos[1]['nome'].toString())
                                    ],
                                  ),
                                ),
                                value: pratos[1]['codigo'],
                                onTap: () {
                                  finalValue = pratos[1]['custo'];
                                  selectedFood = pratos[1]['nome'];
                                },
                              ),
                              DropdownMenuItem(
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: Column(
                                    children: [                                      
                                      Text("Preço: " +
                                          pratos[2]['custo'].toString()),
                                      Text("Nome: " +
                                          pratos[2]['nome'].toString(), style: TextStyle(fontSize: 14),)
                                    ],
                                  ),
                                ),
                                value: pratos[2]['codigo'],
                                onTap: () {
                                  finalValue = pratos[2]['custo'];
                                  selectedFood = pratos[2]['nome'];
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Mesas',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Container(
                        width: 200,                      
                        child: DropdownButton(
                          isExpanded: true,
                          iconSize: 26,
                          onChanged: (value) {
                            setState(() {
                              _current2 = value;
                            });
                          },
                          value: _current2,
                          items: [
                            DropdownMenuItem(
                              child: Container(
                                child: Column(
                                  children: [
                                    Text("Código: " +
                                        mesas[0]['codigo'].toString()),
                                    Text("Lugares: " +
                                        mesas[0]['lugares'].toString())
                                  ],
                                ),
                              ),
                              value: mesas[0]['codigo'],
                              onTap: () {
                                tableCode = mesas[0]['codigo'];
                              },
                            ),
                            DropdownMenuItem(
                              child: Container(
                                child: Column(
                                  children: [
                                    Text("Código: " +
                                        mesas[1]['codigo'].toString()),
                                    Text("Lugares: " +
                                        mesas[1]['lugares'].toString())
                                  ],
                                ),
                              ),
                              value: mesas[1]['codigo'],
                              onTap: () {
                                tableCode = mesas[1]['codigo'];
                              },
                            ),
                            DropdownMenuItem(
                              child: Container(
                                child: Column(
                                  children: [
                                    Text("Código: " +
                                        mesas[2]['codigo'].toString()),
                                    Text("Lugares: " +
                                        mesas[2]['lugares'].toString())
                                  ],
                                ),
                              ),
                              value: mesas[2]['codigo'],
                              onTap: () {
                                tableCode = mesas[2]['codigo'];
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(                
                padding: EdgeInsets.only(left: 10, top: 80),
                child: Column(
                  children: [
                    Text('Valor final: ', style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),),
                    Text("R\$" + finalValue.toString(), style: TextStyle(
                      fontSize: 18
                    ),),
                  ],
                ),
              ),
              Container(
                child: Container(
                  padding: EdgeInsets.only(top: 90),
                  width: 500,
                  child: RaisedButton(
                    child: Text('Reservar'),
                    color: Colors.black,
                    textColor: Colors.white,
                    onPressed: () {
                      Db().insertOrder(                        
                        codMesa: '001',
                        codPrato: '004',
                        codigo: '0001',
                        codigoPedido: '00012',
                        data: DateTime.now().toString(),
                        id: data['cpf'].toString(),
                        idMesa: '002',
                        nome: data['name'],
                        pratos: selectedFood
                      );
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return new BottomNav();
                        },
                      ));
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
