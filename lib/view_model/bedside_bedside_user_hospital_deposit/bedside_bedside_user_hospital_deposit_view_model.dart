
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_user_hospital_deposit/bedside_bedside_user_hospital_deposit_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_user_hospital_deposit_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideUserHospitalDepositViewModel extends BaseViewModel{

  List<BedsideBedsideUserHospitalDepositListModelData> bedsideBedsideUserHospitalDepositListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideUserHospitalDepositListDto currentBedsideBedsideUserHospitalDepositListDto = BedsideBedsideUserHospitalDepositListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideUserHospitalDepositViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideUserHospitalDepositList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideUserHospitalDepositListModelDatas = [];
      currentBedsideBedsideUserHospitalDepositListDto = BedsideBedsideUserHospitalDepositListDto.fromJson(param);
    }
    this.bedsideBedsideUserHospitalDepositList(currentBedsideBedsideUserHospitalDepositListDto,success: (data){
      BedsideBedsideUserHospitalDepositListModel model = BedsideBedsideUserHospitalDepositListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideUserHospitalDepositListModelDatas.addAll(model.list);
    });
  }


  void bedsideBedsideUserHospitalDepositList(BedsideBedsideUserHospitalDepositListDto bedsideBedsideUserHospitalDepositListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideUserHospitalDepositListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideUserHospitalDepositListDto.toJson(),path: "/bedside/bedsideuserhospitaldeposit/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideUserHospitalDepositSaveUpdate (BedsideBedsideUserHospitalDepositListModelData data,{success}) {
    super.openLoading();
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsideuserhospitaldeposit/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideUserHospitalDepositInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsideuserhospitaldeposit/info/${id}").then((value){
      BedsideBedsideUserHospitalDepositListModelData info = BedsideBedsideUserHospitalDepositListModelData.fromJson(value["bedsideUserHospitalDeposit"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideUserHospitalDepositDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideuserhospitaldeposit/delete").then((value){
      this.bedsideBedsideUserHospitalDepositListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideuserhospitaldepositRefund(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideuserhospitaldeposit/refund").then((value){
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideUserHospitalDepositDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideuserhospitaldeposit/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideUserHospitalDepositListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideUserHospitalDepositListModelDatas[0].replace(data);
    }else {
      this.bedsideBedsideUserHospitalDepositListModelDatas[index].replace(data);
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideUserHospitalDepositListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideUserHospitalDepositListDto.toJson());
      print(this.currentBedsideBedsideUserHospitalDepositListDto.page);
      this.initBedsideBedsideUserHospitalDepositList();
    }
  }

  void defaultData() {
    this._currPage = 0;
    this._totalPage = -1;
    this._totalCount = -1;
  }

  //销毁
  @override
  void dispose() {
    print("BedsideBedsideUserHospitalDepositViewModel dispose ++++++++++");
    if (this.hasListeners) {
      scrollController.removeListener(_scrollListener);
      scrollController.dispose();
      super.dispose();
    }
  }

  int get totalCount => _totalCount;

  int get totalPage => _totalPage;

  int get currPage => _currPage;
}
