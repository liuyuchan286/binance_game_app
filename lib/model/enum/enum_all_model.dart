import 'enum_model.dart';

class EnumAllModel {
  String msg;
  List<EnumModel> orderUnlockStatus;
  List<EnumModel> commissionStatus;
  int code;
  List<EnumModel> userNoticeTypes;
  List<EnumModel> orderUnlockType;
  List<EnumModel> orderStatus;
  String message;
  List<EnumModel> orderCommissionChangeMoneyTypes;
  List<EnumModel> tableRepairsStatus;
  List<EnumModel> tableStatus;
  List<EnumModel> tableSource;

  EnumAllModel({
      this.msg, 
      this.orderUnlockStatus, 
      this.commissionStatus, 
      this.code, 
      this.userNoticeTypes, 
      this.orderUnlockType, 
      this.orderStatus, 
      this.message, 
      this.orderCommissionChangeMoneyTypes, 
      this.tableRepairsStatus, 
      this.tableSource,
      this.tableStatus});

  EnumAllModel.fromJson(dynamic json) {
    msg = json["msg"];
    if (json["orderUnlockStatus"] != null) {
      orderUnlockStatus = [
        EnumModel(key: null,value: "请选择开锁状态")..setParam("status")
      ];
      json["orderUnlockStatus"].forEach((v) {
        orderUnlockStatus.add(EnumModel.fromJson(v,param: orderUnlockStatus.first.getParam()));
      });
    }
    if (json["commissionStatus"] != null) {
      commissionStatus = [
        EnumModel(key: null,value: "请选择结算状态")..setParam("status")
      ];
      json["commissionStatus"].forEach((v) {
        commissionStatus.add(EnumModel.fromJson(v,param: commissionStatus.first.getParam()));
      });
    }
    code = json["code"];
    if (json["userNoticeTypes"] != null) {
      userNoticeTypes = [
        EnumModel(key: null,value: "请选择推送类型")..setParam("type")
      ];
      json["userNoticeTypes"].forEach((v) {
        userNoticeTypes.add(EnumModel.fromJson(v,param: userNoticeTypes.first.getParam()));
      });
    }
    if (json["orderUnlockType"] != null) {
      orderUnlockType = [
        EnumModel(key: null,value: "请选择开锁方式")..setParam("type")
      ];
      json["orderUnlockType"].forEach((v) {
        orderUnlockType.add(EnumModel.fromJson(v,param: orderUnlockType.first.getParam()));
      });
    }
    if (json["orderStatus"] != null) {
      orderStatus = [
        EnumModel(key: null,value: "请选择订单状态")..setParam("status")
      ];
      json["orderStatus"].forEach((v) {
        orderStatus.add(EnumModel.fromJson(v,param: orderStatus.first.getParam()));
      });
    }
    message = json["message"];
    if (json["orderCommissionChangeMoneyTypes"] != null) {
      orderCommissionChangeMoneyTypes = [
        EnumModel(key: null,value: "请选择变化类型")..setParam("type")
      ];
      json["orderCommissionChangeMoneyTypes"].forEach((v) {
        orderCommissionChangeMoneyTypes.add(EnumModel.fromJson(v,param: orderCommissionChangeMoneyTypes.first.getParam()));
      });
    }
    if (json["tableRepairsStatus"] != null) {
      tableRepairsStatus = [
        EnumModel(key: null,value: "请选择修理状态")..setParam("status")
      ];
      json["tableRepairsStatus"].forEach((v) {
        tableRepairsStatus.add(EnumModel.fromJson(v,param: tableRepairsStatus.first.getParam()));
      });
    }
    if (json["tableStatus"] != null) {
      tableStatus = [
        EnumModel(key: null,value: "请选择锁状态")..setParam("status")
      ];
      json["tableStatus"].forEach((v) {
        tableStatus.add(EnumModel.fromJson(v,param: tableStatus.first.getParam()));
      });
    }

    if (json["tableSource"] != null) {
      tableSource = [
        EnumModel(key: null,value: "请选择锁厂")..setParam("source")
      ];
      json["tableSource"].forEach((v) {
        tableSource.add(EnumModel.fromJson(v,param: tableSource.first.getParam()));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["msg"] = msg;
    if (orderUnlockStatus != null) {
      map["orderUnlockStatus"] = orderUnlockStatus.map((v) => v.toJson()).toList();
    }
    if (commissionStatus != null) {
      map["commissionStatus"] = commissionStatus.map((v) => v.toJson()).toList();
    }
    map["code"] = code;
    if (userNoticeTypes != null) {
      map["userNoticeTypes"] = userNoticeTypes.map((v) => v.toJson()).toList();
    }
    if (orderUnlockType != null) {
      map["orderUnlockType"] = orderUnlockType.map((v) => v.toJson()).toList();
    }
    if (orderStatus != null) {
      map["orderStatus"] = orderStatus.map((v) => v.toJson()).toList();
    }
    map["message"] = message;
    if (orderCommissionChangeMoneyTypes != null) {
      map["orderCommissionChangeMoneyTypes"] = orderCommissionChangeMoneyTypes.map((v) => v.toJson()).toList();
    }
    if (tableRepairsStatus != null) {
      map["tableRepairsStatus"] = tableRepairsStatus.map((v) => v.toJson()).toList();
    }
    if (tableStatus != null) {
      map["tableStatus"] = tableStatus.map((v) => v.toJson()).toList();
    }
    return map;
  }

}