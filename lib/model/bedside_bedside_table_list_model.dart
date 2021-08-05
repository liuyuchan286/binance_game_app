/// totalCount : 5
/// pageSize : 10
/// totalPage : 1
/// currPage : 1
/// list : [{"id":114,"name":"测试1","phone":"18820161165","password":"$2a$10$CbrJrhfzOhnaNi2F1Ik/GeVyKjUVRAMWPIfexoSzuZK4f8G0CJl4.","address":"杭州","createdAt":"2021-05-24 09:22:01","updatedAt":"2021-05-24 09:22:01","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":57,"name":"通辽运维1","phone":"15733296222","password":"$2a$10$D3RqwBpGCqTt1JZf2VWHAu6DjkkxLLpCTnwdX2Wlln6EEjDEMX8Ya","address":"","createdAt":"2020-11-10 09:06:10","updatedAt":"2020-11-10 09:06:10","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":51,"name":"测试01","phone":"17521284396","password":"$2a$10$fvWYYUdSBMN7My0N.SZUIuQ2fQgrWZ8GlwVy/V.N.Ily.yI4StxpC","address":"","createdAt":"2020-10-22 16:24:08","updatedAt":"2020-11-07 20:10:35","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":37,"name":"1","phone":"13295358640","password":"$2a$10$t/TZhn1sxL7vCaKTYi/rrudO.DBOjun7yacLOvG7JeH66EVzpbESi","address":"","createdAt":"2020-09-25 10:30:15","updatedAt":"2020-09-25 10:30:20","deletedAt":"2020-09-25 10:30:20","isManage":1,"isManageStr":"否"},{"id":36,"name":"1","phone":"13978945612","password":"$2a$10$ziGMyXXRkhhP6iBoA2mZ9u8OX6/DgElFL1bwJu5cE43G5P33PMKCq","address":"1","createdAt":"2020-09-25 10:08:57","updatedAt":"2020-09-25 10:09:40","deletedAt":"2020-09-25 10:09:40","isManage":1,"isManageStr":"否"}]

class BedsideBedsideTableListModel {
  int _totalCount;
  int _pageSize;
  int _totalPage;
  int _currPage;
  List<BedsideBedsideTableListModelData> _list;

  int get totalCount => _totalCount;
  int get pageSize => _pageSize;
  int get totalPage => _totalPage;
  int get currPage => _currPage;
  List<BedsideBedsideTableListModelData> get list => _list;

  BedsideBedsideTableListModel({
      int totalCount,
      int pageSize,
      int totalPage,
      int currPage,
      List<BedsideBedsideTableListModelData> list}){
      _totalCount = totalCount;
      _pageSize = pageSize;
      _totalPage = totalPage;
      _currPage = currPage;
      _list = list;
  }

  BedsideBedsideTableListModel.fromJson(dynamic json) {
      _totalCount = json["totalCount"];
      _pageSize = json["pageSize"];
      _totalPage = json["totalPage"];
      _currPage = json["currPage"];
      if (json["list"] != null) {
        _list = [];
        json["list"].forEach((v) {
          _list.add(BedsideBedsideTableListModelData.fromJson(v));
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

class BedsideBedsideTableListModelData {


  int id;
  int hospitalId;
  int officeId;
  int roomId;
  int bedId;
  String number;
  String deviceId;
  int status;
  String statusStr;
  int signal;
  int battery;
  int num;
  double money;
  int isTest;
  String createdAt;
  String updatedAt;
  String deletedAt;
  int isDelete;
  int type;
  String macId;
  int source;
  String sourceStr;
  String hospitalName;
  String officeName;
  String roomName;
  String bedName;


  BedsideBedsideTableListModelData({
        this.id,
        this.hospitalId,
        this.officeId,
        this.roomId,
        this.bedId,
        this.number,
        this.deviceId,
        this.status,
        this.statusStr,
        this.signal,
        this.battery,
        this.num,
        this.money,
        this.isTest,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.isDelete,
        this.type,
        this.macId,
        this.source,
        this.sourceStr,
        this.hospitalName,
        this.officeName,
        this.roomName,
        this.bedName,
      });

  BedsideBedsideTableListModelData.fromJson(dynamic json) {
    id = json["id"];
    hospitalId = json["hospitalId"];
    officeId = json["officeId"];
    roomId = json["roomId"];
    bedId = json["bedId"];
    number = json["number"];
    deviceId = json["deviceId"];
    status = json["status"];
    statusStr = json["statusStr"];
    signal = json["signal"];
    battery = json["battery"];
    num = json["num"];
    money = json["money"];
    isTest = json["isTest"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    deletedAt = json["deletedAt"];
    isDelete = json["isDelete"];
    type = json["type"];
    macId = json["macId"];
    source = json["source"];
    sourceStr = json["sourceStr"];
    hospitalName = json["hospitalName"];
    officeName = json["officeName"];
    roomName = json["roomName"];
    bedName = json["bedName"];
  }

  void replace(BedsideBedsideTableListModelData newData) {
    hospitalId = newData.hospitalId ?? hospitalId;
    officeId = newData.officeId ?? officeId;
    roomId = newData.roomId ?? roomId;
    bedId = newData.bedId ?? bedId;
    number = newData.number ?? number;
    deviceId = newData.deviceId ?? deviceId;
    status = newData.status ?? status;
    statusStr = newData.statusStr ?? statusStr;
    signal = newData.signal ?? signal;
    battery = newData.battery ?? battery;
    num = newData.num ?? num;
    money = newData.money ?? money;
    isTest = newData.isTest ?? isTest;
    createdAt = newData.createdAt ?? createdAt;
    updatedAt = newData.updatedAt ?? updatedAt;
    deletedAt = newData.deletedAt ?? deletedAt;
    isDelete = newData.isDelete ?? isDelete;
    type = newData.type ?? type;
    macId = newData.macId ?? macId;
    source = newData.source ?? source;
    sourceStr = newData.sourceStr ?? sourceStr;
    hospitalName = newData.hospitalName ?? hospitalName;
    officeName = newData.officeName ?? officeName;
    roomName = newData.roomName ?? roomName;
    bedName = newData.bedName ?? bedName;
  }


  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["hospitalId"] = hospitalId;
    map["officeId"] = officeId;
    map["roomId"] = roomId;
    map["bedId"] = bedId;
    map["number"] = number;
    map["deviceId"] = deviceId;
    map["status"] = status;
    map["statusStr"] = statusStr;
    map["signal"] = signal;
    map["battery"] = battery;
    map["num"] = num;
    map["money"] = money;
    map["isTest"] = isTest;
    map["createdAt"] = createdAt;
    map["updatedAt"] = updatedAt;
    map["deletedAt"] = deletedAt;
    map["isDelete"] = isDelete;
    map["type"] = type;
    map["macId"] = macId;
    map["source"] = source;
    map["sourceStr"] = sourceStr;
    map["hospitalName"] = hospitalName;
    map["officeName"] = officeName;
    map["roomName"] = roomName;
    map["bedName"] = bedName;
    return map;
  }


}
