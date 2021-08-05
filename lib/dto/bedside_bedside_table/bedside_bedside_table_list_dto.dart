import 'package:binance_game_app/dto/base/query_page_dto.dart';


class BedsideBedsideTableListDto extends QueryPageDto{
  String key;
  String number;
  String deviceId;
  int hospitalId;
  int officeId;
  int roomId;
  int status;
  int source;


  BedsideBedsideTableListDto({
    this.key,
    this.number,
    this.deviceId,
    this.hospitalId,
    this.officeId,
    this.roomId,
    this.status,
    this.source,
  });

  BedsideBedsideTableListDto.fromJson(dynamic json) {
    key = json["key"];
    number = json["number"];
    deviceId = json["deviceId"];
    hospitalId = json["hospitalId"];
    officeId = json["officeId"];
    roomId = json["roomId"];
    status = json["status"];
    source = json["source"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["key"] = key;
    map["number"] = number;
    map["deviceId"] = deviceId;
    map["hospitalId"] = hospitalId;
    map["officeId"] = officeId;
    map["roomId"] = roomId;
    map["status"] = status;
    map["source"] = source;
    return map;
  }

}
