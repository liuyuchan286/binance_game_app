import 'package:binance_game_app/dto/base/query_page_dto.dart';


class BedsideBedsideConfigListDto extends QueryPageDto{
  String key;
  String name;


  BedsideBedsideConfigListDto({
    this.key,
    this.name,
  });

  BedsideBedsideConfigListDto.fromJson(dynamic json) {
    key = json["key"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["key"] = key;
    map["name"] = name;
    return map;
  }

}
