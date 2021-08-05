import 'package:binance_game_app/model/picker/single_list_picker_model.dart';
import 'package:binance_game_app/model/search_model.dart';

import 'bedside_agent_hospital_table_column_model.dart';
/// totalCount : 5
/// pageSize : 10
/// totalPage : 1
/// currPage : 1
/// list : [{"id":114,"name":"测试1","phone":"18820161165","password":"$2a$10$CbrJrhfzOhnaNi2F1Ik/GeVyKjUVRAMWPIfexoSzuZK4f8G0CJl4.","address":"杭州","createdAt":"2021-05-24 09:22:01","updatedAt":"2021-05-24 09:22:01","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":57,"name":"通辽运维1","phone":"15733296222","password":"$2a$10$D3RqwBpGCqTt1JZf2VWHAu6DjkkxLLpCTnwdX2Wlln6EEjDEMX8Ya","address":"","createdAt":"2020-11-10 09:06:10","updatedAt":"2020-11-10 09:06:10","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":51,"name":"测试01","phone":"17521284396","password":"$2a$10$fvWYYUdSBMN7My0N.SZUIuQ2fQgrWZ8GlwVy/V.N.Ily.yI4StxpC","address":"","createdAt":"2020-10-22 16:24:08","updatedAt":"2020-11-07 20:10:35","deletedAt":null,"isManage":1,"isManageStr":"否"},{"id":37,"name":"1","phone":"13295358640","password":"$2a$10$t/TZhn1sxL7vCaKTYi/rrudO.DBOjun7yacLOvG7JeH66EVzpbESi","address":"","createdAt":"2020-09-25 10:30:15","updatedAt":"2020-09-25 10:30:20","deletedAt":"2020-09-25 10:30:20","isManage":1,"isManageStr":"否"},{"id":36,"name":"1","phone":"13978945612","password":"$2a$10$ziGMyXXRkhhP6iBoA2mZ9u8OX6/DgElFL1bwJu5cE43G5P33PMKCq","address":"1","createdAt":"2020-09-25 10:08:57","updatedAt":"2020-09-25 10:09:40","deletedAt":"2020-09-25 10:09:40","isManage":1,"isManageStr":"否"}]

class BedsideBedsideHospitalRoomListModel {
  int _totalCount;
  int _pageSize;
  int _totalPage;
  int _currPage;
  List<BedsideBedsideHospitalRoomListModelData> _list;

  int get totalCount => _totalCount;
  int get pageSize => _pageSize;
  int get totalPage => _totalPage;
  int get currPage => _currPage;
  List<BedsideBedsideHospitalRoomListModelData> get list => _list;

  BedsideBedsideHospitalRoomListModel({
      int totalCount,
      int pageSize,
      int totalPage,
      int currPage,
      List<BedsideBedsideHospitalRoomListModelData> list}){
      _totalCount = totalCount;
      _pageSize = pageSize;
      _totalPage = totalPage;
      _currPage = currPage;
      _list = list;
  }

  BedsideBedsideHospitalRoomListModel.fromJson(dynamic json) {
      _totalCount = json["totalCount"];
      _pageSize = json["pageSize"];
      _totalPage = json["totalPage"];
      _currPage = json["currPage"];
      if (json["list"] != null) {
        _list = [];
        json["list"].forEach((v) {
          _list.add(BedsideBedsideHospitalRoomListModelData.fromJson(v));
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

class BedsideBedsideHospitalRoomListModelData extends SearchModel with SingleListPickerModel,BedsideAgentHospitalTableColumnModel{


  int id;
  int hospitalId;
  int officeId;
  String name;
  String createdAt;
  String updatedAt;
  String deletedAt;


  BedsideBedsideHospitalRoomListModelData({
        this.id,
        this.hospitalId,
        this.officeId,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
      });

  BedsideBedsideHospitalRoomListModelData.fromJson(dynamic json) {
    id = json["id"];
    hospitalId = json["hospitalId"];
    officeId = json["officeId"];
    name = json["name"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    deletedAt = json["deletedAt"];
  }

  void replace(BedsideBedsideHospitalRoomListModelData newData) {
  id = newData.id ?? id;
  hospitalId = newData.hospitalId ?? hospitalId;
  officeId = newData.officeId ?? officeId;
  name = newData.name ?? name;
  createdAt = newData.createdAt ?? createdAt;
  updatedAt = newData.updatedAt ?? updatedAt;
  deletedAt = newData.deletedAt ?? deletedAt;
    }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["hospitalId"] = hospitalId;
    map["officeId"] = officeId;
    map["name"] = name;
    map["createdAt"] = createdAt;
    map["updatedAt"] = updatedAt;
    map["deletedAt"] = deletedAt;
    return map;
  }

  @override
  int getIndex() {

  }

  String getParam() {
    return 'roomId';
  }

  @override
  int getKey() {
    return id;
  }

  @override
  String getValue() {
    return name;
  }

  @override
  bool disabled() {
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
  bool selected() {
  }
}
