class WorldCovidData {
  List<CountryCovidModel> countryListModel;

  WorldCovidData();
  WorldCovidData.fromJson(parsedJson) {
    this.countryListModel = parsedJson['Countries']
        .map<CountryCovidModel>((data) => CountryCovidModel.fromJson(data))
        .toList();
  }
}

class CountryCovidModel {
  String countryName;
  String countryCode;
  String date;
  int deathTotal;
  int deathNew;
  int confirmedTotal;
  int confirmNew;
  int recoverdTotal;
  int recoverdNew;

  CountryCovidModel({
    this.countryName,
    this.countryCode,
    this.deathTotal,
    this.deathNew,
    this.confirmedTotal,
    this.confirmNew,
    this.recoverdTotal,
    this.recoverdNew,
    this.date,
  });

  CountryCovidModel.fromJson(parsedJson) {
    this.countryName = parsedJson['Country'];
    this.countryCode = parsedJson['CountryCode'];
    this.deathTotal = parsedJson['TotalDeaths'];
    this.deathNew = parsedJson['NewDeaths'];
    this.confirmNew = parsedJson['NewConfirmed'];
    this.confirmedTotal = parsedJson['TotalConfirmed'];
    this.recoverdNew = parsedJson['NewRecovered'];
    this.recoverdTotal = parsedJson['TotalRecovered'];
    this.date = parsedJson['Date'];
  }
}
