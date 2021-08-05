import 'package:binance_game_app/dto/base/query_page_dto.dart';


class BedsideBedsideTableRepairsListDto extends QueryPageDto{
  String key;
  String number;
  int status;


  BedsideBedsideTableRepairsListDto({
    this.key,
    this.number,
    this.status,
  });

  BedsideBedsideTableRepairsListDto.fromJson(dynamic json) {
    key = json["key"];
    number = json["number"];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["key"] = key;
    map["number"] = number;
    map["status"] = status;
    return map;
  }

}
