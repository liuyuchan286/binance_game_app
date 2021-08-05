/// page : 1
/// limit : 10

class QueryPageDto {
  int _page = 1;
  int _limit = 10;

  int get page => _page;
  int get limit => _limit;

  QueryPageDto({
      int page = 1,
      int limit = 10}){
    _page = page;
    _limit = limit;
}

  QueryPageDto.fromJson(dynamic json) {
    _page = json["page"];
    _limit = json["limit"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["page"] = _page;
    map["limit"] = _limit;
    return map;
  }

  set limit(int value) {
    _limit = value;
  }

  set page(int value) {
    _page = value;
  }
}