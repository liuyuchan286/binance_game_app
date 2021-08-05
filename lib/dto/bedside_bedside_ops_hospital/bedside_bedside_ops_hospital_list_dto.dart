import 'package:binance_game_app/dto/base/query_page_dto.dart';


class BedsideBedsideOpsHospitalListDto extends QueryPageDto{
  String key;


  BedsideBedsideOpsHospitalListDto({
    this.key
  });

  BedsideBedsideOpsHospitalListDto.fromJson(dynamic json) {
    key = json["key"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["key"] = key;
    return map;
  }

}
