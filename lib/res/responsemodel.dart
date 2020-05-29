class GetResponse {
  bool success = false;
  String message = "";
  dynamic data;

  GetResponse.failed({this.message}) : this.success = false;

  GetResponse.success() : this.success = true;

  GetResponse.successWithData({this.data}) : success = true;
}