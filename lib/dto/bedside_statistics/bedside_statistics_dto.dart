import 'package:binance_game_app/dto/base/query_page_dto.dart';


class BedsideStatisticsDto extends QueryPageDto{
  String key;
  String startTime;
  String endTime;
  int hospitalId;
  int officeId;
  int roomId;


  BedsideStatisticsDto({
    this.key,
    this.startTime,
    this.endTime,
    this.hospitalId,
    this.officeId,
    this.roomId,
  });

  BedsideStatisticsDto.fromJson(dynamic json) {
    key = json["key"];
    startTime = json["startTime"];
    endTime = json["endTime"];
    hospitalId = json["hospitalId"];
    officeId = json["officeId"];
    roomId = json["roomId"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["key"] = key;
    map["startTime"] = startTime;
    map["endTime"] = endTime;
    map["hospitalId"] = hospitalId;
    map["officeId"] = officeId;
    map["roomId"] = roomId;
    return map;
  }

}
