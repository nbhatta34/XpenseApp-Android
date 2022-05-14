import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:xpense_android/Screens/RegisterScreen.dart';


=======
import 'package:xpense_android/Screens/LoginScreen.dart';

>>>>>>> login
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
<<<<<<< HEAD
      home: RegisterScreen(),
=======
      home: LoginScreen(),
>>>>>>> login
    );
  }
}
