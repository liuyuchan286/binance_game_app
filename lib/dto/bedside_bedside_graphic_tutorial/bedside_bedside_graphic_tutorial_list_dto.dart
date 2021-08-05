import 'package:binance_game_app/dto/base/query_page_dto.dart';


class BedsideBedsideGraphicTutorialListDto extends QueryPageDto{
  String key;


  BedsideBedsideGraphicTutorialListDto({
    this.key
  });

  BedsideBedsideGraphicTutorialListDto.fromJson(dynamic json) {
    key = json["key"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["key"] = key;
    return map;
  }

}
