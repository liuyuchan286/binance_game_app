/// totalCount : 5
/// pageSize : 10
/// totalPage : 1
/// currPage : 1
/// list : [{"id":114,"name":"测试1","phone":"18820161165","password":"$2a$10$CbrJrhfzOhnaNi2F1Ik/GeVyKjUVRAMWPIfexoSzuZK4f8G0CJl4.","address":"杭州","createdAt":"2021-05-24 09:22:01","updatedAt":"2021-05-24 09:22:01","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":57,"name":"通辽运维1","phone":"15733296222","password":"$2a$10$D3RqwBpGCqTt1JZf2VWHAu6DjkkxLLpCTnwdX2Wlln6EEjDEMX8Ya","address":"","createdAt":"2020-11-10 09:06:10","updatedAt":"2020-11-10 09:06:10","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":51,"name":"测试01","phone":"17521284396","password":"$2a$10$fvWYYUdSBMN7My0N.SZUIuQ2fQgrWZ8GlwVy/V.N.Ily.yI4StxpC","address":"","createdAt":"2020-10-22 16:24:08","updatedAt":"2020-11-07 20:10:35","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":37,"name":"1","phone":"13295358640","password":"$2a$10$t/TZhn1sxL7vCaKTYi/rrudO.DBOjun7yacLOvG7JeH66EVzpbESi","address":"","createdAt":"2020-09-25 10:30:15","updatedAt":"2020-09-25 10:30:20","deletedAt":"2020-09-25 10:30:20","isManage":1,"isManageStr":"否"},{"id":36,"name":"1","phone":"13978945612","password":"$2a$10$ziGMyXXRkhhP6iBoA2mZ9u8OX6/DgElFL1bwJu5cE43G5P33PMKCq","address":"1","createdAt":"2020-09-25 10:08:57","updatedAt":"2020-09-25 10:09:40","deletedAt":"2020-09-25 10:09:40","isManage":1,"isManageStr":"否"}]

class BedsideBedsideOrderCommissionListModel {
  int _totalCount;
  int _pageSize;
  int _totalPage;
  int _currPage;
  List<BedsideBedsideOrderCommissionListModelData> _list;

  int get totalCount => _totalCount;
  int get pageSize => _pageSize;
  int get totalPage => _totalPage;
  int get currPage => _currPage;
  List<BedsideBedsideOrderCommissionListModelData> get list => _list;

  BedsideBedsideOrderCommissionListModel({
      int totalCount,
      int pageSize,
      int totalPage,
      int currPage,
      List<BedsideBedsideOrderCommissionListModelData> list}){
      _totalCount = totalCount;
      _pageSize = pageSize;
      _totalPage = totalPage;
      _currPage = currPage;
      _list = list;
  }

  BedsideBedsideOrderCommissionListModel.fromJson(dynamic json) {
      _totalCount = json["totalCount"];
      _pageSize = json["pageSize"];
      _totalPage = json["totalPage"];
      _currPage = json["currPage"];
      if (json["list"] != null) {
        _list = [];
        json["list"].forEach((v) {
          _list.add(BedsideBedsideOrderCommissionListModelData.fromJson(v));
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

class BedsideBedsideOrderCommissionListModelData {


  int id;
  int orderId;
  String orderSn;
  int hospitalId;
  String hospitalName;
  double userMoney;
  double wechatMoney;
  int agentId;
  String agentName;
  double commissionRatio;
  double agentMoney;
  double ourMoney;
  String orderCompletionTime;
  int isCompletion;
  String toReviewTime;
  String reviewTime;
  String toWithdrawalTime;
  int status;
  String statusStr;
  String remarks;
  String createdAt;
  String updatedAt;


  BedsideBedsideOrderCommissionListModelData({
        this.id,
        this.orderId,
        this.orderSn,
        this.hospitalId,
        this.hospitalName,
        this.userMoney,
        this.wechatMoney,
        this.agentId,
        this.agentName,
        this.commissionRatio,
        this.agentMoney,
        this.ourMoney,
        this.orderCompletionTime,
        this.isCompletion,
        this.toReviewTime,
        this.reviewTime,
        this.toWithdrawalTime,
        this.status,
        this.statusStr,
        this.remarks,
        this.createdAt,
        this.updatedAt,
      });

  BedsideBedsideOrderCommissionListModelData.fromJson(dynamic json) {
    id = json["id"];
    orderId = json["orderId"];
    orderSn = json["orderSn"];
    hospitalId = json["hospitalId"];
    hospitalName = json["hospitalName"];
    userMoney = json["userMoney"];
    wechatMoney = json["wechatMoney"];
    agentId = json["agentId"];
    agentName = json["agentName"];
    commissionRatio = json["commissionRatio"];
    agentMoney = json["agentMoney"];
    ourMoney = json["ourMoney"];
    orderCompletionTime = json["orderCompletionTime"];
    isCompletion = json["isCompletion"];
    toReviewTime = json["toReviewTime"];
    reviewTime = json["reviewTime"];
    toWithdrawalTime = json["toWithdrawalTime"];
    status = json["status"];
    statusStr = json["statusStr"];
    remarks = json["remarks"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
  }

  void replace(BedsideBedsideOrderCommissionListModelData newData) {
  id = newData.id ?? id;
  orderId = newData.orderId ?? orderId;
  orderSn = newData.orderSn ?? orderSn;
  hospitalId = newData.hospitalId ?? hospitalId;
  hospitalName = newData.hospitalName ?? hospitalName;
  userMoney = newData.userMoney ?? userMoney;
  wechatMoney = newData.wechatMoney ?? wechatMoney;
  agentId = newData.agentId ?? agentId;
  agentName = newData.agentName ?? agentName;
  commissionRatio = newData.commissionRatio ?? commissionRatio;
  agentMoney = newData.agentMoney ?? agentMoney;
  ourMoney = newData.ourMoney ?? ourMoney;
  orderCompletionTime = newData.orderCompletionTime ?? orderCompletionTime;
  isCompletion = newData.isCompletion ?? isCompletion;
  toReviewTime = newData.toReviewTime ?? toReviewTime;
  reviewTime = newData.reviewTime ?? reviewTime;
  toWithdrawalTime = newData.toWithdrawalTime ?? toWithdrawalTime;
  status = newData.status ?? status;
  statusStr = newData.statusStr ?? statusStr;
  remarks = newData.remarks ?? remarks;
  createdAt = newData.createdAt ?? createdAt;
  updatedAt = newData.updatedAt ?? updatedAt;
    }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["orderId"] = orderId;
    map["orderSn"] = orderSn;
    map["hospitalId"] = hospitalId;
    map["hospitalName"] = hospitalName;
    map["userMoney"] = userMoney;
    map["wechatMoney"] = wechatMoney;
    map["agentId"] = agentId;
    map["agentName"] = agentName;
    map["commissionRatio"] = commissionRatio;
    map["agentMoney"] = agentMoney;
    map["ourMoney"] = ourMoney;
    map["orderCompletionTime"] = orderCompletionTime;
    map["isCompletion"] = isCompletion;
    map["toReviewTime"] = toReviewTime;
    map["reviewTime"] = reviewTime;
    map["toWithdrawalTime"] = toWithdrawalTime;
    map["status"] = status;
    map["statusStr"] = statusStr;
    map["remarks"] = remarks;
    map["createdAt"] = createdAt;
    map["updatedAt"] = updatedAt;
    return map;
  }
}
