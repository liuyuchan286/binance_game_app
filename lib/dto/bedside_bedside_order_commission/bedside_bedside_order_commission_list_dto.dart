import 'package:binance_game_app/dto/base/query_page_dto.dart';


class BedsideBedsideOrderCommissionListDto extends QueryPageDto{
  String key;
  String orderSn;
  int hospitalId;
  int status;
  String startTime;
  String endTime;

  BedsideBedsideOrderCommissionListDto({
    this.key,
    this.orderSn,
    this.hospitalId,
    this.status,
    this.startTime,
    this.endTime,
  });

  BedsideBedsideOrderCommissionListDto.fromJson(dynamic json) {
    key = json["key"];
    orderSn = json["orderSn"];
    hospitalId = json["hospitalId"];
    status = json["status"];
    startTime = json["startTime"];
    endTime = json["endTime"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["key"] = key;
    map["orderSn"] = orderSn;
    map["hospitalId"] = hospitalId;
    map["status"] = status;
    map["startTime"] = startTime;
    map["endTime"] = endTime;
    return map;
  }

}
