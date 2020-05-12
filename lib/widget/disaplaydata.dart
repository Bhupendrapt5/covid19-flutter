import 'package:flutter/material.dart';

import '../model/statelist.dart';
import '../widget/displaystatwiseData.dart';
import '../model/districtDaily.dart';
import '../model/pastdata.dart';

class DisplayData extends StatefulWidget {
  final List<StateWiseData> stateDataList;
  final List<Map<String, dynamic>> pastDataState;
  final Map<String, dynamic> dailyDistrictData;

  final List<StateWise> dailyAllData;

  const DisplayData(
      {Key key,
      @required this.stateDataList,
      @required this.pastDataState,
      @required this.dailyDistrictData,
      this.dailyAllData})
      : super(key: key);

  @override
  _DisplayDataState createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {
  _sortData() async {
    widget.dailyAllData.sort(
        (a, b) => int.parse(b.confirmed).compareTo(int.parse(a.confirmed)));
  }

  @override
  void initState() {
    // print('${widget.dailyDistrictData}');
    _sortData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StateWiseData stateWiseData;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.dailyAllData.length,
            itemBuilder: (bCtx, index) {
              Map<String, dynamic> dummy = StatesDaily.fromJson(
                      widget.dailyDistrictData,
                      widget.dailyAllData[index].state)
                  .stateDistData;

              var result = widget.stateDataList.indexWhere((element) =>
                  element.stateCode == widget.dailyAllData[index].statecode);
              if (result >= 0) {
                stateWiseData = widget.stateDataList[result];
              } else {
                stateWiseData = new StateWiseData();
              }
              // print('${stateWiseData.stateName}');
              // print('------$index------->${widget.dailyAllData[index].statecode}');

              return Column(
                children: [
                  DisplayDistrictWiseData(
                    pastDataState: widget.pastDataState,
                    dailyDistrictData: dummy,
                    dailyAllData: widget.dailyAllData[index],
                    stateWiseData: stateWiseData,
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
