import 'package:binance_game_app/dto/base/query_page_dto.dart';


class BedsideBedsideTableErrorListDto extends QueryPageDto{
  String key;
  String deviceId;


  BedsideBedsideTableErrorListDto({
    this.key,
    this.deviceId,
  });

  BedsideBedsideTableErrorListDto.fromJson(dynamic json) {
    key = json["key"];
    deviceId = json["deviceId"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["key"] = key;
    map["deviceId"] = deviceId;
    return map;
  }

}
