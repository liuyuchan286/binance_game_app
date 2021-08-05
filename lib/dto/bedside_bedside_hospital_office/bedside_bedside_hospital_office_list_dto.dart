import 'package:binance_game_app/dto/base/query_page_dto.dart';


class BedsideBedsideHospitalOfficeListDto extends QueryPageDto{
  String key;
  String name;
  int hospitalId;


  BedsideBedsideHospitalOfficeListDto({
    this.key,
    this.name,
    this.hospitalId,
  });

  BedsideBedsideHospitalOfficeListDto.fromJson(dynamic json) {
    key = json["key"];
    name = json["name"];
    hospitalId = json["hospitalId"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["key"] = key;
    map["name"] = name;
    map["hospitalId"] = hospitalId;
    return map;
  }

}
