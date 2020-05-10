import 'package:covid_19_flutter/widget/disaplaydata.dart';
import 'package:flutter/material.dart';

import './model/state_model.dart';
import 'coviddata.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid_19',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Covid19 Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<States> statesData;

  CovidData covidApi = new CovidData();

  @override
  void initState() {
    print("init state");

    statesData = covidApi.fetchNewData();

    super.initState();
  }

  void _refreshData() {
    print('Loading new data');
    statesData = covidApi.fetchNewData();
  }

  @override
  Widget build(BuildContext context) {
    var myWidth = MediaQuery.of(context).size.width;
    var myHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 28, 40, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(16, 16, 23, 1),
        elevation: 0,
        // title: Text(widget.title, style: TextStyle(fontFamily: 'regular'),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshData,
          )
        ],
        leading: Icon(Icons.sort),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: myWidth,
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.only(
                  bottomLeft: const Radius.circular(40.0),
                  bottomRight: const Radius.circular(40.0),
                ),
                color: Color.fromRGBO(16, 16, 23, 1),
              ),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Covid 19 Tracker',
                    style: TextStyle(
                      fontFamily: 'regular',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: myHeight * 0.03),
                  Text(
                    'India',
                    style: TextStyle(
                      fontFamily: 'bold',
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: myHeight * 0.005),
                  Text(
                    'Last updated 1 hour ago',
                    style: TextStyle(
                      fontFamily: 'regular',
                      fontSize: 15,
                      color: Colors.grey[300],
                    ),
                  ),
                  SizedBox(height: myHeight * 0.05),
                ],
              ),
            ),
            SizedBox(
              child: Container(
                padding: EdgeInsets.all(20),
                child: FutureBuilder<States>(
                  future: statesData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return DisplayData(
                        stateDataList: snapshot.data.states,
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    // By default, show a loading spinner.
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      // body: Container(
      //   child: FutureBuilder<States>(
      //     future: statesData,
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData) {
      //         return Padding(
      //           padding: const EdgeInsets.only(bottom: 10),
      //           child: DisplayData(
      //             stateDataList: snapshot.data.states,
      //           ),
      //         );
      //       } else if (snapshot.hasError) {
      //         return Text("${snapshot.error}");
      //       }

      //       // By default, show a loading spinner.
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     },
      //   ),
      // ),
    );
  }
}
