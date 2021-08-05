import 'package:binance_game_app/dto/base/query_page_dto.dart';


class BedsideBedsideHospitalRoomListDto extends QueryPageDto{
  String key;
  String name;
  int officeId;
  int hospitalId;


  BedsideBedsideHospitalRoomListDto({
    this.key,
    this.name,
    this.officeId,
    this.hospitalId,
  });

  BedsideBedsideHospitalRoomListDto.fromJson(dynamic json) {
    key = json["key"];
    name = json["name"];
    officeId = json["officeId"];
    hospitalId = json["hospitalId"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["key"] = key;
    map["name"] = name;
    map["officeId"] = officeId;
    map["hospitalId"] = hospitalId;
    return map;
  }

}
