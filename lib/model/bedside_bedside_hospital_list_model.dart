import 'package:binance_game_app/model/bedside_agent_hospital_table_column_model.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_usetime_list_model.dart';
import 'package:binance_game_app/model/picker/single_list_picker_model.dart';
import 'package:binance_game_app/model/search_model.dart';

/// totalCount : 5
/// pageSize : 10
/// totalPage : 1
/// currPage : 1
/// list : [{"id":114,"name":"测试1","phone":"18820161165","password":"$2a$10$CbrJrhfzOhnaNi2F1Ik/GeVyKjUVRAMWPIfexoSzuZK4f8G0CJl4.","address":"杭州","createdAt":"2021-05-24 09:22:01","updatedAt":"2021-05-24 09:22:01","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":57,"name":"通辽运维1","phone":"15733296222","password":"$2a$10$D3RqwBpGCqTt1JZf2VWHAu6DjkkxLLpCTnwdX2Wlln6EEjDEMX8Ya","address":"","createdAt":"2020-11-10 09:06:10","updatedAt":"2020-11-10 09:06:10","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":51,"name":"测试01","phone":"17521284396","password":"$2a$10$fvWYYUdSBMN7My0N.SZUIuQ2fQgrWZ8GlwVy/V.N.Ily.yI4StxpC","address":"","createdAt":"2020-10-22 16:24:08","updatedAt":"2020-11-07 20:10:35","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":37,"name":"1","phone":"13295358640","password":"$2a$10$t/TZhn1sxL7vCaKTYi/rrudO.DBOjun7yacLOvG7JeH66EVzpbESi","address":"","createdAt":"2020-09-25 10:30:15","updatedAt":"2020-09-25 10:30:20","deletedAt":"2020-09-25 10:30:20","isManage":1,"isManageStr":"否"},{"id":36,"name":"1","phone":"13978945612","password":"$2a$10$ziGMyXXRkhhP6iBoA2mZ9u8OX6/DgElFL1bwJu5cE43G5P33PMKCq","address":"1","createdAt":"2020-09-25 10:08:57","updatedAt":"2020-09-25 10:09:40","deletedAt":"2020-09-25 10:09:40","isManage":1,"isManageStr":"否"}]

class BedsideBedsideHospitalListModel {
  int _totalCount;
  int _pageSize;
  int _totalPage;
  int _currPage;
  List<BedsideBedsideHospitalListModelData> _list;

  int get totalCount => _totalCount;
  int get pageSize => _pageSize;
  int get totalPage => _totalPage;
  int get currPage => _currPage;
  List<BedsideBedsideHospitalListModelData> get list => _list;

  BedsideBedsideHospitalListModel({
      int totalCount,
      int pageSize,
      int totalPage,
      int currPage,
      List<BedsideBedsideHospitalListModelData> list}){
      _totalCount = totalCount;
      _pageSize = pageSize;
      _totalPage = totalPage;
      _currPage = currPage;
      _list = list;
  }

