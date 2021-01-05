import 'package:OrderIt/pages/CreateAccScreen.dart';
import 'package:OrderIt/pages/RecoveryScreen.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:OrderIt/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController eC = TextEditingController();
  TextEditingController sC = TextEditingController();

  String email;
  String pass;

  // bool loading = false;

  final _focusE = FocusNode();
  final _focusS = FocusNode();

  @override
  void initState() {
    Hive.openBox('current_user');
    Hive.openBox('current_user_email');
    Hive.openBox('users');
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void validateEmail(email) {
    bool isValid = EmailValidator.validate(email);

    isValid == true ? true : false;
  }

  //verificar conexao com a net

  Widget _genericInput(String title, String hintText, TextInputAction tia,
      FocusNode fn, bool ot) {
    return Container(
      margin: EdgeInsets.only(top: 25, left: 20),
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, right: 25),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    controller: eC,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: tia,
                    onFieldSubmitted: (value) {
                      fn.nextFocus();
                    },
                    focusNode: fn,
                    obscureText: ot,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        hintText: hintText,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.amber[300],
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/orderit_logo.png',
                      width: 250, height: 200)
                ],
              ),
              Container(
                height: 100,
                margin: EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 160,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(1, 1),
                          spreadRadius: 5,
                          blurRadius: 15)
                    ]),
                child: Column(
                  children: [
                    _genericInput("Seu e-mail", "Digite seu e-mail aqui",
                        TextInputAction.next, _focusE, false),
                    Container(
                      margin: EdgeInsets.only(top: 25, left: 20),
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Sua senha",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10, right: 20),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      setState(() {
                                        pass = value;
                                      });
                                    },
                                    controller: sC,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (value) {
                                      _focusS.unfocus();
                                    },
                                    focusNode: _focusS,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        hintText: "Digite sua senha aqui",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width - 100,
                            margin: EdgeInsets.only(top: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 120,
                                  height: 200,
                                  child: RaisedButton(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                          color: Colors.black,
                                        )),
                                    color: Colors.black,
                                    textColor: Colors.white,
                                    onPressed: () async {
                                      if (eC.text.isEmpty || sC.text.isEmpty) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return new AlertDialog(
                                              title: Text('Atenção!'),
                                              content: Text(
                                                  'Preencha todos os campos!'),
                                              actions: [
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Ok'))
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        try {
                                          Auth _a = Auth();
                                          _a.signIn(context, email, pass);

                                          var emailU =
                                              Hive.box('users').get(email);

                                          print(emailU);

                                          if (emailU == null) {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return new AlertDialog(
                                                  title: Text('Erro!'),
                                                  content: Text(
                                                      'Seus dados não foram encontrados!'),
                                                  actions: [
                                                    FlatButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text('Ok'))
                                                  ],
                                                );
                                              },
                                            );
                                          } else {
                                            Hive.box('current_user')
                                                .put(email, emailU);

                                            Hive.box('current_user_email')
                                                .put('email', email);
                                          }
                                        } catch (e) {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return new AlertDialog(
                                                title: Text('Atenção!'),
                                                content: Text(
                                                    'Erro ao realizar o login! = $e'),
                                                actions: [
                                                  FlatButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Ok'))
                                                ],
                                              );
                                            },
                                          );

                                          if (DataConnectionChecker().hasConnection == false) {
                                            showDialog(context: context, builder: (context) {
                                              return new AlertDialog(
                                                title: Text('Erro'),
                                                content: Text('Não foi possível estabelecer uma conexão com a internet!'),
                                                actions: [
                                                  FlatButton(onPressed: () {
                                                    Navigator.pop(context);
                                                  }, child: Text('Ok'))
                                                ],
                                              );
                                            },);
                                          }
                                        }
                                      }
                                    },
                                    child: Text("Entrar"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 15),
                            child: FlatButton(
                              child: Text(
                                  "Não possui uma conta no OrderIt!? Crie uma!"),
                              onPressed: () {
                                eC.text = null;
                                sC.text = null;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CreateAcc()));
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 15),
                            child: FlatButton(
                              child: Text(
                                  "Esqueceu alguma informação? Recupere agora!"),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RecoveryScreen()));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
