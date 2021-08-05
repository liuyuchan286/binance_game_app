/// totalCount : 5
/// pageSize : 10
/// totalPage : 1
/// currPage : 1
/// list : [{"id":114,"name":"测试1","phone":"18820161165","password":"$2a$10$CbrJrhfzOhnaNi2F1Ik/GeVyKjUVRAMWPIfexoSzuZK4f8G0CJl4.","address":"杭州","createdAt":"2021-05-24 09:22:01","updatedAt":"2021-05-24 09:22:01","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":57,"name":"通辽运维1","phone":"15733296222","password":"$2a$10$D3RqwBpGCqTt1JZf2VWHAu6DjkkxLLpCTnwdX2Wlln6EEjDEMX8Ya","address":"","createdAt":"2020-11-10 09:06:10","updatedAt":"2020-11-10 09:06:10","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":51,"name":"测试01","phone":"17521284396","password":"$2a$10$fvWYYUdSBMN7My0N.SZUIuQ2fQgrWZ8GlwVy/V.N.Ily.yI4StxpC","address":"","createdAt":"2020-10-22 16:24:08","updatedAt":"2020-11-07 20:10:35","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":37,"name":"1","phone":"13295358640","password":"$2a$10$t/TZhn1sxL7vCaKTYi/rrudO.DBOjun7yacLOvG7JeH66EVzpbESi","address":"","createdAt":"2020-09-25 10:30:15","updatedAt":"2020-09-25 10:30:20","deletedAt":"2020-09-25 10:30:20","isManage":1,"isManageStr":"否"},{"id":36,"name":"1","phone":"13978945612","password":"$2a$10$ziGMyXXRkhhP6iBoA2mZ9u8OX6/DgElFL1bwJu5cE43G5P33PMKCq","address":"1","createdAt":"2020-09-25 10:08:57","updatedAt":"2020-09-25 10:09:40","deletedAt":"2020-09-25 10:09:40","isManage":1,"isManageStr":"否"}]

class BedsideBedsideDailyStatisticsListModel {
  int _totalCount;
  int _pageSize;
  int _totalPage;
  int _currPage;
  List<BedsideBedsideDailyStatisticsListModelData> _list;

  int get totalCount => _totalCount;
  int get pageSize => _pageSize;
  int get totalPage => _totalPage;
  int get currPage => _currPage;
  List<BedsideBedsideDailyStatisticsListModelData> get list => _list;

  BedsideBedsideDailyStatisticsListModel({
      int totalCount,
      int pageSize,
      int totalPage,
      int currPage,
      List<BedsideBedsideDailyStatisticsListModelData> list}){
      _totalCount = totalCount;
      _pageSize = pageSize;
      _totalPage = totalPage;
      _currPage = currPage;
      _list = list;
  }

  BedsideBedsideDailyStatisticsListModel.fromJson(dynamic json) {
      _totalCount = json["totalCount"];
      _pageSize = json["pageSize"];
      _totalPage = json["totalPage"];
      _currPage = json["currPage"];
      if (json["list"] != null) {
        _list = [];
        json["list"].forEach((v) {
          _list.add(BedsideBedsideDailyStatisticsListModelData.fromJson(v));
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

class BedsideBedsideDailyStatisticsListModelData {


  int id;
  String date;
  int ordersCount;
  double money0;
  double money1;
  double money2;
  double money3;
  double refundMonty;
  int useCount;
  int countInUse;
  int unlocksCount;
  int tableTotalCount;
  String hospitalName;
  String officeName;
  String roomName;
  int hospitalId;
  int officeId;
  int roomId;
  String createdAt;
  String updatedAt;
  String deletedAt;


  BedsideBedsideDailyStatisticsListModelData({
        this.id,
        this.date,
        this.ordersCount,
        this.money0,
        this.money1,
        this.money2,
        this.money3,
        this.refundMonty,
        this.useCount,
        this.countInUse,
        this.unlocksCount,
        this.tableTotalCount,
        this.hospitalName,
        this.officeName,
        this.roomName,
        this.hospitalId,
        this.officeId,
        this.roomId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
      });

  BedsideBedsideDailyStatisticsListModelData.fromJson(dynamic json) {
    id = json["id"];
    date = json["date"];
    ordersCount = json["ordersCount"];
    money0 = json["money0"];
    money1 = json["money1"];
    money2 = json["money2"];
    money3 = json["money3"];
    refundMonty = json["refundMonty"];
    useCount = json["useCount"];
    countInUse = json["countInUse"];
    unlocksCount = json["unlocksCount"];
    tableTotalCount = json["tableTotalCount"];
    hospitalName = json["hospitalName"];
    officeName = json["officeName"];
    roomName = json["roomName"];
    hospitalId = json["hospitalId"];
    officeId = json["officeId"];
    roomId = json["roomId"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    deletedAt = json["deletedAt"];
  }

  void replace(BedsideBedsideDailyStatisticsListModelData newData) {
  id = newData.id ?? id;
  date = newData.date ?? date;
  ordersCount = newData.ordersCount ?? ordersCount;
  money0 = newData.money0 ?? money0;
  money1 = newData.money1 ?? money1;
  money2 = newData.money2 ?? money2;
  money3 = newData.money3 ?? money3;
  refundMonty = newData.refundMonty ?? refundMonty;
  useCount = newData.useCount ?? useCount;
  countInUse = newData.countInUse ?? countInUse;
  unlocksCount = newData.unlocksCount ?? unlocksCount;
  tableTotalCount = newData.tableTotalCount ?? tableTotalCount;
  hospitalName = newData.hospitalName ?? hospitalName;
  officeName = newData.officeName ?? officeName;
  roomName = newData.roomName ?? roomName;
  hospitalId = newData.hospitalId ?? hospitalId;
  officeId = newData.officeId ?? officeId;
  roomId = newData.roomId ?? roomId;
  createdAt = newData.createdAt ?? createdAt;
  updatedAt = newData.updatedAt ?? updatedAt;
  deletedAt = newData.deletedAt ?? deletedAt;
    }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["date"] = date;
    map["ordersCount"] = ordersCount;
    map["money0"] = money0;
    map["money1"] = money1;
    map["money2"] = money2;
    map["money3"] = money3;
    map["refundMonty"] = refundMonty;
    map["useCount"] = useCount;
    map["countInUse"] = countInUse;
    map["unlocksCount"] = unlocksCount;
    map["tableTotalCount"] = tableTotalCount;
    map["hospitalName"] = hospitalName;
    map["officeName"] = officeName;
    map["roomName"] = roomName;
    map["hospitalId"] = hospitalId;
    map["officeId"] = officeId;
    map["roomId"] = roomId;
    map["createdAt"] = createdAt;
    map["updatedAt"] = updatedAt;
    map["deletedAt"] = deletedAt;
    return map;
  }
}