import 'package:OrderIt/pages/BottomNav.dart';
import 'package:OrderIt/pages/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Auth {
  showError(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return new AlertDialog(
          title: Text('Erro!'),
          content: Text('Erro ao realizar essa ação!'),
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

  void createUser(String email, String pass, BuildContext context) {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
    } catch (e) {
      if (e is PlatformException) {
        if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          showDialog(
            context: context,
            builder: (context) {
              return new AlertDialog(
                title: Text('Aviso!'),
                content: Text('Este e-mail já está em uso!'),
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
    }
  }

  void signIn(BuildContext context, String email, String pass) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNav(),
          ));
    }).catchError((err) {
      if (err is PlatformException) {
        if (err.code == 'ERROR_INVALID_EMAIL') {
          showDialog(
            context: context,
            builder: (context) {
              return new AlertDialog(
                title: Text('Aviso!'),
                content: Text('Este e-mail é inválido!'),
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
        } else if (err.code == 'ERROR_WRONG_PASSWORD') {
          showDialog(
            context: context,
            builder: (context) {
              return new AlertDialog(
                title: Text('Aviso!'),
                content: Text('Senha incorreta!'),
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
        } else if (err.code == 'ERROR_USER_NOT_FOUND') {
          showDialog(
            context: context,
            builder: (context) {
              return new AlertDialog(
                title: Text('Aviso!'),
                content: Text('Esta conta não existe!'),
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
        } else if (err.code == 'ERROR_USER_DISABLED') {
          showDialog(
            context: context,
            builder: (context) {
              return new AlertDialog(
                title: Text('Aviso!'),
                content: Text('Conta desativada!'),
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
        } else if (err.code == 'ERROR_TOO_MANY_REQUESTS') {
          showDialog(
            context: context,
            builder: (context) {
              return new AlertDialog(
                title: Text('Aviso!'),
                content: Text('Muitas requisições, tente mais tarde!'),
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
        } else if (err.code == 'ERROR_OPERATION_NOT_ALLOWED') {
          showDialog(
            context: context,
            builder: (context) {
              return new AlertDialog(
                title: Text('Aviso!'),
                content: Text('Operação não permitida!'),
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
    });
  }

  void resetPassword(String email, BuildContext context) async {
    return await FirebaseAuth.instance.sendPasswordResetEmail(email: email).catchError(showError(context));
  }

  void resetEmail(String email, BuildContext context) async {
    return FirebaseAuth.instance
        .currentUser()
        .then((value) => value.updateEmail(email)).catchError(showError(context));
  }

  void signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut().then((value) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return LoginScreen();
        },
      ));
    }).catchError(showError(context));
  }

  Future deleteUser(BuildContext context) async {
    await FirebaseAuth.instance.currentUser().then((FirebaseUser u) {
      u.delete();
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return new LoginScreen();
        },
      ));
    }).catchError(showError(context));
  }
}
