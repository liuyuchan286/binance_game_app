
import 'package:flutter/material.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_list_model.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_office_list_model.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_room_list_model.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_hospital/bedside_bedside_hospital_view_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_hospital_office/bedside_bedside_hospital_office_view_model.bak.dart';
import 'package:binance_game_app/view_model/bedside_bedside_hospital_room/bedside_bedside_hospital_room_view_model.bak.dart';

class BedsideBedsideHospitalSelectViewModel extends BaseViewModel {


  BedsideBedsideHospitalViewModel _hospitalViewModel = BedsideBedsideHospitalViewModel();

  BedsideBedsideHospitalOfficeViewModel _officeViewModel = BedsideBedsideHospitalOfficeViewModel();

  BedsideBedsideHospitalRoomViewModel _roomViewModel = BedsideBedsideHospitalRoomViewModel();


  ValueNotifier<List<BedsideBedsideHospitalListModelData>> hospitalValueNotifier = ValueNotifier([]);

  ValueNotifier<List<BedsideBedsideHospitalOfficeListModelData>> officeValueNotifier = ValueNotifier([
    BedsideBedsideHospitalOfficeListModelData(name: "请选择科室")
  ]);

  ValueNotifier<List<BedsideBedsideHospitalRoomListModelData>> roomValueNotifier = ValueNotifier([
    BedsideBedsideHospitalRoomListModelData(name: "请选择房间")
  ]);

  List<BedsideBedsideHospitalListModelData> bedsideBedsideHospitalListModelDatas = [];


  void bedsideBedsideHospitalListAll({success}) {
    super.openLoading();
    _hospitalViewModel.bedsideBedsideHospitalListAll(success: (list) {
      bedsideBedsideHospitalListModelDatas = list;
      bedsideBedsideHospitalListModelDatas.first = BedsideBedsideHospitalListModelData(
        name: "请选择医院"
      );
      super.closeLoading();
    },error: (onError) {
      super.closeLoading();
    });
  }

  void bedsideBedsideHospitalOfficeListAll(int hospitalId,{success}) {
    officeValueNotifier.value = [];
    _officeViewModel.bedsideBedsideHospitalOfficeListAll(hospitalId,success: (list){
      officeValueNotifier.value = [BedsideBedsideHospitalOfficeListModelData(name: "请选择科室"),...list];
    });
  }

  void bedsideBedsideHospitalRoomListAll(int officeId,{success}) {
    roomValueNotifier.value = [];
    _roomViewModel.bedsideBedsideHospitalRoomListAll(officeId,success: (list){
      roomValueNotifier.value = [BedsideBedsideHospitalRoomListModelData(name: "请选择房间"),...list];
    });
  }

}