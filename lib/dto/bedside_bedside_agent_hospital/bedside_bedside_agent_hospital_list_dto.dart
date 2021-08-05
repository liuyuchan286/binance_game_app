import 'package:binance_game_app/dto/base/query_page_dto.dart';


class BedsideBedsideAgentHospitalListDto extends QueryPageDto{
  String key;


  BedsideBedsideAgentHospitalListDto({
    this.key
  });

  BedsideBedsideAgentHospitalListDto.fromJson(dynamic json) {
    key = json["key"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["key"] = key;
    return map;
  }

}
