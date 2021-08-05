import 'package:binance_game_app/dto/base/query_page_dto.dart';


class BedsideBedsideOpsListDto extends QueryPageDto{
  String key;
  String name;
  String phone;


  BedsideBedsideOpsListDto({
    this.key,
    this.name,
    this.phone,
  });

  BedsideBedsideOpsListDto.fromJson(dynamic json) {
    key = json["key"];
    name = json["name"];
    phone = json["phone"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["key"] = key;
    map["name"] = name;
    map["phone"] = phone;
    return map;
  }

}
