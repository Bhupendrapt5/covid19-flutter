
import 'package:flutter/material.dart';


import '../coviddata.dart';
import './displaystatwiseData.dart';

import '../model/pastdata.dart';
import '../model/statelist.dart';

class DisplayData extends StatefulWidget {

  final List<dynamic> stateDataList;

  const DisplayData({Key key, this.stateDataList}) : super(key: key);

  @override
  _DisplayDataState createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {


  Future<PastData> pastData;

  CovidData covidApi;

  @override
  void initState() {


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double textWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 10,
              bottom: 5,
              top: 5,
            ),
            color: Colors.indigo,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(1),
                  width: textWidth * 0.30,
                  child: _myText(
                      text: 'State/UT',
                      fntsz: 12,
                      isBold: true,
                      color: Colors.white,
                      isAlignRight: false),
                ),
                Container(
                  padding: EdgeInsets.all(1),
                  width: textWidth * 0.15,
                  child: _myText(
                    text: 'Cnfrmd',
                    fntsz: 12,
                    isBold: true,
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(1),
                  width: textWidth * 0.15,
                  child: _myText(
                    text: 'Actv',
                    fntsz: 12,
                    isBold: true,
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(1),
                  width: textWidth * 0.15,
                  child: _myText(
                    text: 'Rcvrd',
                    fntsz: 12,
                    isBold: true,
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(1),
                  width: textWidth * 0.15,
                  child: _myText(
                    text: 'Dcsd',
                    fntsz: 12,
                    isBold: true,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.stateDataList.length,
              itemBuilder: (bCtx, index) {
                var stateData = StatesList.fromJson(widget.stateDataList[index]);
                return Column(
                  children: [
                    StateWiseData(
                      districtData: stateData.districtData,
                      stateName: stateData.stateName,
                      stateCode: stateData.stateCode.toLowerCase(),
                    ),
                    SizedBox(
                      height: 1,
                    )
                  ],
                );
                // Text(stateData.districtData.toString());
              },
            ),
          ),
        ],
      ),
    );
  }

  _myText(
      {String text,
      Color color = Colors.white,
      double fntsz,
      bool isBold = false,
      bool isAlignRight = true}) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: fntsz,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
      textAlign: isAlignRight ? TextAlign.right : TextAlign.left,
    );
  }
}
