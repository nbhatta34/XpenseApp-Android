import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpense_android/Screens/AddStocks.dart';

class Stocks extends StatefulWidget {
  const Stocks({Key? key}) : super(key: key);

  @override
  State<Stocks> createState() => _StocksState();
}

class _StocksState extends State<Stocks> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddStock(),
              ),
            );
          },
          child: Icon(
            Icons.addchart_rounded,
          ),
        ),
        body: Container(child: Center(child: Text("Stocks"))),
      ),
    );
  }
}
