/// totalCount : 5
/// pageSize : 10
/// totalPage : 1
/// currPage : 1
/// list : [{"id":114,"name":"测试1","phone":"18820161165","password":"$2a$10$CbrJrhfzOhnaNi2F1Ik/GeVyKjUVRAMWPIfexoSzuZK4f8G0CJl4.","address":"杭州","createdAt":"2021-05-24 09:22:01","updatedAt":"2021-05-24 09:22:01","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":57,"name":"通辽运维1","phone":"15733296222","password":"$2a$10$D3RqwBpGCqTt1JZf2VWHAu6DjkkxLLpCTnwdX2Wlln6EEjDEMX8Ya","address":"","createdAt":"2020-11-10 09:06:10","updatedAt":"2020-11-10 09:06:10","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":51,"name":"测试01","phone":"17521284396","password":"$2a$10$fvWYYUdSBMN7My0N.SZUIuQ2fQgrWZ8GlwVy/V.N.Ily.yI4StxpC","address":"","createdAt":"2020-10-22 16:24:08","updatedAt":"2020-11-07 20:10:35","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":37,"name":"1","phone":"13295358640","password":"$2a$10$t/TZhn1sxL7vCaKTYi/rrudO.DBOjun7yacLOvG7JeH66EVzpbESi","address":"","createdAt":"2020-09-25 10:30:15","updatedAt":"2020-09-25 10:30:20","deletedAt":"2020-09-25 10:30:20","isManage":1,"isManageStr":"否"},{"id":36,"name":"1","phone":"13978945612","password":"$2a$10$ziGMyXXRkhhP6iBoA2mZ9u8OX6/DgElFL1bwJu5cE43G5P33PMKCq","address":"1","createdAt":"2020-09-25 10:08:57","updatedAt":"2020-09-25 10:09:40","deletedAt":"2020-09-25 10:09:40","isManage":1,"isManageStr":"否"}]

class BedsideBedsideOrderListModel {
  int _totalCount;
  int _pageSize;
  int _totalPage;
  int _currPage;
  List<BedsideBedsideOrderListModelData> _list;

  int get totalCount => _totalCount;
  int get pageSize => _pageSize;
  int get totalPage => _totalPage;
  int get currPage => _currPage;
  List<BedsideBedsideOrderListModelData> get list => _list;

  BedsideBedsideOrderListModel({
      int totalCount,
      int pageSize,
      int totalPage,
      int currPage,
      List<BedsideBedsideOrderListModelData> list}){
      _totalCount = totalCount;
      _pageSize = pageSize;
      _totalPage = totalPage;
      _currPage = currPage;
      _list = list;
  }

