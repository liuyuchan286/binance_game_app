import 'package:flutter/material.dart';

/// payType : 0
/// money : 0
/// hospitalId : 0
/// startTime : ""
/// id : 0
/// endTime : ""
/// useDay : 0

class HospitalUsetimeListModel {
  int _payType;
  int _money;
  int _hospitalId;
  String _startTime;
  int _id;
  String _endTime;
  int _useDay;

  TextEditingController _startTimeController;
  TextEditingController _endTimeController;
  TextEditingController _useDayController;
  TextEditingController _moneyController;

  int get payType => _payType;
  int get money => _money;
  int get hospitalId => _hospitalId;
  String get startTime => _startTime;
  int get id => _id;
  String get endTime => _endTime;
  int get useDay => _useDay;

  HospitalUsetimeListModel({
      int payType, 
      int money = 0,
      int hospitalId, 
      String startTime, 
      int id, 
      String endTime, 
      int useDay = 1}){
    _payType = payType;
    _money = money;
    _hospitalId = hospitalId;
    _startTime = startTime;
    _id = id;
    _endTime = endTime;
    _useDay = useDay;

    _startTimeController = TextEditingController(text: _startTime);
    _endTimeController = TextEditingController(text: _endTime);
    _useDayController = TextEditingController(text: _useDay.toString());
    _moneyController = TextEditingController(text: _money.toString());
}

  HospitalUsetimeListModel.fromJson(dynamic json) {
    _payType = json["payType"];
    _money = json["money"];
    _hospitalId = json["hospitalId"];
    _startTime = json["startTime"];
    _id = json["id"];
    _endTime = json["endTime"];
    _useDay = json["useDay"];

    _startTimeController = TextEditingController(text: _startTime);
    _endTimeController = TextEditingController(text: _endTime);
    _useDayController = TextEditingController(text: _useDay.toString());
    _moneyController = TextEditingController(text: _money.toString());
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["payType"] = _payType;
    map["money"] = _moneyController.text;
    map["hospitalId"] = _hospitalId;
    map["startTime"] = _startTimeController.text;
    map["id"] = _id;
    map["endTime"] = _endTimeController.text;
    map["useDay"] = _useDayController.text;
    return map;
  }

  TextEditingController get moneyController => _moneyController;

  TextEditingController get useDayController => _useDayController;

  TextEditingController get endTimeController => _endTimeController;

  TextEditingController get startTimeController => _startTimeController;
}