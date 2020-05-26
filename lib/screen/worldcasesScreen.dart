import 'dart:convert';

import 'package:covid_19_flutter/model/country_covid_model.dart';
import 'package:covid_19_flutter/res/coviddata.dart';
import 'package:covid_19_flutter/widget/CountryItem.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class WorldDataScreen extends StatefulWidget {
  @override
  _WorldDataScreenState createState() => _WorldDataScreenState();
}

class _WorldDataScreenState extends State<WorldDataScreen> {
  bool isLoadingStates = false;

  CovidData covidApi;

  List<CountryCovidModel> worldCovidList = [];

  _loadData() async {
    await _getWorldCovidData();

    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    covidApi = new CovidData();
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 28, 40, 1),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: worldCovidList.length == 0
            ? Center(
                child: nameText('Loading....', Colors.white),
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  var url = 'https://www.countryflags.io/' +
                      worldCovidList[index].countryCode.toLowerCase() +
                      '/flat/64.png';
                  // print('-----$index----->>${countryInfo[4]['name']}');
                  return CountryItemData(
                    countryData: worldCovidList[index],
                    imgUrl: url,
                  );
                  //  ListTile(
                  //   leading: CircleAvatar(
                  //     child: Image.network(url),
                  //   ),
                  //   title: Text(
                  //     worldCovidList[index].countryName,
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  //   subtitle: Text(
                  //     worldCovidList[index].confirmedTotal.toString(),
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  // );
                },
                itemCount: worldCovidList.length,
                // shrinkWrap: true,
              ),
      ),
    );
  }

  _getWorldCovidData() async {
    var result = await covidApi.worldCovidData();
    if (result.success) {
      worldCovidList =
          WorldCovidData.fromJson(json.decode(result.data)).countryListModel;
      worldCovidList.sort(
        (b, a) => a.confirmedTotal.compareTo(b.confirmedTotal),
      );
      // print('----result-->${worldCovidList}');
    } else {
      print('----error-->${result.message.toString()}');
    }
  }

  Widget tableHeader(context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Color.fromRGBO(16, 16, 23, 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10),
            width: MediaQuery.of(context).size.width * 0.33,
            child: Wrap(
              children: <Widget>[
                nameText('COUNTRY', Colors.white),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.53,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 50,
                  child: nameText('C', Colors.red),
                ),
                Container(
                  width: 50,
                  child: nameText('R', Colors.green),
                ),
                Container(
                  width: 50,
                  child: nameText('D', Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget nameText(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
        color: color,
        fontFamily: 'bold',
      ),
      textAlign: TextAlign.center,
    );
  }
}
