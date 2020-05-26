import 'package:covid_19_flutter/model/country_covid_model.dart';
import 'package:flutter/material.dart';

class CountryItemData extends StatelessWidget {
  final CountryCovidModel countryData;
  final String imgUrl;

  const CountryItemData({Key key, this.countryData, this.imgUrl})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double textWidth = MediaQuery.of(context).size.width;

    return Container(
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
                height: textWidth *0.1,
                width: textWidth *0.08,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill, image: new NetworkImage(imgUrl)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                width: textWidth * 0.33,
                child: Wrap(
                  children: <Widget>[
                    nameText(context, countryData.countryName),
                  ],
                ),
              ),
              Container(
                width: textWidth * 0.53,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    VerticalDivider(
                      color: Colors.white,
                      width: 3,
                    ),
                    Container(
                      width: 50,
                      child: Column(
                        children: <Widget>[
                          if (countryData.confirmNew > 0)
                            newCaseText(
                              context,
                              '+' + countryData.confirmNew.toString(),
                              Colors.red,
                            ),
                          nameText(
                              context, countryData.confirmedTotal.toString())
                        ],
                      ),
                    ),
                    Container(
                      width: 50,
                      child: Column(
                        children: <Widget>[
                          if (countryData.recoverdNew > 0)
                            newCaseText(
                              context,
                              '+' + countryData.recoverdNew.toString(),
                              Colors.green,
                            ),
                          nameText(
                              context, countryData.recoverdTotal.toString())
                        ],
                      ),
                    ),
                    Container(
                      width: 50,
                      child: Column(
                        children: <Widget>[
                          if (countryData.deathNew > 0)
                            newCaseText(
                              context,
                              '+' + countryData.deathNew.toString(),
                              Colors.grey,
                            ),
                          nameText(context, countryData.deathTotal.toString())
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
}
