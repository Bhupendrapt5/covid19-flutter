class StatesList {
  List<StateWiseData> dailyStatData;

  StatesList();

  StatesList.fromJson(json) {
    this.dailyStatData =
        json.map<StateWiseData>((data) => StateWiseData.fromJson(data)).toList();
  }
}

class StateWiseData {
  String stateName;
  String stateCode;
  List<DistrictData> districtData;

  StateWiseData();

  StateWiseData.fromJson(json) {
    this.stateName = json['state'];
    this.stateCode = json['statecode'];
    this.districtData = json['districtData']
        .map<DistrictData>((data) => DistrictData.fromJson(data))
        .toList();
  }
}

class DistrictData {
  String districtName;
  int active;
  int recovered;
  int deceased;
  int confirmed;

  DistrictData();

  DistrictData.fromJson(json) {
    this.districtName = json['district'];
    this.active = json['active'];
    this.recovered = json['recovered'];
    this.deceased = json['deceased'];
    this.confirmed = json['confirmed'];
  }
}
