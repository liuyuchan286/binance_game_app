/// totalCount : 5
/// pageSize : 10
/// totalPage : 1
/// currPage : 1
/// list : [{"id":114,"name":"测试1","phone":"18820161165","password":"$2a$10$CbrJrhfzOhnaNi2F1Ik/GeVyKjUVRAMWPIfexoSzuZK4f8G0CJl4.","address":"杭州","createdAt":"2021-05-24 09:22:01","updatedAt":"2021-05-24 09:22:01","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":57,"name":"通辽运维1","phone":"15733296222","password":"$2a$10$D3RqwBpGCqTt1JZf2VWHAu6DjkkxLLpCTnwdX2Wlln6EEjDEMX8Ya","address":"","createdAt":"2020-11-10 09:06:10","updatedAt":"2020-11-10 09:06:10","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":51,"name":"测试01","phone":"17521284396","password":"$2a$10$fvWYYUdSBMN7My0N.SZUIuQ2fQgrWZ8GlwVy/V.N.Ily.yI4StxpC","address":"","createdAt":"2020-10-22 16:24:08","updatedAt":"2020-11-07 20:10:35","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":37,"name":"1","phone":"13295358640","password":"$2a$10$t/TZhn1sxL7vCaKTYi/rrudO.DBOjun7yacLOvG7JeH66EVzpbESi","address":"","createdAt":"2020-09-25 10:30:15","updatedAt":"2020-09-25 10:30:20","deletedAt":"2020-09-25 10:30:20","isManage":1,"isManageStr":"否"},{"id":36,"name":"1","phone":"13978945612","password":"$2a$10$ziGMyXXRkhhP6iBoA2mZ9u8OX6/DgElFL1bwJu5cE43G5P33PMKCq","address":"1","createdAt":"2020-09-25 10:08:57","updatedAt":"2020-09-25 10:09:40","deletedAt":"2020-09-25 10:09:40","isManage":1,"isManageStr":"否"}]

class BedsideBedsideAgentListModel {
  int _totalCount;
  int _pageSize;
  int _totalPage;
  int _currPage;
  List<BedsideBedsideAgentListModelData> _list;

  int get totalCount => _totalCount;
  int get pageSize => _pageSize;
  int get totalPage => _totalPage;
  int get currPage => _currPage;
  List<BedsideBedsideAgentListModelData> get list => _list;

  BedsideBedsideAgentListModel({
      int totalCount,
      int pageSize,
      int totalPage,
      int currPage,
      List<BedsideBedsideAgentListModelData> list}){
      _totalCount = totalCount;
      _pageSize = pageSize;
      _totalPage = totalPage;
      _currPage = currPage;
      _list = list;
  }

  BedsideBedsideAgentListModel.fromJson(dynamic json) {
      _totalCount = json["totalCount"];
      _pageSize = json["pageSize"];
      _totalPage = json["totalPage"];
      _currPage = json["currPage"];
      if (json["list"] != null) {
        _list = [];
        json["list"].forEach((v) {
          _list.add(BedsideBedsideAgentListModelData.fromJson(v));
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

class BedsideBedsideAgentListModelData {


  int id;
  String name;
  int type;
  String typeStr;
  String contact;
  String phone;
  String password;
  String address;
  int money;
  String rememberToken;
  String createdAt;
  String updatedAt;
  String deletedAt;
  int sysUserId;
  double withdrawableMoney;
  double withdrawnMoney;
  double totalRevenueMoney;
  double tobeCreditedMoney;


  BedsideBedsideAgentListModelData({
        this.id,
        this.name,
        this.type,
        this.typeStr,
        this.contact,
        this.phone,
        this.password,
        this.address,
        this.money,
        this.rememberToken,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.sysUserId,
        this.withdrawableMoney,
        this.withdrawnMoney,
        this.totalRevenueMoney,
        this.tobeCreditedMoney,
      });

  BedsideBedsideAgentListModelData.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    type = json["type"];
    typeStr = json["typeStr"];
    contact = json["contact"];
    phone = json["phone"];
    password = json["password"];
    address = json["address"];
    money = json["money"];
    rememberToken = json["rememberToken"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    deletedAt = json["deletedAt"];
    sysUserId = json["sysUserId"];
    withdrawableMoney = json["withdrawableMoney"];
    withdrawnMoney = json["withdrawnMoney"];
    totalRevenueMoney = json["totalRevenueMoney"];
    tobeCreditedMoney = json["tobeCreditedMoney"];
  }

  void replace(BedsideBedsideAgentListModelData newData) {
  id = newData.id ?? id;
  name = newData.name ?? name;
  type = newData.type ?? type;
  typeStr = newData.typeStr ?? typeStr;
  contact = newData.contact ?? contact;
  phone = newData.phone ?? phone;
  password = newData.password ?? password;
  address = newData.address ?? address;
  money = newData.money ?? money;
  rememberToken = newData.rememberToken ?? rememberToken;
  createdAt = newData.createdAt ?? createdAt;
  updatedAt = newData.updatedAt ?? updatedAt;
  deletedAt = newData.deletedAt ?? deletedAt;
  sysUserId = newData.sysUserId ?? sysUserId;
  withdrawableMoney = newData.withdrawableMoney ?? withdrawableMoney;
  withdrawnMoney = newData.withdrawnMoney ?? withdrawnMoney;
  totalRevenueMoney = newData.totalRevenueMoney ?? totalRevenueMoney;
  tobeCreditedMoney = newData.tobeCreditedMoney ?? tobeCreditedMoney;
    }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["type"] = type;
    map["typeStr"] = typeStr;
    map["contact"] = contact;
    map["phone"] = phone;
    map["password"] = password;
    map["address"] = address;
    map["money"] = money;
    map["rememberToken"] = rememberToken;
    map["createdAt"] = createdAt;
    map["updatedAt"] = updatedAt;
    map["deletedAt"] = deletedAt;
    map["sysUserId"] = sysUserId;
    map["withdrawableMoney"] = withdrawableMoney;
    map["withdrawnMoney"] = withdrawnMoney;
    map["totalRevenueMoney"] = totalRevenueMoney;
    map["tobeCreditedMoney"] = tobeCreditedMoney;
    return map;
  }
}
