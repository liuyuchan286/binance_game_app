import 'package:binance_game_app/dto/base/query_page_dto.dart';


class BedsideBedsideUserHospitalDepositListDto extends QueryPageDto{
  String key;
  String phoneNumber;
  int hospitalId;


  BedsideBedsideUserHospitalDepositListDto({
    this.key,
    this.phoneNumber,
    this.hospitalId,
  });

  BedsideBedsideUserHospitalDepositListDto.fromJson(dynamic json) {
    key = json["key"];
    phoneNumber = json["phoneNumber"];
    hospitalId = json["hospitalId"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["key"] = key;
    map["phoneNumber"] = phoneNumber;
    map["hospitalId"] = hospitalId;
    return map;
  }

}
