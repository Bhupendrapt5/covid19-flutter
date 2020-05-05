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
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _refreshData,
            )
          ],
        ),
        body: Container(
          child: FutureBuilder<States>(
            future: statesData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: DisplayData(
                    stateDataList: snapshot.data.states,
                  ),
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
    );
  }
}
