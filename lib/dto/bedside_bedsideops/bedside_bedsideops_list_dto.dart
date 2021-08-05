import 'package:binance_game_app/dto/base/query_page_dto.dart';

/// name : "cwl"
/// phone : "17638155659"

class BedsideBedsideopsListDto extends QueryPageDto{
  String _name;
  String _phone;

  String get name => _name;
  String get phone => _phone;

  BedsideBedsideopsListDto({
      String name, 
      String phone}){
    _name = name;
    _phone = phone;
}

  BedsideBedsideopsListDto.fromJson(dynamic json) {
    _name = json["name"];
    _phone = json["phone"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["name"] = _name;
    map["phone"] = _phone;
    return map;
  }

  set phone(String value) {
    _phone = value;
  }

  set name(String value) {
    _name = value;
  }
}