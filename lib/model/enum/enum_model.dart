import 'package:binance_game_app/model/search_model.dart';

class EnumModel extends SearchModel{
  int key;
  String value;
  dynamic children;

  EnumModel({
      this.key, 
      this.value, 
      this.children});

  EnumModel.fromJson(dynamic json,{String param}) {
    super.param = param;
    key = json["key"];
    value = json["value"];
    children = json["children"];

  }

  EnumModel setParam(String param){
    super.param = param;
    return this;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["key"] = key;
    map["value"] = value;
    map["children"] = children;
    return map;
  }

  @override
  String getValue() {
    return value;
  }

  @override
  int getKey() {
    return key;
  }
}