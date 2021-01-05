import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:hive/hive.dart';
import 'ConfigPage.dart';
import 'OrdersPage.dart';
import 'RestaurantsPage.dart';

class BottomNav extends StatefulWidget {

  BottomNav({user});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentPage = 0;

  final List<Widget> pages = [
    RestaurantsPage(),
    OrdersPage(),
    ConfigPage()
  ];

  GlobalKey _bottomNavigationKey = GlobalKey();

  start() async {
    await Hive.openBox('cartao');
  }

  @override
  void initState() {    
    FlutterStatusbarcolor.setStatusBarColor(Colors.amber[400]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber[300],
        body: WillPopScope(
          onWillPop: () async => Future.value(false),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: pages[_currentPage],
          ),
        ),
        bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(
                iconData: Icons.restaurant,
                title: "Restaurantes",
                onclick: () {
                  final FancyBottomNavigationState fState =
                      _bottomNavigationKey.currentState;
                  fState.setPage(0);
                }),
            TabData(
                iconData: Icons.assignment_turned_in,
                title: "Pedidos",
                onclick: () {
                  final FancyBottomNavigationState fState =
                      _bottomNavigationKey.currentState;
                  fState.setPage(1);
                }),
            TabData(
                iconData: Icons.settings,
                title: "Ajustes",
                onclick: () {
                  final FancyBottomNavigationState fState =
                      _bottomNavigationKey.currentState;
                  fState.setPage(2);
                })
          ],
          onTabChangedListener: (position) {
            setState(() {
              _currentPage = position;
            });
          },
          activeIconColor: Colors.black,
          barBackgroundColor: Colors.white,
          circleColor: Colors.amber[300],
          inactiveIconColor: Colors.black,
          textColor: Colors.black,
          initialSelection: _currentPage,
          key: _bottomNavigationKey,
        ),
      ),
    );
  }
}
