import 'package:covid_19_flutter/screen/indiaScreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:covid_19_flutter/res/my_flutter_app_icons.dart';
class BottomMenu extends StatefulWidget {
  //State class
  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int _pageIndex = 0;

  List<Widget> _pages = [
    IndiaCovidCases(),
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
      extendBody: true,
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
        height: MediaQuery.of(context).size.height*0.07,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Color.fromRGBO(125, 72, 245, 1),
        color: Color.fromRGBO(16, 16, 23, 1),
        items: <Widget>[
          _icons(MyFlutterApp.home),
          _icons(MyFlutterApp.globe),
          _icons(MyFlutterApp.chart_area),
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
  
  _icons(IconData icon){
    return Icon(icon, size: 30,color: Colors.white,);
  }
}
