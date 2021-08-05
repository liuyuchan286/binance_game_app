/// totalCount : 5
/// pageSize : 10
/// totalPage : 1
/// currPage : 1
/// list : [{"id":114,"name":"测试1","phone":"18820161165","password":"$2a$10$CbrJrhfzOhnaNi2F1Ik/GeVyKjUVRAMWPIfexoSzuZK4f8G0CJl4.","address":"杭州","createdAt":"2021-05-24 09:22:01","updatedAt":"2021-05-24 09:22:01","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":57,"name":"通辽运维1","phone":"15733296222","password":"$2a$10$D3RqwBpGCqTt1JZf2VWHAu6DjkkxLLpCTnwdX2Wlln6EEjDEMX8Ya","address":"","createdAt":"2020-11-10 09:06:10","updatedAt":"2020-11-10 09:06:10","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":51,"name":"测试01","phone":"17521284396","password":"$2a$10$fvWYYUdSBMN7My0N.SZUIuQ2fQgrWZ8GlwVy/V.N.Ily.yI4StxpC","address":"","createdAt":"2020-10-22 16:24:08","updatedAt":"2020-11-07 20:10:35","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":37,"name":"1","phone":"13295358640","password":"$2a$10$t/TZhn1sxL7vCaKTYi/rrudO.DBOjun7yacLOvG7JeH66EVzpbESi","address":"","createdAt":"2020-09-25 10:30:15","updatedAt":"2020-09-25 10:30:20","deletedAt":"2020-09-25 10:30:20","isManage":1,"isManageStr":"否"},{"id":36,"name":"1","phone":"13978945612","password":"$2a$10$ziGMyXXRkhhP6iBoA2mZ9u8OX6/DgElFL1bwJu5cE43G5P33PMKCq","address":"1","createdAt":"2020-09-25 10:08:57","updatedAt":"2020-09-25 10:09:40","deletedAt":"2020-09-25 10:09:40","isManage":1,"isManageStr":"否"}]

class BedsideBedsideUserHospitalDepositRefundOrderListModel {
  int _totalCount;
  int _pageSize;
  int _totalPage;
  int _currPage;
  List<BedsideBedsideUserHospitalDepositRefundOrderListModelData> _list;

  int get totalCount => _totalCount;
  int get pageSize => _pageSize;
  int get totalPage => _totalPage;
  int get currPage => _currPage;
  List<BedsideBedsideUserHospitalDepositRefundOrderListModelData> get list => _list;

  BedsideBedsideUserHospitalDepositRefundOrderListModel({
      int totalCount,
      int pageSize,
      int totalPage,
      int currPage,
      List<BedsideBedsideUserHospitalDepositRefundOrderListModelData> list}){
      _totalCount = totalCount;
      _pageSize = pageSize;
      _totalPage = totalPage;
      _currPage = currPage;
      _list = list;
  }

  BedsideBedsideUserHospitalDepositRefundOrderListModel.fromJson(dynamic json) {
      _totalCount = json["totalCount"];
      _pageSize = json["pageSize"];
      _totalPage = json["totalPage"];
      _currPage = json["currPage"];
      if (json["list"] != null) {
        _list = [];
        json["list"].forEach((v) {
          _list.add(BedsideBedsideUserHospitalDepositRefundOrderListModelData.fromJson(v));
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

class BedsideBedsideUserHospitalDepositRefundOrderListModelData {


  int id;
  int userId;
  String openid;
  String nickname;
  String hospitalName;
  String phoneNumber;
  int hospitalId;
  String orderSn;
  double userDeposit;
  double refundDeposit;
  int refundStatus;
  String refundStatusStr;
  int refundSource;
  String refundSourceStr;
  String createdAt;
  String updatedAt;
  String deletedAt;


  BedsideBedsideUserHospitalDepositRefundOrderListModelData({
        this.id,
        this.userId,
        this.openid,
        this.nickname,
        this.hospitalName,
        this.phoneNumber,
        this.hospitalId,
        this.orderSn,
        this.userDeposit,
        this.refundDeposit,
        this.refundStatus,
        this.refundStatusStr,
        this.refundSource,
        this.refundSourceStr,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
      });

  BedsideBedsideUserHospitalDepositRefundOrderListModelData.fromJson(dynamic json) {
    id = json["id"];
    userId = json["userId"];
    openid = json["openid"];
    nickname = json["nickname"];
    hospitalName = json["hospitalName"];
    phoneNumber = json["phoneNumber"];
    hospitalId = json["hospitalId"];
    orderSn = json["orderSn"];
    userDeposit = json["userDeposit"];
    refundDeposit = json["refundDeposit"];
    refundStatus = json["refundStatus"];
    refundStatusStr = json["refundStatusStr"];
    refundSource = json["refundSource"];
    refundSourceStr = json["refundSourceStr"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    deletedAt = json["deletedAt"];
  }

  void replace(BedsideBedsideUserHospitalDepositRefundOrderListModelData newData) {
  id = newData.id ?? id;
  userId = newData.userId ?? userId;
  openid = newData.openid ?? openid;
  nickname = newData.nickname ?? nickname;
  hospitalName = newData.hospitalName ?? hospitalName;
  phoneNumber = newData.phoneNumber ?? phoneNumber;
  hospitalId = newData.hospitalId ?? hospitalId;
  orderSn = newData.orderSn ?? orderSn;
  userDeposit = newData.userDeposit ?? userDeposit;
  refundDeposit = newData.refundDeposit ?? refundDeposit;
  refundStatus = newData.refundStatus ?? refundStatus;
  refundStatusStr = newData.refundStatusStr ?? refundStatusStr;
  refundSource = newData.refundSource ?? refundSource;
  refundSourceStr = newData.refundSourceStr ?? refundSourceStr;
  createdAt = newData.createdAt ?? createdAt;
  updatedAt = newData.updatedAt ?? updatedAt;
  deletedAt = newData.deletedAt ?? deletedAt;
    }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["userId"] = userId;
    map["openid"] = openid;
    map["nickname"] = nickname;
    map["hospitalName"] = hospitalName;
    map["phoneNumber"] = phoneNumber;
    map["hospitalId"] = hospitalId;
    map["orderSn"] = orderSn;
    map["userDeposit"] = userDeposit;
    map["refundDeposit"] = refundDeposit;
    map["refundStatus"] = refundStatus;
    map["refundStatusStr"] = refundStatusStr;
    map["refundSource"] = refundSource;
    map["refundSourceStr"] = refundSourceStr;
    map["createdAt"] = createdAt;
    map["updatedAt"] = updatedAt;
    map["deletedAt"] = deletedAt;
    return map;
  }
}
