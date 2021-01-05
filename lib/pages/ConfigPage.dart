import 'package:OrderIt/auth.dart';
import 'package:OrderIt/pages/UserCCs.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'UserInformation.dart';

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {

  void start(){
    Hive.openBox('users');
    Hive.openBox('current_user');
    Hive.openBox('current_user_email');
  }

  @override
  void initState() {
    start();
    super.initState();
  }

  final usersBox = Hive.box('users');
  final currentUserBox = Hive.box('current_user');
  final currentUserEmailBox = Hive.box('current_user_email');

  final email = Hive.box('current_user_email').get('email');

  final data =
      Hive.box('current_user').get(Hive.box('current_user_email').get('email'));

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
              'Configurações',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(30),
              child: Text(data['name'],
                style: TextStyle(fontSize: 15),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {                        
                        return new UserInformation();
                      },
                    ));
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.info_outline,
                      color: Colors.black,
                    ),
                    title: Text('Informações da conta'),
                    subtitle:
                        Text('Consultar e editar as informações da sua conta'),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {                        
                        return new UserCCs();
                      },
                    ));
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.attach_money,
                      color: Colors.black,
                    ),
                    title: Text('Métodos de pagamento'),
                    subtitle:
                        Text('Consultar seus métodos de pagamento'),
                  )),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              child: FlatButton(
                  onPressed: () async {

                    Auth().signOut(context);

                    currentUserBox.clear();
                    currentUserEmailBox.clear();       

                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.exit_to_app,
                      color: Colors.black,
                    ),
                    title: Text('Sair da conta'),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
