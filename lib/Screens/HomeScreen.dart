
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:xpense_android/Screens/Dashboard.dart';
import 'package:xpense_android/Screens/Profile.dart';
import 'package:xpense_android/Screens/Settings.dart';
import 'package:xpense_android/Screens/Statistics.dart';
import 'package:xpense_android/Screens/Stocks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var currentIndex = 0;

  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  final screens = [
    DashBoard(),
    Statistics(),
    Stocks(),
    Profile(),
    Settings(),
  ];

  final items = <Widget>[
    Icon(
      Icons.dashboard,
      size: 25,
    ),
    Icon(
      Icons.bar_chart,
      size: 25,
    ),
    Icon(
      Icons.production_quantity_limits_rounded,
      size: 25,
    ),
    Icon(
      Icons.person,
      size: 25,
    ),
    Icon(
      Icons.settings,
      size: 25,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // extendBody: true,
        bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(iconTheme: IconThemeData(color: Colors.white)),
          child: CurvedNavigationBar(
            key: navigationKey,
            buttonBackgroundColor: Colors.deepOrange,
            backgroundColor: Colors.transparent,
            color: Color(0xff3099EC),
            items: items,
            height: 50,
            animationDuration: Duration(milliseconds: 300),
            index: currentIndex,
            onTap: (index) {
              setState(
                () {
                  currentIndex = index;
                },
              );
            },
          ),
        ),
        body: screens[currentIndex],
      ),
    );
  }

  
}
