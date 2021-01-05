import 'package:OrderIt/pages/LoginScreen.dart';
import 'package:OrderIt/pages/RecoverPassword.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RecoveryScreen extends StatefulWidget {
  @override
  _RecoveryScreenState createState() => _RecoveryScreenState();
}

class _RecoveryScreenState extends State<RecoveryScreen> {
  var phoneMaskFormatter = new MaskTextInputFormatter(
      mask: '(##) ##### - ####', filter: {"#": RegExp(r'[0-9]')});

  var codeMaskFormatter = new MaskTextInputFormatter(
      mask: '### ###', filter: {"#": RegExp(r'[0-9]')});

  TextEditingController phoneC = TextEditingController();
  TextEditingController codeC = TextEditingController();

 

  @override
  Widget build(BuildContext context) {

    String phone = phoneC.text;
    String code = codeC.text;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber[300],
        body: Container(
          child: Column(
            children: [
              FlatButton(
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  title: Text("Esqueci o meu e-mail"),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Recuperação de e-mail"),
                        actions: [
                          FlatButton(
                            child: Text('Cancelar'),
                            onPressed: () {
                              phone = null;
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            child: Text('Enviar'),
                            onPressed: () {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    actions: [
                                      FlatButton(
                                        child: Text('Cancelar'),
                                        onPressed: () {
                                          phone = null;
                                          Navigator.pop(context);
                                        },
                                      ),
                                      FlatButton(
                                        child: Text('Enviar'),
                                        onPressed: () {
                                          
                                        },
                                      ),
                                    ],
                                    title: Text("Recuperação de e-mail"),
                                    content: Container(
                                      height: 70,
                                      child: Column(
                                        children: [
                                          Text(
                                              'Digite o código enviado para você'),
                                          TextField(
                                            controller: codeC,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [codeMaskFormatter],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                        content: Container(
                          width: 80,
                          height: 70,
                          child: Column(
                            children: [
                              Text('Digite seu número de telefone'),
                              TextField(
                                controller: phoneC,
                                inputFormatters: [phoneMaskFormatter],
                                keyboardType: TextInputType.phone,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return new RecoveryPassword();
                    },
                  ));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.lock_open,
                    color: Colors.black,
                  ),
                  title: Text('Esqueci minha senha'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Row(              
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                      ),
                    color: Colors.black,
                    textColor: Colors.white,                  
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return new LoginScreen();
                        },
                      ));
                    }, child: Text('Cancelar'))
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
