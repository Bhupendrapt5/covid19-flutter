class ResponseModel {
  bool success = false;
  String message = "";
  dynamic data;

  ResponseModel.failed({this.message}) : this.success = false;

  ResponseModel.success() : this.success = true;

  ResponseModel.successWithData({this.data}) : success = true;
}