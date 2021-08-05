/// totalCount : 5
/// pageSize : 10
/// totalPage : 1
/// currPage : 1
/// list : [{"id":114,"name":"测试1","phone":"18820161165","password":"$2a$10$CbrJrhfzOhnaNi2F1Ik/GeVyKjUVRAMWPIfexoSzuZK4f8G0CJl4.","address":"杭州","createdAt":"2021-05-24 09:22:01","updatedAt":"2021-05-24 09:22:01","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":57,"name":"通辽运维1","phone":"15733296222","password":"$2a$10$D3RqwBpGCqTt1JZf2VWHAu6DjkkxLLpCTnwdX2Wlln6EEjDEMX8Ya","address":"","createdAt":"2020-11-10 09:06:10","updatedAt":"2020-11-10 09:06:10","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":51,"name":"测试01","phone":"17521284396","password":"$2a$10$fvWYYUdSBMN7My0N.SZUIuQ2fQgrWZ8GlwVy/V.N.Ily.yI4StxpC","address":"","createdAt":"2020-10-22 16:24:08","updatedAt":"2020-11-07 20:10:35","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":37,"name":"1","phone":"13295358640","password":"$2a$10$t/TZhn1sxL7vCaKTYi/rrudO.DBOjun7yacLOvG7JeH66EVzpbESi","address":"","createdAt":"2020-09-25 10:30:15","updatedAt":"2020-09-25 10:30:20","deletedAt":"2020-09-25 10:30:20","isManage":1,"isManageStr":"否"},{"id":36,"name":"1","phone":"13978945612","password":"$2a$10$ziGMyXXRkhhP6iBoA2mZ9u8OX6/DgElFL1bwJu5cE43G5P33PMKCq","address":"1","createdAt":"2020-09-25 10:08:57","updatedAt":"2020-09-25 10:09:40","deletedAt":"2020-09-25 10:09:40","isManage":1,"isManageStr":"否"}]

class BedsideBedsideopsListModel {
  int _totalCount;
  int _pageSize;
  int _totalPage;
  int _currPage;
  List<BedsideBedsideopsListModelData> _list;

  int get totalCount => _totalCount;
  int get pageSize => _pageSize;
  int get totalPage => _totalPage;
  int get currPage => _currPage;
  List<BedsideBedsideopsListModelData> get list => _list;

  BedsideBedsideopsListModel({
      int totalCount, 
      int pageSize, 
      int totalPage, 
      int currPage, 
      List<BedsideBedsideopsListModelData> list}){
    _totalCount = totalCount;
    _pageSize = pageSize;
    _totalPage = totalPage;
    _currPage = currPage;
    _list = list;
}

  BedsideBedsideopsListModel.fromJson(dynamic json) {
    _totalCount = json["totalCount"];
    _pageSize = json["pageSize"];
    _totalPage = json["totalPage"];
    _currPage = json["currPage"];
    if (json["list"] != null) {
      _list = [];
      json["list"].forEach((v) {
        _list.add(BedsideBedsideopsListModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["totalCount"] = _totalCount;
    map["pageSize"] = _pageSize;
    map["totalPage"] = _totalPage;
    map["currPage"] = _currPage;
    if (_list != null) {
      map["list"] = _list.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 114
/// name : "测试1"
/// phone : "18820161165"
/// password : "$2a$10$CbrJrhfzOhnaNi2F1Ik/GeVyKjUVRAMWPIfexoSzuZK4f8G0CJl4."
/// address : "杭州"
/// createdAt : "2021-05-24 09:22:01"
/// updatedAt : "2021-05-24 09:22:01"
/// deletedAt : null
/// isManage : 1
/// isManageStr : "否"

class BedsideBedsideopsListModelData {
  int _id;
  String _name;
  String _phone;
  String _password;
  String _address;
  String _createdAt;
  String _updatedAt;
  dynamic _deletedAt;
  int _isManage;
  String _isManageStr;

  int get id => _id;
  String get name => _name;
  String get phone => _phone;
  String get password => _password;
  String get address => _address;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  int get isManage => _isManage;
  String get isManageStr => _isManageStr;

  BedsideBedsideopsListModelData({
      int id, 
      String name, 
      String phone, 
      String password, 
      String address, 
      String createdAt, 
      String updatedAt, 
      dynamic deletedAt, 
      int isManage, 
      String isManageStr}){
    _id = id;
    _name = name;
    _phone = phone;
    _password = password;
    _address = address;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _isManage = isManage;
    _isManageStr = isManageStr;
}

  BedsideBedsideopsListModelData.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _phone = json["phone"];
    _password = json["password"];
    _address = json["address"];
    _createdAt = json["createdAt"];
    _updatedAt = json["updatedAt"];
    _deletedAt = json["deletedAt"];
    _isManage = json["isManage"];
    _isManageStr = json["isManageStr"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["phone"] = _phone;
    map["password"] = _password;
    map["address"] = _address;
    map["createdAt"] = _createdAt;
    map["updatedAt"] = _updatedAt;
    map["deletedAt"] = _deletedAt;
    map["isManage"] = _isManage;
    map["isManageStr"] = _isManageStr;
    return map;
  }

  set isManageStr(String value) {
    _isManageStr = value;
  }

  set isManage(int value) {
    _isManage = value;
  }

  set deletedAt(dynamic value) {
    _deletedAt = value;
  }

  set updatedAt(String value) {
    _updatedAt = value;
  }

  set createdAt(String value) {
    _createdAt = value;
  }

  set address(String value) {
    _address = value;
  }

  set password(String value) {
    _password = value;
  }

  set phone(String value) {
    _phone = value;
  }

  set name(String value) {
    _name = value;
  }

  set id(int value) {
    _id = value;
  }
}