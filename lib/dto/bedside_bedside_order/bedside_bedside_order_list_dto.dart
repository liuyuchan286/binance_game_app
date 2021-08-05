import 'package:binance_game_app/dto/base/query_page_dto.dart';


class BedsideBedsideOrderListDto extends QueryPageDto{
  String key;
  String phoneNumber;
  String number;
  String orderSn;
  String startTime;
  String endTime;
  int hospitalId;
  int status;


  BedsideBedsideOrderListDto({
    this.key,
    this.phoneNumber,
    this.number,
    this.orderSn,
    this.hospitalId,
    this.status,
    this.startTime,
    this.endTime,
  });

  BedsideBedsideOrderListDto.fromJson(dynamic json) {
    key = json["key"];
    phoneNumber = json["phoneNumber"];
    number = json["number"];
    orderSn = json["orderSn"];
    hospitalId = json["hospitalId"];
    status = json["status"];
    startTime = json["startTime"];
    endTime = json["endTime"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["key"] = key;
    map["phoneNumber"] = phoneNumber;
    map["number"] = number;
    map["orderSn"] = orderSn;
    map["hospitalId"] = hospitalId;
    map["status"] = status;
    map["startTime"] = startTime;
    map["endTime"] = endTime;
    return map;
  }

}
