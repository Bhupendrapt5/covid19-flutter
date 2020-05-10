import 'package:flutter/material.dart';

import '../model/pastdata.dart';
import '../model/statelist.dart';
import '../model/districtDaily.dart';


class DisplayDistrictWiseData extends StatefulWidget {
  final String stateName;
  final String stateCode;
  final List<DistrictData> districtData;
  final List<Map<String, dynamic>> pastDataState;
  final Map<String, dynamic> dailyDistrictData;

  const DisplayDistrictWiseData({
    Key key,
    @required this.stateName,
    @required this.districtData,
    @required this.stateCode,
    @required this.pastDataState,
    this.dailyDistrictData,
  }) : super(key: key);

  @override
  _DisplayDistrictWiseDataState createState() =>
      _DisplayDistrictWiseDataState();
}

class _DisplayDistrictWiseDataState extends State<DisplayDistrictWiseData> {
  bool isExpanded = false;
  bool isLoaded = false;

  int confrmTotal = 0;
  int actvTotal = 0;
  int recvrdTotal = 0;
  int decdTotal = 0;

  int confrmNew = 0;
  int recvrdNew = 0;
  int decdNew = 0;
  List<Map<String, dynamic>> completeMap = [];
  Future<PastData> pastData;

  // CovidData covidApi;

