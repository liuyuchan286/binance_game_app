import 'package:binance_game_app/dto/base/query_page_dto.dart';


class BedsideBedsideProblemListDto extends QueryPageDto{
  String key;
  String name;
  int hospitalId;


  BedsideBedsideProblemListDto({
    this.key,
    this.name,
    this.hospitalId,
  });

  BedsideBedsideProblemListDto.fromJson(dynamic json) {
    key = json["key"];
    name = json["name"];
    hospitalId = json["hospitalId"];
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["key"] = key;
    map["name"] = name;
    map["hospitalId"] = hospitalId;
    return map;
  }

}
