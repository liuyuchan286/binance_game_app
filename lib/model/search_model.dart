import 'package:binance_game_app/model/picker/single_list_picker_model.dart';

/// key : 1
/// value : ""
/// param : "opsId"

class SearchModel extends SingleListPickerModel{
  int _key;
  String _value;
  String _param;

  int getKey() {
    return _key;
  }
  String getValue() {
    return _value;
  }

  String getParam() {
    return _param;
  }

  SearchModel({
      int key, 
      String value, 
      String param}){
    _key = key;
    _value = value;
    _param = param;
}

  SearchModel.fromJson(dynamic json) {
    _key = json["key"];
    _value = json["value"];
    _param = json["param"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["key"] = _key;
    map["value"] = _value;
    map["param"] = _param;
    return map;
  }

  set param(String value) {
    _param = value;
  }

  @override
  int getIndex() {

  }
}