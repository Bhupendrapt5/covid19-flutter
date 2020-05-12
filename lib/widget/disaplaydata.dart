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

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
        
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
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
        ],
      ),
    );
  }
}
