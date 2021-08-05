import 'package:binance_game_app/dto/base/query_page_dto.dart';


class BedsideBedsideHospitalBedListDto extends QueryPageDto{
  String key;
  String name;
  int roomId;
  int officeId;
  int hospitalId;

  BedsideBedsideHospitalBedListDto({
    this.key,
    this.name,
    this.roomId,
    this.officeId,
    this.hospitalId,
  });

  BedsideBedsideHospitalBedListDto.fromJson(dynamic json) {
    key = json["key"];
    name = json["name"];
    roomId = json["roomId"];
    officeId = json["officeId"];
    hospitalId = json["hospitalId"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["key"] = key;
    map["name"] = name;
    map["roomId"] = roomId;
    map["officeId"] = officeId;
    map["hospitalId"] = hospitalId;
    return map;
  }

}
