/// totalCount : 5
/// pageSize : 10
/// totalPage : 1
/// currPage : 1
/// list : [{"id":114,"name":"测试1","phone":"18820161165","password":"$2a$10$CbrJrhfzOhnaNi2F1Ik/GeVyKjUVRAMWPIfexoSzuZK4f8G0CJl4.","address":"杭州","createdAt":"2021-05-24 09:22:01","updatedAt":"2021-05-24 09:22:01","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":57,"name":"通辽运维1","phone":"15733296222","password":"$2a$10$D3RqwBpGCqTt1JZf2VWHAu6DjkkxLLpCTnwdX2Wlln6EEjDEMX8Ya","address":"","createdAt":"2020-11-10 09:06:10","updatedAt":"2020-11-10 09:06:10","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":51,"name":"测试01","phone":"17521284396","password":"$2a$10$fvWYYUdSBMN7My0N.SZUIuQ2fQgrWZ8GlwVy/V.N.Ily.yI4StxpC","address":"","createdAt":"2020-10-22 16:24:08","updatedAt":"2020-11-07 20:10:35","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":37,"name":"1","phone":"13295358640","password":"$2a$10$t/TZhn1sxL7vCaKTYi/rrudO.DBOjun7yacLOvG7JeH66EVzpbESi","address":"","createdAt":"2020-09-25 10:30:15","updatedAt":"2020-09-25 10:30:20","deletedAt":"2020-09-25 10:30:20","isManage":1,"isManageStr":"否"},{"id":36,"name":"1","phone":"13978945612","password":"$2a$10$ziGMyXXRkhhP6iBoA2mZ9u8OX6/DgElFL1bwJu5cE43G5P33PMKCq","address":"1","createdAt":"2020-09-25 10:08:57","updatedAt":"2020-09-25 10:09:40","deletedAt":"2020-09-25 10:09:40","isManage":1,"isManageStr":"否"}]

class BedsideBedsideUserListModel {
  int _totalCount;
  int _pageSize;
  int _totalPage;
  int _currPage;
  List<BedsideBedsideUserListModelData> _list;

  int get totalCount => _totalCount;
  int get pageSize => _pageSize;
  int get totalPage => _totalPage;
  int get currPage => _currPage;
  List<BedsideBedsideUserListModelData> get list => _list;

  BedsideBedsideUserListModel({
      int totalCount,
      int pageSize,
      int totalPage,
      int currPage,
      List<BedsideBedsideUserListModelData> list}){
      _totalCount = totalCount;
      _pageSize = pageSize;
      _totalPage = totalPage;
      _currPage = currPage;
      _list = list;
  }

