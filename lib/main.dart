import 'dart:convert';

import 'package:flutter/material.dart';

import './coviddata.dart';
import './model/districtDaily.dart';
import './model/pastdata.dart';
import './model/statelist.dart';
import './widget/disaplaydata.dart';
import './widget/header.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoadingStates = false;

  CovidData covidApi;

  List<StateWise> allData;
  List<Map<String, dynamic>> pastDataState;
  List<SateWiseData> newData;
  Map<String, dynamic> dailyDistrictData;
  List<CaseTimeSeries> caseTimeLineData;

  String title = 'data';

  _loadData() async {
    setState(() {
      isLoadingStates = false;
    });

    await _fetchAllData();
    await _fetchPastDataDistrict();
    await _fetchPastDataState();
    await _fetchNewData();
  }

  @override
  void initState() {
    covidApi = new CovidData();

    _loadData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Covid19 Tracker'),
        ),
        body: Center(
          child: isLoadingStates
            ? HeaderData(caseTimeLineData: caseTimeLineData,
              totalData: allData[0],)
           
              // ? DisplayData(
              //     stateDataList: newData,
              //     pastDataState: pastDataState,
              //     dailyDistrictData: dailyDistrictData,
              //   )
              : CircularProgressIndicator(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  _fetchAllData() async {
    var result = await covidApi.fetchAllData();
    if (result.success) {
      allData = PastData.fromJson(json.decode(result.data)).oldData;
      caseTimeLineData =
          PastData.fromJson(json.decode(result.data)).caseTimeLine;

      // print('----result-->${caseTimeLineData}');

    } else {
      print('----error-->${result.message.toString()}');
    }
  }

  _fetchNewData() async {
    var result = await covidApi.fetchNewData();
    if (result.success) {
      newData = StatesList.fromJson(json.decode(result.data)).dailyStatData;

      // print("--->>todayy data--->${(currentData['confirmed'])}");
    } else {
      print('----error-->${result.message.toString()}');
    }

    setState(() {
      isLoadingStates = true;
    });
  }

  _fetchPastDataState() async {
    var result = await covidApi.fetchPastDataState();

    if (result.success) {
      var tmp = jsonDecode(result.data)['states_daily'];

      pastDataState = new List.from(tmp);

      // print('----result-->${dt[152]['date']}');

    } else {
      print('----error-->${result.message.toString()}');
    }
  }

  _fetchPastDataDistrict() async {
    var result = await covidApi.fetchPastDataDistrict();

    if (result.success) {
      dailyDistrictData =
          jsonDecode(result.data)['districtsDaily'] as Map<String, dynamic>;

      // var dummy = StatesDaily.fromJson(dailyDistrictData , 'Gujarat').stateDistData;
      // var t2 = DistrictDaily.fromJson(dummy, 'Ahmadabad').distData;

      // print('----result-->${dummy}');

    } else {
      print('----error-->${result.message.toString()}');
    }
  }
}