  BedsideBedsideOrderListModel.fromJson(dynamic json) {
      _totalCount = json["totalCount"];
      _pageSize = json["pageSize"];
      _totalPage = json["totalPage"];
      _currPage = json["currPage"];
      if (json["list"] != null) {
        _list = [];
        json["list"].forEach((v) {
          _list.add(BedsideBedsideOrderListModelData.fromJson(v));
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

class BedsideBedsideOrderListModelData {


  int id;
  String orderSn;
  String number;
  String openid;
  int tableId;
  int status;
  String statusStr;
  int time;
  double money;
  int num;
  String createdAt;
  String updatedAt;
  String payAt;
  String endAt;
  int refundStatus;
  int type;
  int payType;
  String payTypeStr;
  int freeTrialTime;
  double hourMoney;
  int userId;
  String useEndAt;
  int usetimeId;
  int tableStatus;
  String hospitalName;
  String officeName;
  String roomName;
  int hospitalId;
  int officeId;
  int roomId;
  String phoneNumber;
  String userPhone;
  String refundAt;
  int payPlatform;
  int bedId;
  String bedName;


  BedsideBedsideOrderListModelData({
        this.id,
        this.orderSn,
        this.number,
        this.openid,
        this.tableId,
        this.status,
        this.statusStr,
        this.time,
        this.money,
        this.num,
        this.createdAt,
        this.updatedAt,
        this.payAt,
        this.endAt,
        this.refundStatus,
        this.type,
        this.payType,
        this.payTypeStr,
        this.freeTrialTime,
        this.hourMoney,
        this.userId,
        this.useEndAt,
        this.usetimeId,
        this.tableStatus,
        this.hospitalName,
        this.officeName,
        this.roomName,
        this.hospitalId,
        this.officeId,
        this.roomId,
        this.phoneNumber,
        this.userPhone,
        this.refundAt,
        this.payPlatform,
        this.bedId,
        this.bedName,
      });

  BedsideBedsideOrderListModelData.fromJson(dynamic json) {
    id = json["id"];
    orderSn = json["orderSn"];
    number = json["number"];
    openid = json["openid"];
    tableId = json["tableId"];
    status = json["status"];
    statusStr = json["statusStr"];
    time = json["time"];
    money = json["money"];
    num = json["num"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    payAt = json["payAt"];
    endAt = json["endAt"];
    refundStatus = json["refundStatus"];
    type = json["type"];
    payType = json["payType"];
    payTypeStr = json["payTypeStr"];
    freeTrialTime = json["freeTrialTime"];
    hourMoney = json["hourMoney"];
    userId = json["userId"];
    useEndAt = json["useEndAt"];
    usetimeId = json["usetimeId"];
    tableStatus = json["tableStatus"];
    hospitalName = json["hospitalName"];
    officeName = json["officeName"];
    roomName = json["roomName"];
    hospitalId = json["hospitalId"];
    officeId = json["officeId"];
    roomId = json["roomId"];
    phoneNumber = json["phoneNumber"];
    userPhone = json["userPhone"];
    refundAt = json["refundAt"];
    payPlatform = json["payPlatform"];
    bedId = json["bedId"];
    bedName = json["bedName"];
  }

  void replace(BedsideBedsideOrderListModelData newData) {
  id = newData.id ?? id;
  orderSn = newData.orderSn ?? orderSn;
  number = newData.number ?? number;
  openid = newData.openid ?? openid;
  tableId = newData.tableId ?? tableId;
  status = newData.status ?? status;
  statusStr = newData.statusStr ?? statusStr;
  time = newData.time ?? time;
  money = newData.money ?? money;
  num = newData.num ?? num;
  createdAt = newData.createdAt ?? createdAt;
  updatedAt = newData.updatedAt ?? updatedAt;
  payAt = newData.payAt ?? payAt;
  endAt = newData.endAt ?? endAt;
  refundStatus = newData.refundStatus ?? refundStatus;
  type = newData.type ?? type;
  payType = newData.payType ?? payType;
  payTypeStr = newData.payTypeStr ?? payTypeStr;
  freeTrialTime = newData.freeTrialTime ?? freeTrialTime;
  hourMoney = newData.hourMoney ?? hourMoney;
  userId = newData.userId ?? userId;
  useEndAt = newData.useEndAt ?? useEndAt;
  usetimeId = newData.usetimeId ?? usetimeId;
  tableStatus = newData.tableStatus ?? tableStatus;
  hospitalName = newData.hospitalName ?? hospitalName;
  officeName = newData.officeName ?? officeName;
  roomName = newData.roomName ?? roomName;
  hospitalId = newData.hospitalId ?? hospitalId;
  officeId = newData.officeId ?? officeId;
  roomId = newData.roomId ?? roomId;
  phoneNumber = newData.phoneNumber ?? phoneNumber;
  userPhone = newData.userPhone ?? userPhone;
  refundAt = newData.refundAt ?? refundAt;
  payPlatform = newData.payPlatform ?? payPlatform;
  bedId = newData.bedId ?? bedId;
  bedName = newData.bedName ?? bedName;
    }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["orderSn"] = orderSn;
    map["number"] = number;
    map["openid"] = openid;
    map["tableId"] = tableId;
    map["status"] = status;
    map["statusStr"] = statusStr;
    map["time"] = time;
    map["money"] = money;
    map["num"] = num;
    map["createdAt"] = createdAt;
    map["updatedAt"] = updatedAt;
    map["payAt"] = payAt;
    map["endAt"] = endAt;
    map["refundStatus"] = refundStatus;
    map["type"] = type;
    map["payType"] = payType;
    map["payTypeStr"] = payTypeStr;
    map["freeTrialTime"] = freeTrialTime;
    map["hourMoney"] = hourMoney;
    map["userId"] = userId;
    map["useEndAt"] = useEndAt;
    map["usetimeId"] = usetimeId;
    map["tableStatus"] = tableStatus;
    map["hospitalName"] = hospitalName;
    map["officeName"] = officeName;
    map["roomName"] = roomName;
    map["hospitalId"] = hospitalId;
    map["officeId"] = officeId;
    map["roomId"] = roomId;
    map["phoneNumber"] = phoneNumber;
    map["userPhone"] = userPhone;
    map["refundAt"] = refundAt;
    map["payPlatform"] = payPlatform;
    map["bedId"] = bedId;
    map["bedName"] = bedName;
    return map;
  }
}
