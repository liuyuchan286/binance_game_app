import 'package:binance_game_app/dto/base/query_page_dto.dart';


class BedsideBedsideUserListDto extends QueryPageDto{
  String key;
  String phoneNumber;


  BedsideBedsideUserListDto({
    this.key,
    this.phoneNumber,
  });

  BedsideBedsideUserListDto.fromJson(dynamic json) {
    key = json["key"];
    phoneNumber = json["phoneNumber"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["key"] = key;
    map["phoneNumber"] = phoneNumber;
    return map;
  }

}
