import 'package:OrderIt/database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UserCCs extends StatefulWidget {

  final String k = '';
  String value;
  
  fromJson(k, Map data){
    value = data['card_number'];
    if (value == null) {
      value = '';
    }
  }

  @override
  _UserCCsState createState() => _UserCCsState();
}

class _UserCCsState extends State<UserCCs> {
  void start() async {
    var x = Db().getPayMethods();
    print(x);
    await Hive.openBox('current_user');
    await Hive.openBox('cartao');
  }

  final data =
      Hive.box('current_user').get(Hive.box('current_user_email').get('email'));

  final cartao =
      Hive.box('cartao').get(Hive.box('current_user_email').get('email'));

  @override
  void initState() {
    start();
    super.initState();
  }

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
              'Métodos de Pagamento',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ),
      body: Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .2,
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, left: 10),
                child: Text('Número do cartão: '),
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    cartao['numero'].toString(),
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Text('Código de segurança:'),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(cartao['validade']),
              )
            ],
          ),        
        ],
      ),
    ),
    );
  }
}
