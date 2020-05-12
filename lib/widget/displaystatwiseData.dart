import 'package:covid_19_flutter/widget/disaplaydata.dart';
import 'package:flutter/material.dart';

import '../model/pastdata.dart';
import '../model/statelist.dart';
import '../model/districtDaily.dart';

class DisplayDistrictWiseData extends StatefulWidget {

  final StateWiseData stateWiseData;
  final List<Map<String, dynamic>> pastDataState;
  final Map<String, dynamic> dailyDistrictData;

  final StateWise dailyAllData;

  const DisplayDistrictWiseData(
      {Key key,
      @required this.stateWiseData,
      @required this.pastDataState,
      @required this.dailyDistrictData,
      @required this.dailyAllData})
      : super(key: key);

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

  int districtLen;

  _loadData() async {
    int confrmPast = 0;
    int recvrdPast = 0;
    int decdPast = 0;

    // widget.stateWiseData.districtData.forEach((element) {
    confrmTotal = int.parse(widget.dailyAllData.confirmed);
    actvTotal = int.parse(widget.dailyAllData.active);
    recvrdTotal = int.parse(widget.dailyAllData.recovered);
    decdTotal = int.parse(widget.dailyAllData.deaths);
    // });

    if (widget.stateWiseData.stateName != null) {
      widget.stateWiseData.districtData.sort((a, b) => b.confirmed.compareTo(a.confirmed));
      widget.pastDataState.asMap().forEach((key, value) {
        if (value['status'] == 'Confirmed' &&
            value[widget.stateWiseData.stateCode.toLowerCase()] != '') {
          confrmPast = confrmPast +
              int.tryParse(value[widget.stateWiseData.stateCode.toLowerCase()]);
        }

        if (value['status'] == 'Recovered') {
          recvrdPast = recvrdPast +
              int.tryParse(value[widget.stateWiseData.stateCode.toLowerCase()]);
        }

        if (value['status'] == 'Deceased') {
          decdPast = decdPast +
              int.tryParse(value[widget.stateWiseData.stateCode.toLowerCase()]);
        }
      });

      recvrdNew =
          (recvrdTotal - recvrdPast) >= 0 ? (recvrdTotal - recvrdPast) : 0;
      confrmNew =
          (confrmTotal - confrmPast) >= 0 ? (confrmTotal - confrmPast) : 0;
      decdNew = (decdTotal - decdPast) >= 0 ? (decdTotal - decdPast) : 0;
    }
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
    districtLen = widget.stateWiseData.districtData != null 
    ? widget.stateWiseData.districtData.length : 0;
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
                  child: SizedBox(
                    width: textWidth,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(40, 42, 61, 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      margin: EdgeInsets.only(bottom: 2),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            width: textWidth * 0.33,
                            child: Wrap(
                              children: <Widget>[
                                nameText(context, widget.dailyAllData.state),
                              ],
                            ),
                          ),
                          Container(
                            width: textWidth * 0.53,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                VerticalDivider(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                Container(
                                  // color: Colors.blueAccent,
                                  width: 50,
                                  child: Column(
                                    children: <Widget>[
                                      if (confrmNew > 0)
                                        newCaseText(
                                          context,
                                          '+' + confrmNew.toString(),
                                          Colors.red,
                                        ),
                                      nameText(context, confrmTotal.toString())
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  // color: Colors.orangeAccent,
                                  child: Column(
                                    children: <Widget>[
                                      nameText(context, actvTotal.toString()),
                                    ],
                                  ),
                                ),
                                Container(
                                  // color: Colors.redAccent,
                                  width: 50,
                                  child: Column(
                                    children: <Widget>[
                                      if (recvrdNew > 0)
                                        newCaseText(
                                          context,
                                          '+' + recvrdNew.toString(),
                                          Colors.green,
                                        ),
                                      nameText(context, recvrdTotal.toString())
                                    ],
                                  ),
                                ),
                                Container(
                                  // color: Colors.greenAccent,
                                  width: 50,
                                  child: Column(
                                    children: <Widget>[
                                      if (decdNew > 0)
                                        newCaseText(
                                          context,
                                          '+' + decdNew.toString(),
                                          Colors.grey,
                                        ),
                                      nameText(context, decdTotal.toString())
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      if (widget.stateWiseData.stateName != null) {
                        isExpanded = !isExpanded;
                      }
                    });
                  },
                ),
                Visibility(
                  visible: isExpanded,
                  child: Container(
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: districtLen,
                      itemBuilder: (bCtx, index) {
                        var t2 = DistrictDaily.fromJson(
                                widget.dailyDistrictData,
                                widget.stateWiseData.districtData[index]
                                    .districtName)
                            .distData;
                        // print('--------data---->${t2[t2.length-1]}');
                        return cardView(
                            dName: widget
                                .stateWiseData.districtData[index].districtName,
                            active:
                                widget.stateWiseData.districtData[index].active,
                            confirmed: widget
                                .stateWiseData.districtData[index].confirmed,
                            deceased: widget
                                .stateWiseData.districtData[index].deceased,
                            recovered: widget
                                .stateWiseData.districtData[index].recovered,
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

  Widget nameText(context, text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        color: Color.fromRGBO(194, 197, 210, 1),
        fontFamily: 'semiBold',
      ),
      // textAlign: TextAlign.center,
    );
  }

  Widget newCaseText(context, text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        color: color,
        fontFamily: 'semiBold',
      ),
      textAlign: TextAlign.center,
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
