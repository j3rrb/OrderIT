import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  
  String restName;
  String date;
  String description;
  double finalValue;
  String id;

  OrderDetails(
      {this.restName,
      this.date,
      this.description,
      this.finalValue,
      this.id});

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final OrderDetails orderDetails;

  _OrderDetailsState({this.orderDetails});

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
            padding: const EdgeInsets.all(8.0),
            child: Text(
              orderDetails.id,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 30, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Data do pedido: ',
                          style: TextStyle(fontWeight: FontWeight.w300)),
                      Text(orderDetails.date,
                          style: TextStyle(fontWeight: FontWeight.w600))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10, left: 20),
                      child: Text(
                        'Restaurante:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10, left: 20),
                      child: Text(
                        orderDetails.restName,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    'Descrição:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 30, left: 20),
            child: Container(
              width: MediaQuery.of(context).size.width * .9,
              height: MediaQuery.of(context).size.height * .35,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: SingleChildScrollView(
                child: Container(
                  child: Text(
                    orderDetails.description,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  padding: EdgeInsets.all(10),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Row(
              children: [
                Text(
                  'Valor total: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
                Text(
                  orderDetails.finalValue.toString(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
