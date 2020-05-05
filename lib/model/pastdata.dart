class PastData {
  final List<dynamic> oldData;

  PastData({
    this.oldData,
  });

  factory PastData.fromJson(Map<String, dynamic> json) {
    return PastData(
      oldData: json['states_daily'],
    );
  }
}
