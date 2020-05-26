import 'package:covid_19_flutter/screen/bottomnavigationmenu.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyHomePage());

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid19 Tracker',
      debugShowCheckedModeBanner: false,
      home: BottomMenu(),
    );
  }
}
