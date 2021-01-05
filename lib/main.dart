import 'dart:io';
import 'package:OrderIt/pages/LoginScreen.dart';
import 'package:OrderIt/pages/TappedRestaurant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'pages/BottomNav.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory doc = await getApplicationDocumentsDirectory();
  Hive.init(doc.path);
  await Hive.openBox('users');
  await Hive.openBox('current_user');
  await Hive.openBox('current_user_email');
  await Hive.openBox('cartao');
  runApp(App());  
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Widget getLandingPage() {
  return StreamBuilder<FirebaseUser>(
    stream: _auth.onAuthStateChanged,
    builder: (BuildContext context, snapshot) {
      if (snapshot.hasData && (!snapshot.data.isAnonymous)) {
        return BottomNav();
      }
      return LoginScreen();
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.amber[300],
      ),
      debugShowCheckedModeBanner: false,
      home: getLandingPage(), 
    );
  }
}
