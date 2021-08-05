/// key : ""
/// value : ""

class ListTableColumnModel {
  String _key;
  dynamic _value;
  Function _onTab;

  String get key => _key;
  String get value => _value;
  Function get onTab => _onTab;

  ListTableColumnModel({
      String key, 
      String value,
    Function onTab}){
    _key = key;
    _value = value;
    _onTab = onTab;
}

  ListTableColumnModel.fromJson(dynamic json) {
    _key = json["key"];
    _value = json["value"];
    _onTab = json["onTab"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["key"] = _key;
    map["value"] = _value;
    map["onTab"] = _onTab;
    return map;
  }

}