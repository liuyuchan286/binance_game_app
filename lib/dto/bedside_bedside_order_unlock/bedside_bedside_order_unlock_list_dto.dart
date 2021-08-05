import 'package:binance_game_app/dto/base/query_page_dto.dart';


class BedsideBedsideOrderUnlockListDto extends QueryPageDto{
  String key;
  String number;
  int status;
  int type;


  BedsideBedsideOrderUnlockListDto({
    this.key,
    this.number,
    this.status,
    this.type,
  });

  BedsideBedsideOrderUnlockListDto.fromJson(dynamic json) {
    key = json["key"];
    number = json["number"];
    status = json["status"];
    type = json["type"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["key"] = key;
    map["number"] = number;
    map["status"] = status;
    map["type"] = type;
    return map;
  }

}
