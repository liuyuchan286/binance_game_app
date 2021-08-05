import 'package:binance_game_app/dto/base/query_page_dto.dart';


class BedsideBedsideRefundOrderListDto extends QueryPageDto{
  String key;
  String orderId;


  BedsideBedsideRefundOrderListDto({
    this.key,
    this.orderId,
  });

  BedsideBedsideRefundOrderListDto.fromJson(dynamic json) {
    key = json["key"];
    orderId = json["orderId"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["key"] = key;
    map["orderId"] = orderId;
    return map;
  }

}
