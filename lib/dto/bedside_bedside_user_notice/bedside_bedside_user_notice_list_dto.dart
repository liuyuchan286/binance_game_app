import 'package:binance_game_app/dto/base/query_page_dto.dart';


class BedsideBedsideUserNoticeListDto extends QueryPageDto{
  String key;


  BedsideBedsideUserNoticeListDto({
    this.key
  });

  BedsideBedsideUserNoticeListDto.fromJson(dynamic json) {
    key = json["key"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["key"] = key;
    return map;
  }

}
