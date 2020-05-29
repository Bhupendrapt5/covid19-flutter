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
      width: textWidth,
      decoration: BoxDecoration(
        color: Color.fromRGBO(40, 42, 61, 1),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 8,
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: textWidth * 0.15,
            width: textWidth * 0.15,
            decoration: new BoxDecoration(
              // shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(40),
              image: new DecorationImage(
                fit: BoxFit.cover,
                image: new NetworkImage(imgUrl),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  // width: textWidth,
                  child: Wrap(
                    children: <Widget>[
                      nameText(
                          context: context,
                          text: countryData.countryName,
                          size: 15),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      VerticalDivider(
                        color: Colors.white,
                        width: 3,
                      ),
                      Expanded(
                        child: Container(
                          // width: 50,
                          child: Column(
                            children: <Widget>[
                              if (countryData.confirmNew > 0)
                                newCaseText(
                                  context,
                                  '+' + countryData.confirmNew.toString(),
                                  Colors.red,
                                ),
                              nameText(
                                context: context,
                                text: countryData.confirmedTotal.toString(),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // width: 50,
                          child: Column(
                            children: <Widget>[
                              if (countryData.recoverdNew > 0)
                                newCaseText(
                                  context,
                                  '+' + countryData.recoverdNew.toString(),
                                  Colors.green,
                                ),
                              nameText(
                                context: context,
                                text: countryData.recoverdTotal.toString(),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // width: 50,
                          child: Column(
                            children: <Widget>[
                              if (countryData.deathNew > 0)
                                newCaseText(
                                  context,
                                  '+' + countryData.deathNew.toString(),
                                  Colors.grey,
                                ),
                              nameText(
                                context: context,
                                text: countryData.deathTotal.toString(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget nameText({BuildContext context, String text, double size = 13}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
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
