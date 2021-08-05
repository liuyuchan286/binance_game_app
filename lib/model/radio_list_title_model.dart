/// value : 1
/// title : ""

class RadioListTitleModel {
  int _value;
  String _title;

  int get value => _value;
  String get title => _title;

  RadioListTitleModel({
      int value, 
      String title}){
    _value = value;
    _title = title;
}

  RadioListTitleModel.fromJson(dynamic json) {
    _value = json["value"];
    _title = json["title"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["value"] = _value;
    map["title"] = _title;
    return map;
  }

}