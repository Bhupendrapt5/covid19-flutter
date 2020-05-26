import 'dart:convert';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter/material.dart';
import '../coviddata.dart';
import '../model/pastdata.dart';
import '../model/statelist.dart';
import '../widget/disaplaydata.dart';
import '../widget/header.dart';

class IndiaCovidCases extends StatefulWidget {
  IndiaCovidCases({Key key}) : super(key: key);

  @override
  _IndiaCovidCasesState createState() => _IndiaCovidCasesState();
}

class _IndiaCovidCasesState extends State<IndiaCovidCases> {
  bool isLoadingStates = false;

  CovidData covidApi;

  List<StateWise> allData;
  List<Map<String, dynamic>> pastDataState;
  List<StateWiseData> newData;
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
    print('=======>>>>>>>>init called');
    _loadData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var myWidth = MediaQuery.of(context).size.width;
    var myHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 28, 40, 1),
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
                  // SizedBox(height: myHeight * 0.02),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: isLoadingStates
                  ? Column(
                      children: <Widget>[
                        HeaderData(
                          caseTimeLineData: caseTimeLineData,
                          totalData: allData[0],
                        ),
                        StickyHeader(
                          header: tableHeader(context),
                          content: DisplayData(
                            stateDataList: newData,
                            pastDataState: pastDataState,
                            dailyDistrictData: dailyDistrictData,
                            dailyAllData: allData,
                          ),
                        ),
                      ],
                    )
                  : CircularProgressIndicator(),
            ),
          ],
        ),
      ),
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
    if (this.mounted) {
      setState(() {
        isLoadingStates = true;
      });
    }
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

  Widget tableHeader(context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Color.fromRGBO(16, 16, 23, 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10),
            width: MediaQuery.of(context).size.width * 0.33,
            child: Wrap(
              children: <Widget>[
                nameText(context, 'STATE', Colors.white),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.53,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  // color: Colors.blueAccent,
                  width: 50,
                  child: nameText(context, 'C', Colors.red),
                ),
                Container(
                  width: 50,
                  // color: Colors.orangeAccent,
                  child: nameText(context, 'A', Colors.blue),
                ),
                Container(
                  // color: Colors.redAccent,
                  width: 50,
                  child: nameText(context, 'R', Colors.green),
                ),
                Container(
                  // color: Colors.greenAccent,
                  width: 50,
                  child: nameText(context, 'D', Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget nameText(context, text, Color color) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 15,
      color: color,
      fontFamily: 'bold',
    ),
    textAlign: TextAlign.center,
  );
}