  BedsideBedsideHospitalListModel.fromJson(dynamic json) {
      _totalCount = json["totalCount"];
      _pageSize = json["pageSize"];
      _totalPage = json["totalPage"];
      _currPage = json["currPage"];
      if (json["list"] != null) {
        _list = [];
        json["list"].forEach((v) {
          _list.add(BedsideBedsideHospitalListModelData.fromJson(v));
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

class BedsideBedsideHospitalListModelData extends SearchModel with SingleListPickerModel,BedsideAgentHospitalTableColumnModel{


  int id;
  String name;
  String password;
  String contact;
  String phone;
  String province;
  String city;
  String county;
  String address;
  dynamic startTime;
  dynamic endTime;
  double money;
  double deposit;
  double minimumDeposit;
  String depositBanner;
  int freeTrialTime;
  int sysUserId;
  String rememberToken;
  String createdAt;
  String updatedAt;
  String deletedAt;
  int payType;
  int isDelay;
  int timeoutMinutes;
  double deductionStandard;
  int isDayCard;
  int isAutomaticRenewal;
  List<BedsideBedsideHospitalUsetimeListModelData> usetimeVOS;
  List<BedsideBedsideHospitalUsetimeListModelData> usetimesDayCard;
  List<BedsideBedsideHospitalUsetimeListModelData> hospitalUsetimes;
  List<BedsideBedsideHospitalUsetimeListModelData> hospitalUsetimesDayCard;


  BedsideBedsideHospitalListModelData({
        this.id,
        this.name,
        this.password,
        this.contact,
        this.phone,
        this.province,
        this.city,
        this.county,
        this.address,
        this.startTime,
        this.endTime,
        this.money,
        this.deposit,
        this.minimumDeposit,
        this.depositBanner,
        this.freeTrialTime,
        this.sysUserId,
        this.rememberToken,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.payType,
        this.isDelay,
        this.timeoutMinutes,
        this.deductionStandard,
        this.isDayCard,
        this.isAutomaticRenewal,
        this.usetimeVOS,
        this.usetimesDayCard,
        this.hospitalUsetimes,
        this.hospitalUsetimesDayCard,
      });

  BedsideBedsideHospitalListModelData.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    password = json["password"];
    contact = json["contact"];
    phone = json["phone"];
    province = json["province"];
    city = json["city"];
    county = json["county"];
    address = json["address"];
    startTime = json["startTime"];
    endTime = json["endTime"];
    money = json["money"];
    deposit = json["deposit"];
    minimumDeposit = json["minimumDeposit"];
    depositBanner = json["depositBanner"];
    freeTrialTime = json["freeTrialTime"];
    sysUserId = json["sysUserId"];
    rememberToken = json["rememberToken"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    deletedAt = json["deletedAt"];
    payType = json["payType"];
    isDelay = json["isDelay"];
    timeoutMinutes = json["timeoutMinutes"];
    deductionStandard = json["deductionStandard"];
    isDayCard = json["isDayCard"];
    isAutomaticRenewal = json["isAutomaticRenewal"];
    if (json["usetimeVOS"] != null) {
      usetimeVOS = [];
      json["usetimeVOS"].forEach((v) {
        usetimeVOS.add(BedsideBedsideHospitalUsetimeListModelData.fromJson(v));
      });
    }

    if (json["usetimesDayCard"] != null) {
      usetimesDayCard = [];
      json["usetimesDayCard"].forEach((v) {
        usetimesDayCard.add(BedsideBedsideHospitalUsetimeListModelData.fromJson(v));
      });
    }
  }

  void replace(BedsideBedsideHospitalListModelData newData) {
  id = newData.id ?? id;
  name = newData.name ?? name;
  password = newData.password ?? password;
  contact = newData.contact ?? contact;
  phone = newData.phone ?? phone;
  province = newData.province ?? province;
  city = newData.city ?? city;
  county = newData.county ?? county;
  address = newData.address ?? address;
  startTime = newData.startTime ?? startTime;
  endTime = newData.endTime ?? endTime;
  money = newData.money ?? money;
  deposit = newData.deposit ?? deposit;
  minimumDeposit = newData.minimumDeposit ?? minimumDeposit;
  depositBanner = newData.depositBanner ?? depositBanner;
  freeTrialTime = newData.freeTrialTime ?? freeTrialTime;
  sysUserId = newData.sysUserId ?? sysUserId;
  rememberToken = newData.rememberToken ?? rememberToken;
  createdAt = newData.createdAt ?? createdAt;
  updatedAt = newData.updatedAt ?? updatedAt;
  deletedAt = newData.deletedAt ?? deletedAt;
  payType = newData.payType ?? payType;
  isDelay = newData.isDelay ?? isDelay;
  timeoutMinutes = newData.timeoutMinutes ?? timeoutMinutes;
  deductionStandard = newData.deductionStandard ?? deductionStandard;
  isDayCard = newData.isDayCard ?? isDayCard;
  isAutomaticRenewal = newData.isAutomaticRenewal ?? isAutomaticRenewal;
  usetimeVOS = newData.usetimeVOS ?? usetimeVOS;
  usetimesDayCard = newData.usetimesDayCard ?? usetimesDayCard;
    }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["password"] = password;
    map["contact"] = contact;
    map["phone"] = phone;
    map["province"] = province;
    map["city"] = city;
    map["county"] = county;
    map["address"] = address;
    map["startTime"] = startTime;
    map["endTime"] = endTime;
    map["money"] = money;
    map["deposit"] = deposit;
    map["minimumDeposit"] = minimumDeposit;
    map["depositBanner"] = depositBanner;
    map["freeTrialTime"] = freeTrialTime;
    map["sysUserId"] = sysUserId;
    map["rememberToken"] = rememberToken;
    map["createdAt"] = createdAt;
    map["updatedAt"] = updatedAt;
    map["deletedAt"] = deletedAt;
    map["payType"] = payType;
    map["isDelay"] = isDelay;
    map["timeoutMinutes"] = timeoutMinutes;
    map["deductionStandard"] = deductionStandard;
    map["isDayCard"] = isDayCard;
    map["isAutomaticRenewal"] = isAutomaticRenewal;
    map["usetimeVOS"] = usetimeVOS;
    map["usetimesDayCard"] = usetimesDayCard;
    map["hospitalUsetimes"] = hospitalUsetimes;
    map["hospitalUsetimesDayCard"] = hospitalUsetimesDayCard;
    return map;
  }

  @override
  int getIndex() {
  }

  @override
  String getValue() {
    return name;
  }

  @override
  int getKey() {
    return id;
  }

  @override
  String getParam() {
    return 'hospitalId';
  }
  
  String getUsetimeAll() {
    return usetimeVOS.map((e) => "(${e.startTimeController.text}-${e.endTimeController.text})-${e.moneyController.text}(元)").join("\n");
  }

  @override
  int getId() {
    return id;
  }

  @override
  String getName() {
    return name;
  }

  @override
  bool disabled() {
    return false;
  }

  @override
  bool selected() {
    return false;
  }
}
