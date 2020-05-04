class StatesList {
  final String stateName;
  final String stateCode;
  final List<dynamic> districtData;

  StatesList({
    this.stateCode,
    this.stateName,
    this.districtData,
  });

  factory StatesList.fromJson(Map<String, dynamic> json) {
    return StatesList(
      stateName: json['state'],
      stateCode: json['statecode'],
      districtData: json['districtData'],
    );
  }
}