  _loadData() async {
    int confrmPast = 0;
    int recvrdPast = 0;
    int decdPast = 0;

    widget.districtData.forEach((element) {
      confrmTotal = confrmTotal + element.confirmed;
      actvTotal = actvTotal + element.active;
      recvrdTotal = recvrdTotal + element.recovered;
      decdTotal = decdTotal + element.deceased;
    });

    widget.pastDataState.asMap().forEach((key, value) {
      if (value['status'] == 'Confirmed' && value[widget.stateCode] != '') {
        confrmPast = confrmPast + int.tryParse(value[widget.stateCode]);
      }

      if (value['status'] == 'Recovered') {
        recvrdPast = recvrdPast + int.tryParse(value[widget.stateCode]);
      }

      if (value['status'] == 'Deceased') {
        decdPast = decdPast + int.tryParse(value[widget.stateCode]);
      }
    });

    recvrdNew =
        (recvrdTotal - recvrdPast) >= 0 ? (recvrdTotal - recvrdPast) : 0;
    confrmNew =
        (confrmTotal - confrmPast) >= 0 ? (confrmTotal - confrmPast) : 0;
    decdNew = (decdTotal - decdPast) >= 0 ? (decdTotal - decdPast) : 0;

    // print("Today's case in ${widget.stateName}");
    // print(
    //     'newConfirm : $confrmNew - new decd : $decdNew - new recvrd: $recvrdNew -  ');
    // print(
    //     'Confirm old: ${(confrmPast)} - decdold : ${(decdPast)} - recvrd ol: ${(recvrdPast)} -  ');
    // print(
    //     'Confirm: ${(confrmTotal)} - decd : ${(decdTotal)} - recvrd: ${(recvrdTotal)} -  ');

    if (this.mounted) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  void initState() {
    isLoaded = false;

    _loadData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double textWidth = MediaQuery.of(context).size.width;

    return Container(
      width: textWidth,
      child: isLoaded
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    color: Colors.blueGrey,
                    padding: const EdgeInsets.all(3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              isExpanded
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_right,
                              size: 18,
                            ),
                            Container(
                              padding: EdgeInsets.all(1),
                              width: textWidth * 0.25,
                              child: _myText(
                                  text: widget.stateName,
                                  fntsz: 13,
                                  isBold: true,
                                  color: Colors.white,
                                  isAlignRight: false),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 1, bottom: 1, left: 8, right: 3),
                              width: textWidth * 0.17,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  _myText(
                                    text: confrmNew > 0
                                        ? '+' + confrmNew.toString()
                                        : '',
                                    fntsz: 12,
                                    isBold: true,
                                    color: Colors.red,
                                  ),
                                  _myText(
                                    text: confrmTotal.toString(),
                                    fntsz: 14,
                                    isBold: true,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(1),
                              width: textWidth * 0.17,
                              child: _myText(
                                text: actvTotal.toString(),
                                fntsz: 13,
                                isBold: true,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 1, bottom: 1, left: 8, right: 3),
                              width: textWidth * 0.17,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  _myText(
                                    text: recvrdNew > 0
                                        ? '+' + recvrdNew.toString()
                                        : '',
                                    fntsz: 12,
                                    isBold: true,
                                    color: Colors.green,
                                  ),
                                  _myText(
                                    text: recvrdTotal.toString(),
                                    fntsz: 14,
                                    isBold: true,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 1, bottom: 1, left: 8, right: 3),
                              width: textWidth * 0.17,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  _myText(
                                    text: decdNew > 0
                                        ? '+' + decdNew.toString()
                                        : '',
                                    fntsz: 12,
                                    isBold: true,
                                    color: Colors.grey,
                                  ),
                                  _myText(
                                    text: decdTotal.toString(),
                                    fntsz: 14,
                                    isBold: true,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                ),
                Visibility(
                  visible: isExpanded,
                  child: Container(
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.districtData.length,
                      itemBuilder: (bCtx, index) {
                        var t2 = DistrictDaily.fromJson(
                                widget.dailyDistrictData,
                                widget.districtData[index].districtName)
                            .distData;
                        // print('--------data---->${t2[t2.length-1]}');
                        return cardView(
                            dName: widget.districtData[index].districtName,
                            active: widget.districtData[index].active,
                            confirmed: widget.districtData[index].confirmed,
                            deceased: widget.districtData[index].deceased,
                            recovered: widget.districtData[index].recovered,
                            dailyData: t2);
                      },
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget cardView(
      {String dName,
      int active,
      int recovered,
      int deceased,
      int confirmed,
      List<DistrictDataDaily> dailyData}) {
    // print('-----$dName-----${dailyData.length}');

    var nCnfrm = 0;
    var nDecsd = 0;
    var nrecvrd = 0;

    if (dailyData.length != 1) {
      nCnfrm = confirmed - dailyData[dailyData.length - 2].confirmed;
      nDecsd = deceased - dailyData[dailyData.length - 2].deceased;
      nrecvrd = recovered - dailyData[dailyData.length - 2].recovered;
    }

    // print('-----$dName-----${dailyData[dailyData.length-1].date}---${dailyData[dailyData.length-1].confirmed}');
    // print('-----today-----${confirmed}');

    return Card(
      color: Colors.blueGrey,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 5,
          bottom: 3,
          right: 5,
          top: 3,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(1),
              child: _myText(
                text: dName,
                fntsz: 12,
                isBold: true,
                isAlignRight: false,
              ),
            ),
            SizedBox(
              width: 2,
            ),
            Container(
              padding: EdgeInsets.all(1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _myText(
                    text: nCnfrm > 0 ? '+' + nCnfrm.toString() : '',
                    fntsz: 12,
                    isBold: true,
                    color: Colors.red,
                  ),
                  _myText(
                    text: confirmed.toString(),
                    fntsz: 14,
                    isBold: true,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 2,
            ),
            Container(
              padding: EdgeInsets.all(1),
              child: _myText(
                text: active.toString(),
                fntsz: 12,
                isBold: true,
              ),
            ),
            Container(
              padding: EdgeInsets.all(1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _myText(
                    text: nrecvrd > 0 ? '+' + nrecvrd.toString() : '',
                    fntsz: 12,
                    isBold: true,
                    color: Colors.green,
                  ),
                  _myText(
                    text: recovered.toString(),
                    fntsz: 14,
                    isBold: true,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 2,
            ),
            Container(
              padding: EdgeInsets.all(1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _myText(
                    text: nDecsd > 0 ? '+' + nDecsd.toString() : '',
                    fntsz: 12,
                    isBold: true,
                    color: Colors.grey,
                  ),
                  _myText(
                    text: deceased.toString(),
                    fntsz: 14,
                    isBold: true,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
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
