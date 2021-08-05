import 'package:binance_game_app/dto/base/query_page_dto.dart';


class BedsideBedsideHospitalCommissionConfigListDto extends QueryPageDto{
  String key;
  String hospitalName;


  BedsideBedsideHospitalCommissionConfigListDto({
    this.key,
    this.hospitalName,
  });

  BedsideBedsideHospitalCommissionConfigListDto.fromJson(dynamic json) {
    key = json["key"];
    hospitalName = json["hospitalName"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["key"] = key;
    map["hospitalName"] = hospitalName;
    return map;
  }

}
