class PastData {
  List<StateWise> oldData;
  List<CaseTimeSeries> caseTimeLine;

  PastData();

  PastData.fromJson(parsedJson) {
    this.oldData = parsedJson['statewise']
        .map<StateWise>((data) => StateWise.fromJson(data))
        .toList();
    this.caseTimeLine = parsedJson['cases_time_series']
        .map<CaseTimeSeries>((data) => CaseTimeSeries.fromJson(data))
        .toList();
  }
}

class CaseTimeSeries {
  String dailyconfirmed;
  String dailydeceased;
  String dailyrecovered;
  String date;
  String totalconfirmed;
  String totaldeceased;
  String totalrecovered;

  CaseTimeSeries.fromJson(parsedJson){
      this.dailyconfirmed = parsedJson['dailyconfirmed'];
      this.dailydeceased = parsedJson['dailydeceased'];
      this.dailyrecovered = parsedJson['dailyrecovered'];
      this.date = parsedJson['date'];
      this.totalconfirmed = parsedJson['totalconfirmed'];
      this.totaldeceased = parsedJson['totaldeceased'];
      this.totalrecovered = parsedJson['totalrecovered'];
  }
}

class StateWise {
  String active;
  String confirmed;
  String deaths;
  String state;
  String statecode;
  String statenotes;
  String recovered;

  StateWise.fromJson(parsedJson) {
    this.active = parsedJson['active'];
    this.confirmed = parsedJson['confirmed'];
    this.deaths = parsedJson['deaths'];
    this.state = parsedJson['state'];
    this.statecode = parsedJson['statecode'];
    this.statenotes = parsedJson['statenotes'];
    this.recovered = parsedJson['recovered'];
  }
}