  BedsideBedsideUserListModel.fromJson(dynamic json) {
      _totalCount = json["totalCount"];
      _pageSize = json["pageSize"];
      _totalPage = json["totalPage"];
      _currPage = json["currPage"];
      if (json["list"] != null) {
        _list = [];
        json["list"].forEach((v) {
          _list.add(BedsideBedsideUserListModelData.fromJson(v));
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

class BedsideBedsideUserListModelData {


  int id;
  String aliUserId;
  String openid;
  String unionid;
  String nickname;
  String avatar;
  int gender;
  String genderStr;
  int type;
  String typeStr;
  double money;
  int number;
  String phoneNumber;
  String mobile;
  String countryCode;
  String country;
  String province;
  String city;
  String brand;
  String model;
  String version;
  String system;
  String platform;
  String sdkVersion;
  String ip;
  String latitude;
  String longitude;
  int isAuth;
  int isMobile;
  int isLocation;
  String createdAt;
  String updatedAt;
  int source;


  BedsideBedsideUserListModelData({
        this.id,
        this.aliUserId,
        this.openid,
        this.unionid,
        this.nickname,
        this.avatar,
        this.gender,
        this.genderStr,
        this.type,
        this.typeStr,
        this.money,
        this.number,
        this.phoneNumber,
        this.mobile,
        this.countryCode,
        this.country,
        this.province,
        this.city,
        this.brand,
        this.model,
        this.version,
        this.system,
        this.platform,
        this.sdkVersion,
        this.ip,
        this.latitude,
        this.longitude,
        this.isAuth,
        this.isMobile,
        this.isLocation,
        this.createdAt,
        this.updatedAt,
        this.source,
      });

  BedsideBedsideUserListModelData.fromJson(dynamic json) {
    id = json["id"];
    aliUserId = json["aliUserId"];
    openid = json["openid"];
    unionid = json["unionid"];
    nickname = json["nickname"];
    avatar = json["avatar"];
    gender = json["gender"];
    genderStr = json["genderStr"];
    type = json["type"];
    typeStr = json["typeStr"];
    money = json["money"];
    number = json["number"];
    phoneNumber = json["phoneNumber"];
    mobile = json["mobile"];
    countryCode = json["countryCode"];
    country = json["country"];
    province = json["province"];
    city = json["city"];
    brand = json["brand"];
    model = json["model"];
    version = json["version"];
    system = json["system"];
    platform = json["platform"];
    sdkVersion = json["sdkVersion"];
    ip = json["ip"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    isAuth = json["isAuth"];
    isMobile = json["isMobile"];
    isLocation = json["isLocation"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    source = json["source"];
  }

  void replace(BedsideBedsideUserListModelData newData) {
  id = newData.id ?? id;
  aliUserId = newData.aliUserId ?? aliUserId;
  openid = newData.openid ?? openid;
  unionid = newData.unionid ?? unionid;
  nickname = newData.nickname ?? nickname;
  avatar = newData.avatar ?? avatar;
  gender = newData.gender ?? gender;
  genderStr = newData.genderStr ?? genderStr;
  type = newData.type ?? type;
  typeStr = newData.typeStr ?? typeStr;
  money = newData.money ?? money;
  number = newData.number ?? number;
  phoneNumber = newData.phoneNumber ?? phoneNumber;
  mobile = newData.mobile ?? mobile;
  countryCode = newData.countryCode ?? countryCode;
  country = newData.country ?? country;
  province = newData.province ?? province;
  city = newData.city ?? city;
  brand = newData.brand ?? brand;
  model = newData.model ?? model;
  version = newData.version ?? version;
  system = newData.system ?? system;
  platform = newData.platform ?? platform;
  sdkVersion = newData.sdkVersion ?? sdkVersion;
  ip = newData.ip ?? ip;
  latitude = newData.latitude ?? latitude;
  longitude = newData.longitude ?? longitude;
  isAuth = newData.isAuth ?? isAuth;
  isMobile = newData.isMobile ?? isMobile;
  isLocation = newData.isLocation ?? isLocation;
  createdAt = newData.createdAt ?? createdAt;
  updatedAt = newData.updatedAt ?? updatedAt;
  source = newData.source ?? source;
    }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["aliUserId"] = aliUserId;
    map["openid"] = openid;
    map["unionid"] = unionid;
    map["nickname"] = nickname;
    map["avatar"] = avatar;
    map["gender"] = gender;
    map["genderStr"] = genderStr;
    map["type"] = type;
    map["typeStr"] = typeStr;
    map["money"] = money;
    map["number"] = number;
    map["phoneNumber"] = phoneNumber;
    map["mobile"] = mobile;
    map["countryCode"] = countryCode;
    map["country"] = country;
    map["province"] = province;
    map["city"] = city;
    map["brand"] = brand;
    map["model"] = model;
    map["version"] = version;
    map["system"] = system;
    map["platform"] = platform;
    map["sdkVersion"] = sdkVersion;
    map["ip"] = ip;
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    map["isAuth"] = isAuth;
    map["isMobile"] = isMobile;
    map["isLocation"] = isLocation;
    map["createdAt"] = createdAt;
    map["updatedAt"] = updatedAt;
    map["source"] = source;
    return map;
  }
}
