class StatesDaily {
  Map<String, dynamic> stateDistData;

  StatesDaily();

  StatesDaily.fromJson(Map<String, dynamic> parsedJson, String stateName) {
    this.stateDistData = parsedJson[stateName];
  }
}

class DistrictDaily {
  List<DistrictDataDaily> distData;

  DistrictDaily();

  DistrictDaily.fromJson(Map<String, dynamic> parsedJson, String distName) {
    this.distData = parsedJson[distName]
        .map<DistrictDataDaily>((data) => DistrictDataDaily.fromJson(data))
        .toList();
  }
}

class DistrictDataDaily {
  String notes;
  int active;
  int recovered;
  int deceased;
  int confirmed;
  String date;

  DistrictDataDaily();

  DistrictDataDaily.fromJson(json) {
    this.active = json['active'];
    this.notes = json['notes'];
    this.recovered = json['recovered'];
    this.deceased = json['deceased'];
    this.confirmed = json['confirmed'];
    this.date = json['date'];
  }
}
