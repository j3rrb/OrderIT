import 'package:OrderIt/database.dart';
import 'package:OrderIt/pages/OrderDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    Hive.openBox('current_user');
    super.initState();
  }

  final data =
      Hive.box('current_user').get(Hive.box('current_user_email').get('email'));

  List orders = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Meus Pedidos',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ),
      body: Text(''),
    );
  }
}
