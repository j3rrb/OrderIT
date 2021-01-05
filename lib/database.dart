import 'dart:async';
import 'dart:convert';

import 'package:OrderIt/classes/User.dart';
import 'package:OrderIt/pages/UserCCs.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class Db {
  final db = FirebaseDatabase.instance.reference();

  void insertUser(User u) {
    db.child('usuarios').child(u.getCpf.toString()).set({
      'nome': u.getUsername,
      'cpf': u.getCpf,
      'email': u.getEmail,
      'cidade': u.getCity,
    }).catchError((e) {
      print(e);
    });
  }

  getUser(List l) {
    db.once().then((value) {
      l.add(value);
    }).catchError((e) {
      print(e);
    });
  }

  updateUser(cpf, key, value) {
    db
        .child('usuarios')
        .child(cpf.toString())
        .update({key: value}).catchError((e) {
      print(e);
    });
  }

  deleteUser(cpf) {
    db.child('usuarios').child(cpf.toString()).remove().catchError((e) {
      print(e);
    });
  }

  getPratos() {
    db
        .child('pratos')
        .once()
        .then((value) => new Map<dynamic, dynamic>.from(value.value))
        .catchError((e) => print(e));
  }

  getUserOrders(List list) {
    db.child('pedidos').once().then((value) {
      list.add(value.value);
    }).catchError((e) {
      print(e);
    });
  }

  getPayMethods() {

    Completer c = new Completer();

    db
        .child('pagamentos')
        .once()
        .then((value) {
          var val = new UserCCs().fromJson(value.key, value.value);
          c.complete(val);
        })
        .catchError((e) => print(e));
        return c.future;
  }

  deleteUserPayMethod(number) {
    db.child('pagamentos').child(number.toString()).remove();
  }

  insertUserPayMethod(number, name, secnum, validation) {
    db.child('pagamentos').child(number.toString()).set({
      'card_number': number,
      'cardholder_name': name,
      'security_number': secnum,
      'valid_thru': validation
    });
  }

  insertOrder({id, nome, codPrato, codigoPedido, data, codigo, idMesa, codMesa, pratos}) {
    db.child('pedidos').push().set({
      'codigo': codigoPedido,
    'data': data,
    'status': false,
    'cliente': {
      'nome': nome,
      'id': id
    },
    'mesa': {
      'codigo': codMesa,
      'id': idMesa
    },
    'pratos': [
      {
        'codigo': codPrato,
        'nome': pratos
      }
    ]
    });
  }

  updateOrder(id, key, value) {
    db.child('pedidos').child(id.toString()).update({key: value});
  }

  getRestaurants(List list) {
    db.child('restaurantes').once().then((value) {
      list.add(value.value);
    });
  }
}
