import 'package:OrderIt/pages/TappedRestaurant.dart';
import 'package:flutter/material.dart';

import '../database.dart';

class RestaurantsPage extends StatefulWidget {
  @override
  _RestaurantsPageState createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {
  List rests = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.amber[300],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: Colors.amber[400],
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Restaurantes',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ),
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Procure aqui...',
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FlatButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return new TappedRestaurant(
                                nome: "Pé de fava",
                                rua:"Rua Pinheiro, 104",
                              );
                            },));
                          },
                          child: ListTile(
                            subtitle: Text('Rua Pinheiro, 104'),
                            trailing: Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            ),
                            leading: Icon(
                              Icons.restaurant_menu,
                              color: Colors.black,
                            ),
                            title: Text('Pé de fava'),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return new TappedRestaurant(
                                nome: "Bom sabor",
                                rua:"Rua Bahia, 335",
                              );
                            },));
                          },
                          child: ListTile(
                            subtitle: Text('Rua Bahia, 335'),
                            trailing: Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            ),
                            leading: Icon(
                              Icons.restaurant_menu,
                              color: Colors.black,
                            ),
                            title: Text('Bom sabor'),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return new TappedRestaurant(
                                nome: "Dá Licença",
                                rua:"Rua Macapá, 5787",
                              );
                            },));
                          },
                          child: ListTile(
                            subtitle: Text('Rua Macapá, 5787'),
                            trailing: Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            ),
                            leading: Icon(
                              Icons.restaurant_menu,
                              color: Colors.black,
                            ),
                            title: Text('Dá Licença'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
