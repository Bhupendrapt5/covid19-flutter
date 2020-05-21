import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/pastdata.dart';
import '../widget/chart.dart';

class HeaderData extends StatefulWidget {
  final StateWise totalData;
  final List<CaseTimeSeries> caseTimeLineData;

  const HeaderData({
    Key key,
    @required this.totalData,
    @required this.caseTimeLineData,
  }) : super(key: key);

  @override
  _HeaderDataState createState() => _HeaderDataState();
}

class _HeaderDataState extends State<HeaderData> {
  bool isLoaded = false;
  int len = 0;
  List<CaseTimeSeriesDate> dailyConfirmData = [];
  List<CaseTimeSeriesDate> dailyActiveData = [];
  List<CaseTimeSeriesDate> dailyDeathData = [];
  List<CaseTimeSeriesDate> dailyRecoveredData = [];

  Map<String, int> increase = {
    'confirmed': 0,
    'death': 0,
    'recovered': 0,
  };

  _loadData() async {
    increase['confirmed'] = int.parse(widget.totalData.confirmed) -
        int.parse(widget.caseTimeLineData[len - 1].totalconfirmed);

    increase['death'] = int.parse(widget.totalData.deaths) -
        int.parse(widget.caseTimeLineData[len - 1].totaldeceased);

    increase['recovered'] = int.parse(widget.totalData.recovered) -
        int.parse(widget.caseTimeLineData[len - 1].totalrecovered);

    for (var ele in widget.caseTimeLineData.sublist(
        widget.caseTimeLineData.length - 15, widget.caseTimeLineData.length)) {
      dailyConfirmData.add(
        new CaseTimeSeriesDate(
          DateFormat('d MMMM').parse(ele.date),
          int.parse(ele.dailyconfirmed),
        ),
      );
      dailyActiveData.add(
        new CaseTimeSeriesDate(
          DateFormat('d MMMM').parse(ele.date),
          ((int.parse(ele.dailyconfirmed)) -
              int.parse(ele.dailydeceased) -
              (ele.dailyrecovered != null ? int.parse(ele.dailyrecovered) : 0)),
        ),
      );
      dailyRecoveredData.add(
        new CaseTimeSeriesDate(
          DateFormat('d MMMM').parse(ele.date),
          (ele.dailyrecovered != null ? int.parse(ele.dailyrecovered) : 0),
        ),
      );
      dailyDeathData.add(
        new CaseTimeSeriesDate(
          DateFormat('d MMMM').parse(ele.date),
          (ele.dailydeceased != null ? int.parse(ele.dailydeceased) : 0),
        ),
      );
    }

    isLoaded = true;
  }

  @override
  void initState() {
    isLoaded = false;
    len = widget.caseTimeLineData.length;

    _loadData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? Container(
            margin: EdgeInsets.only(bottom: 30),
            width: MediaQuery.of(context).size.width,
            height: 320,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _columnData(
                        title: 'Confirmed',
                        color: Colors.red,
                        newCase: '[+${increase['confirmed']}]',
                        totalCase: widget.totalData.confirmed,
                        dailyData: dailyConfirmData,
                      ),
                      SizedBox(width: 20),
                      _columnData(
                        title: 'Active',
                        color: Colors.blue,
                        newCase: '',
                        totalCase: widget.totalData.active,
                        dailyData: dailyActiveData,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _columnData(
                        title: 'Recovered',
                        color: Colors.green,
                        newCase: '[+${increase['recovered']}]',
                        totalCase: widget.totalData.recovered,
                        dailyData: dailyRecoveredData,
                      ),
                      SizedBox(width: 20),
                      _columnData(
                        title: 'Deceased',
                        color: Colors.grey,
                        newCase: '[+${increase['death']}]',
                        totalCase: widget.totalData.deaths,
                        dailyData: dailyDeathData,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  _columnData(
      {String title,
      String newCase,
      String totalCase,
      Color color,
      List<CaseTimeSeriesDate> dailyData}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(40, 42, 61, 1),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.2),
          offset: Offset(0, 0),
          blurRadius: 10,
        )
      ],
        ),
        padding: EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _customText(text: title, fntSize: 14, fntColor: color),
            _customText(text: newCase, fntSize: 15, fntColor: color),
            _customText(text: totalCase, fntSize: 18, fntColor: color),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Charts.withSampleData(dailyData, color),
              ),
            )
          ],
        ),
      ),
    );
  }

  _customText({
    String text,
    Color fntColor = Colors.white,
    double fntSize = 12,
  }) {
    return Text(
      text,
      style: TextStyle(
        color: fntColor,
        fontSize: fntSize,
        fontFamily: 'bold',
        height: 1.4,
      ),
    );
  }
}
