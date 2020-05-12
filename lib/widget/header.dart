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
            width: MediaQuery.of(context).size.width,
            height: 150,
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
                _columnData(
                  title: 'Active',
                  color: Colors.blue,
                  newCase: '',
                  totalCase: widget.totalData.active,
                  dailyData: dailyActiveData,
                ),
                _columnData(
                  title: 'Recovered',
                  color: Colors.green,
                  newCase: '[+${increase['recovered']}]',
                  totalCase: widget.totalData.recovered,
                  dailyData: dailyRecoveredData,
                ),
                _columnData(
                  title: 'Deceased',
                  color: Colors.grey,
                  newCase: '[+${increase['death']}]',
                  totalCase: widget.totalData.deaths,
                  dailyData: dailyDeathData,
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
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _customText(text: title, fntSize: 14, fntColor: color),
          SizedBox(
            height: 10,
          ),
          _customText(text: newCase, fntSize: 15, fntColor: color),
          SizedBox(
            height: 10,
          ),
          _customText(text: totalCase, fntSize: 18, fntColor: color),
          Expanded(child: Charts.withSampleData(dailyData, color))
        ],
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
      style: TextStyle(color: fntColor, fontSize: fntSize),
    );
  }
}
