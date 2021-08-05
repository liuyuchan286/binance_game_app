/// totalCount : 5
/// pageSize : 10
/// totalPage : 1
/// currPage : 1
/// list : [{"id":114,"name":"测试1","phone":"18820161165","password":"$2a$10$CbrJrhfzOhnaNi2F1Ik/GeVyKjUVRAMWPIfexoSzuZK4f8G0CJl4.","address":"杭州","createdAt":"2021-05-24 09:22:01","updatedAt":"2021-05-24 09:22:01","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":57,"name":"通辽运维1","phone":"15733296222","password":"$2a$10$D3RqwBpGCqTt1JZf2VWHAu6DjkkxLLpCTnwdX2Wlln6EEjDEMX8Ya","address":"","createdAt":"2020-11-10 09:06:10","updatedAt":"2020-11-10 09:06:10","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":51,"name":"测试01","phone":"17521284396","password":"$2a$10$fvWYYUdSBMN7My0N.SZUIuQ2fQgrWZ8GlwVy/V.N.Ily.yI4StxpC","address":"","createdAt":"2020-10-22 16:24:08","updatedAt":"2020-11-07 20:10:35","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":37,"name":"1","phone":"13295358640","password":"$2a$10$t/TZhn1sxL7vCaKTYi/rrudO.DBOjun7yacLOvG7JeH66EVzpbESi","address":"","createdAt":"2020-09-25 10:30:15","updatedAt":"2020-09-25 10:30:20","deletedAt":"2020-09-25 10:30:20","isManage":1,"isManageStr":"否"},{"id":36,"name":"1","phone":"13978945612","password":"$2a$10$ziGMyXXRkhhP6iBoA2mZ9u8OX6/DgElFL1bwJu5cE43G5P33PMKCq","address":"1","createdAt":"2020-09-25 10:08:57","updatedAt":"2020-09-25 10:09:40","deletedAt":"2020-09-25 10:09:40","isManage":1,"isManageStr":"否"}]

class BedsideBedsideTableRepairsListModel {
  int _totalCount;
  int _pageSize;
  int _totalPage;
  int _currPage;
  List<BedsideBedsideTableRepairsListModelData> _list;

  int get totalCount => _totalCount;
  int get pageSize => _pageSize;
  int get totalPage => _totalPage;
  int get currPage => _currPage;
  List<BedsideBedsideTableRepairsListModelData> get list => _list;

  BedsideBedsideTableRepairsListModel({
      int totalCount,
      int pageSize,
      int totalPage,
      int currPage,
      List<BedsideBedsideTableRepairsListModelData> list}){
      _totalCount = totalCount;
      _pageSize = pageSize;
      _totalPage = totalPage;
      _currPage = currPage;
      _list = list;
  }

  BedsideBedsideTableRepairsListModel.fromJson(dynamic json) {
      _totalCount = json["totalCount"];
      _pageSize = json["pageSize"];
      _totalPage = json["totalPage"];
      _currPage = json["currPage"];
      if (json["list"] != null) {
        _list = [];
        json["list"].forEach((v) {
          _list.add(BedsideBedsideTableRepairsListModelData.fromJson(v));
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

class BedsideBedsideTableRepairsListModelData {
  int id;
  int tableId;
  String openid;
  int opsId;
  String opsName;
  int type;
  int status;
  String content;
  String img;
  String createdAt;
  String updatedAt;
  dynamic finishAt;
  int orderId;
  double refundMoney;
  String hospitalName;
  String officeName;
  String roomName;
  int tableStatus;
  String number;
  String repairBadReason;
  String repairBadImg;
  dynamic orderSn;
  String tableStatusStr;
  String typeStr;
  List<String> imgList;
  String statusStr;

  BedsideBedsideTableRepairsListModelData({
    this.id,
    this.tableId,
    this.openid,
    this.opsId,
    this.opsName,
    this.type,
    this.status,
    this.content,
    this.img,
    this.createdAt,
    this.updatedAt,
    this.finishAt,
    this.orderId,
    this.refundMoney,
    this.hospitalName,
    this.officeName,
    this.roomName,
    this.tableStatus,
    this.number,
    this.repairBadReason,
    this.repairBadImg,
    this.orderSn,
    this.tableStatusStr,
    this.typeStr,
    this.imgList,
    this.statusStr});

  BedsideBedsideTableRepairsListModelData.fromJson(dynamic json) {
    id = json["id"];
    tableId = json["tableId"];
    openid = json["openid"];
    opsId = json["opsId"];
    opsName = json["opsName"];
    type = json["type"];
    status = json["status"];
    content = json["content"];
    img = json["img"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    finishAt = json["finishAt"];
    orderId = json["orderId"];
    refundMoney = json["refundMoney"];
    hospitalName = json["hospitalName"];
    officeName = json["officeName"];
    roomName = json["roomName"];
    tableStatus = json["tableStatus"];
    number = json["number"];
    repairBadReason = json["repairBadReason"];
    repairBadImg = json["repairBadImg"];
    orderSn = json["orderSn"];
    tableStatusStr = json["tableStatusStr"];
    typeStr = json["typeStr"];
    imgList = json["imgList"] != null ? json["imgList"].cast<String>() : [];
    statusStr = json["statusStr"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["tableId"] = tableId;
    map["openid"] = openid;
    map["opsId"] = opsId;
    map["opsName"] = opsName;
    map["type"] = type;
    map["status"] = status;
    map["content"] = content;
    map["img"] = img;
    map["createdAt"] = createdAt;
    map["updatedAt"] = updatedAt;
    map["finishAt"] = finishAt;
    map["orderId"] = orderId;
    map["refundMoney"] = refundMoney;
    map["hospitalName"] = hospitalName;
    map["officeName"] = officeName;
    map["roomName"] = roomName;
    map["tableStatus"] = tableStatus;
    map["number"] = number;
    map["repairBadReason"] = repairBadReason;
    map["repairBadImg"] = repairBadImg;
    map["orderSn"] = orderSn;
    map["tableStatusStr"] = tableStatusStr;
    map["typeStr"] = typeStr;
    map["imgList"] = imgList;
    map["statusStr"] = statusStr;
    return map;
  }

  void replace(BedsideBedsideTableRepairsListModelData newData) {
    id = newData.id ?? id;
    tableId = newData.tableId ?? tableId;
    openid = newData.openid ?? openid;
    opsId = newData.opsId ?? opsId;
    opsName = newData.opsName ?? opsName;
    type = newData.type ?? type;
    status = newData.status ?? status;
    content = newData.content ?? content;
    img = newData.img ?? img;
    createdAt = newData.createdAt ?? createdAt;
    updatedAt = newData.updatedAt ?? updatedAt;
    finishAt = newData.finishAt ?? finishAt;
    orderId = newData.orderId ?? orderId;
    refundMoney = newData.refundMoney ?? refundMoney;
    hospitalName = newData.hospitalName ?? hospitalName;
    officeName = newData.officeName ?? officeName;
    roomName = newData.roomName ?? roomName;
    tableStatus = newData.tableStatus ?? tableStatus;
    number = newData.number ?? number;
    repairBadReason = newData.repairBadReason ?? repairBadReason;
    repairBadImg = newData.repairBadImg ?? repairBadImg;
    orderSn = newData.orderSn ?? orderSn;
    tableStatusStr = newData.tableStatusStr ?? tableStatusStr;
    typeStr = newData.typeStr ?? typeStr;
    imgList = newData.imgList ?? imgList;
    statusStr = newData.statusStr ?? statusStr;
  }


    List<String> getImaList() {
    return this.img.split(',')..removeLast();
  }

}
