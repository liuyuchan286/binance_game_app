/// totalCount : 5
/// pageSize : 10
/// totalPage : 1
/// currPage : 1
/// list : [{"id":114,"name":"测试1","phone":"18820161165","password":"$2a$10$CbrJrhfzOhnaNi2F1Ik/GeVyKjUVRAMWPIfexoSzuZK4f8G0CJl4.","address":"杭州","createdAt":"2021-05-24 09:22:01","updatedAt":"2021-05-24 09:22:01","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":57,"name":"通辽运维1","phone":"15733296222","password":"$2a$10$D3RqwBpGCqTt1JZf2VWHAu6DjkkxLLpCTnwdX2Wlln6EEjDEMX8Ya","address":"","createdAt":"2020-11-10 09:06:10","updatedAt":"2020-11-10 09:06:10","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":51,"name":"测试01","phone":"17521284396","password":"$2a$10$fvWYYUdSBMN7My0N.SZUIuQ2fQgrWZ8GlwVy/V.N.Ily.yI4StxpC","address":"","createdAt":"2020-10-22 16:24:08","updatedAt":"2020-11-07 20:10:35","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":37,"name":"1","phone":"13295358640","password":"$2a$10$t/TZhn1sxL7vCaKTYi/rrudO.DBOjun7yacLOvG7JeH66EVzpbESi","address":"","createdAt":"2020-09-25 10:30:15","updatedAt":"2020-09-25 10:30:20","deletedAt":"2020-09-25 10:30:20","isManage":1,"isManageStr":"否"},{"id":36,"name":"1","phone":"13978945612","password":"$2a$10$ziGMyXXRkhhP6iBoA2mZ9u8OX6/DgElFL1bwJu5cE43G5P33PMKCq","address":"1","createdAt":"2020-09-25 10:08:57","updatedAt":"2020-09-25 10:09:40","deletedAt":"2020-09-25 10:09:40","isManage":1,"isManageStr":"否"}]

class BedsideBedsideOrderUnlockListModel {
  int _totalCount;
  int _pageSize;
  int _totalPage;
  int _currPage;
  List<BedsideBedsideOrderUnlockListModelData> _list;

  int get totalCount => _totalCount;
  int get pageSize => _pageSize;
  int get totalPage => _totalPage;
  int get currPage => _currPage;
  List<BedsideBedsideOrderUnlockListModelData> get list => _list;

  BedsideBedsideOrderUnlockListModel({
      int totalCount,
      int pageSize,
      int totalPage,
      int currPage,
      List<BedsideBedsideOrderUnlockListModelData> list}){
      _totalCount = totalCount;
      _pageSize = pageSize;
      _totalPage = totalPage;
      _currPage = currPage;
      _list = list;
  }

  BedsideBedsideOrderUnlockListModel.fromJson(dynamic json) {
      _totalCount = json["totalCount"];
      _pageSize = json["pageSize"];
      _totalPage = json["totalPage"];
      _currPage = json["currPage"];
      if (json["list"] != null) {
        _list = [];
        json["list"].forEach((v) {
          _list.add(BedsideBedsideOrderUnlockListModelData.fromJson(v));
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

class BedsideBedsideOrderUnlockListModelData {


  int id;
  String orderSn;
  int tableId;
  String number;
  String commandId;
  String openid;
  int status;
  String statusStr;
  int type;
  String typeStr;
  int time;
  double money;
  String content;
  String createdAt;
  String updatedAt;
  String sendAt;
  String sentAt;
  String startAt;
  String endAt;
  int tableType;
  String usertimEndAt;


  BedsideBedsideOrderUnlockListModelData({
        this.id,
        this.orderSn,
        this.tableId,
        this.number,
        this.commandId,
        this.openid,
        this.status,
        this.statusStr,
        this.type,
        this.typeStr,
        this.time,
        this.money,
        this.content,
        this.createdAt,
        this.updatedAt,
        this.sendAt,
        this.sentAt,
        this.startAt,
        this.endAt,
        this.tableType,
        this.usertimEndAt,
      });

  BedsideBedsideOrderUnlockListModelData.fromJson(dynamic json) {
    id = json["id"];
    orderSn = json["orderSn"];
    tableId = json["tableId"];
    number = json["number"];
    commandId = json["commandId"];
    openid = json["openid"];
    status = json["status"];
    statusStr = json["statusStr"];
    type = json["type"];
    typeStr = json["typeStr"];
    time = json["time"];
    money = json["money"];
    content = json["content"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    sendAt = json["sendAt"];
    sentAt = json["sentAt"];
    startAt = json["startAt"];
    endAt = json["endAt"];
    tableType = json["tableType"];
    usertimEndAt = json["usertimEndAt"];
  }

  void replace(BedsideBedsideOrderUnlockListModelData newData) {
  id = newData.id ?? id;
  orderSn = newData.orderSn ?? orderSn;
  tableId = newData.tableId ?? tableId;
  number = newData.number ?? number;
  commandId = newData.commandId ?? commandId;
  openid = newData.openid ?? openid;
  status = newData.status ?? status;
  statusStr = newData.statusStr ?? statusStr;
  type = newData.type ?? type;
  statusStr = newData.statusStr ?? statusStr;
  time = newData.time ?? time;
  money = newData.money ?? money;
  content = newData.content ?? content;
  createdAt = newData.createdAt ?? createdAt;
  updatedAt = newData.updatedAt ?? updatedAt;
  sendAt = newData.sendAt ?? sendAt;
  sentAt = newData.sentAt ?? sentAt;
  startAt = newData.startAt ?? startAt;
  endAt = newData.endAt ?? endAt;
  tableType = newData.tableType ?? tableType;
  usertimEndAt = newData.usertimEndAt ?? usertimEndAt;
    }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["orderSn"] = orderSn;
    map["tableId"] = tableId;
    map["number"] = number;
    map["commandId"] = commandId;
    map["openid"] = openid;
    map["status"] = status;
    map["statusStr"] = statusStr;
    map["type"] = type;
    map["statusStr"] = statusStr;
    map["time"] = time;
    map["money"] = money;
    map["content"] = content;
    map["createdAt"] = createdAt;
    map["updatedAt"] = updatedAt;
    map["sendAt"] = sendAt;
    map["sentAt"] = sentAt;
    map["startAt"] = startAt;
    map["endAt"] = endAt;
    map["tableType"] = tableType;
    map["usertimEndAt"] = usertimEndAt;
    return map;
  }
}
