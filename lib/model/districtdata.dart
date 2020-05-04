class DistrictData {
  final String districtName;
  final int active;
  final int recovered;
  final int deceased;
  final int confirmed;

  DistrictData({
    this.districtName,
    this.active,
    this.recovered,
    this.deceased,
    this.confirmed,}
  );

  factory DistrictData.fromJson(Map<String, dynamic> json) {
    return DistrictData(
      districtName: json['district'],
      active: json['active'],
      recovered: json['recovered'],
      deceased: json['deceased'],
      confirmed: json['confirmed'],
    );
  }
}
