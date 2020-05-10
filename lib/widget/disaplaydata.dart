import 'package:flutter/material.dart';

import '../model/statelist.dart';
import '../widget/displaystatwiseData.dart';
import '../model/districtDaily.dart';


class DisplayData extends StatefulWidget {
  final List<SateWiseData> stateDataList;
  final List<Map<String, dynamic>> pastDataState;
  final Map<String, dynamic> dailyDistrictData;

  const DisplayData({
    Key key,
    @required this.stateDataList,
    @required this.pastDataState,
    @required this.dailyDistrictData,
  }) : super(key: key);

  @override
  _DisplayDataState createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {
  @override
  void initState() {
    // print('${widget.dailyDistrictData}');
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
                  child: _myText(text: 'State/UT', isAlignRight: false),
                ),
                Container(
                  padding: EdgeInsets.all(1),
                  width: textWidth * 0.15,
                  child: _myText(
                    text: 'Cnfrmd',
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(1),
                  width: textWidth * 0.15,
                  child: _myText(
                    text: 'Actv',
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(1),
                  width: textWidth * 0.15,
                  child: _myText(
                    text: 'Rcvrd',
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(1),
                  width: textWidth * 0.15,
                  child: _myText(
                    text: 'Dcsd',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.stateDataList.length,
              itemBuilder: (bCtx, index) {

                Map<String, dynamic> dummy = StatesDaily.fromJson(
                        widget.dailyDistrictData,
                        widget.stateDataList[index].stateName)
                    .stateDistData;

                // print('${widget.dailyDistrictData}');

                return Column(
                  children: [
                    // ListTile(
                    //     title: Text(widget.stateDataList[index].stateName),
                    // ),
                    DisplayDistrictWiseData(
                      stateCode:
                          widget.stateDataList[index].stateCode.toLowerCase(),
                      stateName: widget.stateDataList[index].stateName,
                      districtData: widget.stateDataList[index].districtData,
                      pastDataState: widget.pastDataState,
                      dailyDistrictData: dummy,
                    ),
                    SizedBox(
                      height: 1,
                    )
                  ],
                );
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
      double fntsz = 12,
      bool isBold = true,
      bool isAlignRight = true}) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fntsz,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
      textAlign: isAlignRight ? TextAlign.right : TextAlign.left,
    );
  }
}
