
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomMenu extends StatefulWidget {
  //State class
  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int _pageIndex = 0;

  List<Widget> _pages = [
    Center(
      child: Text('page 1'),
    ),
    Center(
      child: Text('page 2'),
    ),
    Center(
      child: Text('page 3'),
    ),
  ];
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Covid 19 Tracker',
          style: TextStyle(
            fontFamily: 'regular',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromRGBO(16, 16, 23, 1),
        elevation: 0,
        leading: Icon(Icons.sort),
      ),

      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        // backgroundColor: Color.fromRGBO(60, 60, 92, 1),
        buttonBackgroundColor: Colors.white,
        color: Color.fromRGBO(60, 60, 92, 1),
        items: <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.compare_arrows, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
      body: _pages[_pageIndex],
    );
  }
}
