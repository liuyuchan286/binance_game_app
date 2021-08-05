import 'package:binance_game_app/dto/base/query_page_dto.dart';


class BedsideBedsideGraphicTutorialHospitalListDto extends QueryPageDto{
  String key;


  BedsideBedsideGraphicTutorialHospitalListDto({
    this.key
  });

  BedsideBedsideGraphicTutorialHospitalListDto.fromJson(dynamic json) {
    key = json["key"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["key"] = key;
    return map;
  }

}
