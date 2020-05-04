import 'package:covid_19_flutter/model/districtdata.dart';
import 'package:covid_19_flutter/model/statelist.dart';
import 'package:flutter/material.dart';

class DisplayData extends StatelessWidget {
  final List<dynamic> stateDataList;

  const DisplayData({Key key, this.stateDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double textWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Column(mainAxisSize: MainAxisSize.max, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  color: Colors.blueGrey,
                  padding: EdgeInsets.all(1),
                  width: textWidth * 0.30,
                  child: _myText(
                    text: 'State/UT',
                    fntsz: 12,
                    isBold: true,
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(1),
                  width: textWidth * 0.15,
                  color: Colors.blueGrey,
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
                  color: Colors.blueGrey,
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
                  color: Colors.blueGrey,
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
                  color: Colors.blueGrey,
                  child: _myText(
                    text: 'Dcsd',
                    fntsz: 12,
                    isBold: true,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: stateDataList.length,
            itemBuilder: (bCtx, index) {
              var stateData = StatesList.fromJson(stateDataList[index]);
              return StateWiseData(
                districtData: stateData.districtData,
                stateName: stateData.stateName,
              );
              // Text(stateData.districtData.toString());
            },
          ),
        ),
      ]),
    );
  }

  _myText({
    String text,
    Color color = Colors.white,
    double fntsz,
    bool isBold = false,
  }) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: fntsz,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
    );
  }
}

class StateWiseData extends StatefulWidget {
  final String stateName;
  final List<dynamic> districtData;

  const StateWiseData({
    Key key,
    this.stateName,
    this.districtData,
  }) : super(key: key);

  @override
  _StateWiseDataState createState() => _StateWiseDataState();
}

class _StateWiseDataState extends State<StateWiseData> {
  bool isExpanded = false;
  bool isLoaded = false;
  int confrmTotal = 0;
  int actvTotal = 0;
  int revrdTotal = 0;
  int decdTotal = 0;

  _loadData() async {
    widget.districtData.asMap().forEach((key, value) {
      Map<String, dynamic> tmp = value;
      confrmTotal = confrmTotal + tmp['confirmed'];
      actvTotal = actvTotal + tmp['active'];
      revrdTotal = revrdTotal + tmp['recovered'];
      decdTotal = decdTotal + tmp['deceased'];
    });
  }

  @override
  void initState() {
    setState(() {
      isLoaded = false;
    });
    _loadData();

    setState(() {
      isLoaded = true;
    });
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
                              color: Colors.blueGrey,
                              padding: EdgeInsets.all(1),
                              width: textWidth * 0.30,
                              child: _myText(
                                text: widget.stateName,
                                fntsz: 14,
                                isBold: true,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(1),
                              width: textWidth * 0.15,
                              color: Colors.blueGrey,
                              child: _myText(
                                text: confrmTotal.toString(),
                                fntsz: 14,
                                isBold: true,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(1),
                              width: textWidth * 0.15,
                              color: Colors.blueGrey,
                              child: _myText(
                                text: actvTotal.toString(),
                                fntsz: 14,
                                isBold: true,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(1),
                              width: textWidth * 0.15,
                              color: Colors.blueGrey,
                              child: _myText(
                                text: revrdTotal.toString(),
                                fntsz: 14,
                                isBold: true,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(1),
                              width: textWidth * 0.15,
                              color: Colors.blueGrey,
                              child: _myText(
                                text: decdTotal.toString(),
                                fntsz: 14,
                                isBold: true,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        // Row(
                        //   children: <Widget>[
                        //     Container(
                        //       padding: EdgeInsets.all(1),
                        //       width: textWidth * 0.15,
                        //       color: Colors.blueGrey,
                        //        child: Text(
                        //         '1111111',
                        //         style: TextStyle(fontSize: 14),
                        //         textAlign: TextAlign.left,
                        //       ),
                        //     ),
                        //     Container(
                        //       padding: EdgeInsets.all(1),
                        //       width: textWidth * 0.15,
                        //       color: Colors.blueGrey,
                        //        child: Text(
                        //         '1111111',
                        //         style: TextStyle(fontSize: 14),
                        //         textAlign: TextAlign.left,
                        //       ),
                        //     ),
                        //     Container(
                        //       padding: EdgeInsets.all(1),
                        //       width: textWidth * 0.15,
                        //       color: Colors.blueGrey,
                        //       child: Text(
                        //         '1111111',
                        //         style: TextStyle(fontSize: 14),
                        //         textAlign: TextAlign.left,
                        //       ),
                        //     ),
                        //     Container(
                        //       padding: EdgeInsets.all(1),
                        //       width: textWidth * 0.15,
                        //       color: Colors.blueGrey,
                        //        child: Text(
                        //         '1111111',
                        //         style: TextStyle(fontSize: 14),
                        //         textAlign: TextAlign.left,
                        //       ),
                        //     ),
                        //   ],
                        // ),
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
                        var distData =
                            DistrictData.fromJson(widget.districtData[index]);
                        // actvTotal = actvTotal + distData.active;
                        // revrdTotal = revrdTotal + distData.recovered;
                        // confrmTotal = confrmTotal + distData.confirmed;
                        // decdTotal = decdTotal + distData.deceased;
                        // print('------${widget.stateName}---');
                        // print("==cnf : ${confrmTotal}==actv: ${actvTotal}==recvd: ${revrdTotal}==decsd: ${decdTotal}");
                        // return Text(distData.confirmed.toString()+" in "+distData.districtName);
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
              color: Colors.white,
            ),
          ),
          Container(
            padding: EdgeInsets.all(1),
            color: Colors.blueGrey,
            child: _myText(
              text: confirmed.toString(),
              fntsz: 12,
              isBold: true,
              color: Colors.white,
            ),
          ),
          Container(
            padding: EdgeInsets.all(1),
            color: Colors.blueGrey,
            child: _myText(
              text: active.toString(),
              fntsz: 12,
              isBold: true,
              color: Colors.white,
            ),
          ),
          Container(
            padding: EdgeInsets.all(1),
            color: Colors.blueGrey,
            child: _myText(
              text: recovered.toString(),
              fntsz: 12,
              isBold: true,
              color: Colors.white,
            ),
          ),
          Container(
            padding: EdgeInsets.all(1),
            color: Colors.blueGrey,
            child: _myText(
              text: deceased.toString(),
              fntsz: 12,
              isBold: true,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  _myText({
    String text,
    Color color = Colors.white,
    double fntsz,
    bool isBold = false,
  }) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: fntsz,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
    );
  }
}
