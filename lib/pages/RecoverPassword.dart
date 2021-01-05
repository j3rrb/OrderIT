import 'package:OrderIt/auth.dart';
import 'package:OrderIt/pages/LoginScreen.dart';
import 'package:flutter/material.dart';

class RecoveryPassword extends StatefulWidget {
  @override
  _RecoveryPasswordState createState() => _RecoveryPasswordState();
}

class _RecoveryPasswordState extends State<RecoveryPassword> {
  TextEditingController _emailC = TextEditingController();

  FocusNode _email = FocusNode();

  String _emailText;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber[300],
        body: Container(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * .05,
              right: MediaQuery.of(context).size.width * .05),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40, bottom: 120),
                child: Text(
                  'Criar uma nova senha',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: TextFormField(
                  controller: _emailC,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (value) {
                    _email.unfocus();

                    setState(() {
                      _emailText = _emailC.text;
                    });
                  },
                  focusNode: _email,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "Digite seu email aqui",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * .85,
                  height: MediaQuery.of(context).size.height * .07,
                  margin: EdgeInsets.only(top: 20),
                  child: RaisedButton(
                    child: Text('Criar nova senha'),
                    color: Colors.black,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      if (_emailC.text.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return new AlertDialog(
                              title: Text('Atenção!'),
                              content: Text('Preencha todos os campos!'),
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
                          Auth().resetPassword(_emailText, context);

                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return new LoginScreen();
                            },
                          ));
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return new AlertDialog(
                                title: Text('Erro!'),
                                content: Text(e),
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
                        }
                      }
                    },
                  )),
              Container(
                child: FlatButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return new LoginScreen();
                      },
                    ));
                  },
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
