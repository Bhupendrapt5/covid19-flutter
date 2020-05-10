import 'package:flutter/material.dart';

import '../model/pastdata.dart';
import '../coviddata.dart';
import '../model/districtdata.dart';

class StateWiseData extends StatefulWidget {
  final String stateName;
  final String stateCode;
  final List<dynamic> districtData;

  const StateWiseData(
      {Key key, this.stateName, this.districtData, this.stateCode})
      : super(key: key);

  @override
  _StateWiseDataState createState() => _StateWiseDataState();
}

class _StateWiseDataState extends State<StateWiseData> {
  bool isExpanded = false;
  bool isLoaded = false;

  int confrmTotal = 0;
  int actvTotal = 0;
  int recvrdTotal = 0;
  int decdTotal = 0;

  int confrmPast = 0;
  int recvrdPast = 0;
  int decdPast = 0;

  int confrmNew = 0;
  int recvrdNew = 0;
  int decdNew = 0;

  Future<PastData> pastData;

  CovidData covidApi;

  _loadData() async {
    widget.districtData.asMap().forEach((key, value) {
      Map<String, dynamic> tmp = value;
      confrmTotal = confrmTotal + tmp['confirmed'];
      actvTotal = actvTotal + tmp['active'];
      recvrdTotal = recvrdTotal + tmp['recovered'];
      decdTotal = decdTotal + tmp['deceased'];
    });

    pastData = covidApi.fetchOldData();

    await pastData.then((value) async {
      value.oldData.asMap().forEach((key, value) {
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
    covidApi = new CovidData();
    setState(() {
      isLoaded = false;
    });

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
                                nameText(context, widget.stateName),
                              ],
                            ),
                          ),
                          Container(
                            width: textWidth * 0.53,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                VerticalDivider(color: Colors.white,width: 3, ),
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
                        var distData =
                            DistrictData.fromJson(widget.districtData[index]);
                        return cardView(
                          dName: distData.districtName,
                          active: distData.active,
                          confirmed: distData.confirmed,
                          deceased: distData.deceased,
                          recovered: distData.recovered,
                        );
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

  Widget cardView({
    String dName,
    int active,
    int recovered,
    int deceased,
    int confirmed,
  }) {
    return Card(
      elevation: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.blueGrey,
            padding: EdgeInsets.all(1),
            child: _myText(
              text: dName,
              fntsz: 12,
              isBold: true,
              isAlignRight: false,
            ),
          ),
          Container(
            padding: EdgeInsets.all(1),
            color: Colors.blueGrey,
            child: _myText(
              text: confirmed.toString(),
              fntsz: 12,
              isBold: true,
            ),
          ),
          Container(
            padding: EdgeInsets.all(1),
            color: Colors.blueGrey,
            child: _myText(
              text: active.toString(),
              fntsz: 12,
              isBold: true,
            ),
          ),
          Container(
            padding: EdgeInsets.all(1),
            color: Colors.blueGrey,
            child: _myText(
              text: recovered.toString(),
              fntsz: 12,
              isBold: true,
            ),
          ),
          Container(
            padding: EdgeInsets.all(1),
            color: Colors.blueGrey,
            child: _myText(
              text: deceased.toString(),
              fntsz: 12,
              isBold: true,
            ),
          ),
        ],
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
