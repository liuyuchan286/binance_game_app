import 'package:binance_game_app/dto/base/query_page_dto.dart';


class BedsideBedsideIndexVideoTutorialListDto extends QueryPageDto{
  String key;


  BedsideBedsideIndexVideoTutorialListDto({
    this.key
  });

  BedsideBedsideIndexVideoTutorialListDto.fromJson(dynamic json) {
    key = json["key"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["key"] = key;
    return map;
  }

}
