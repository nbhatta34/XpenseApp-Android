import 'package:flutter/material.dart';
import 'package:xpense_android/Screens/Dashboard.dart';
import 'package:xpense_android/Screens/LoginScreen.dart';
import 'package:xpense_android/Screens/HomeScreen.dart';
import 'package:xpense_android/Screens/RegisterScreen.dart';


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
