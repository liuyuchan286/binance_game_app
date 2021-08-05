import 'package:binance_game_app/model/base/base_model.dart';

/// msg : "success"
/// code : 0
/// data : null
/// token : "bd375ad35931a2c74e03df7d3feb9737"

class RetModel<T extends BaseModel> {
  String _msg;
  int _code;
  dynamic _data;
  String _token;

  String get msg => _msg;
  int get code => _code;
  dynamic get data => _data;
  String get token => _token;

  RetModel({
      String msg, 
      int code, 
      dynamic data, 
      String token}){
    _msg = msg;
    _code = code;
    _data = data;
    _token = token;
}

  RetModel.fromJson(dynamic json) {
    _msg = json["msg"];
    _code = json["code"];
    _data = json["data"];
    _token = json["token"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["msg"] = _msg;
    map["code"] = _code;
    map["data"] = _data;
    map["token"] = _token;
    return map;
  }

}