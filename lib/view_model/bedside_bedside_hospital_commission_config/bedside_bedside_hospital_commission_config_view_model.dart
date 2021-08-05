
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_hospital_commission_config/bedside_bedside_hospital_commission_config_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_commission_config_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideHospitalCommissionConfigViewModel extends BaseViewModel{

  List<BedsideBedsideHospitalCommissionConfigListModelData> bedsideBedsideHospitalCommissionConfigListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideHospitalCommissionConfigListDto currentBedsideBedsideHospitalCommissionConfigListDto = BedsideBedsideHospitalCommissionConfigListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideHospitalCommissionConfigViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideHospitalCommissionConfigList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideHospitalCommissionConfigListModelDatas = [];
      currentBedsideBedsideHospitalCommissionConfigListDto = BedsideBedsideHospitalCommissionConfigListDto.fromJson(param);
    }
    this.bedsideBedsideHospitalCommissionConfigList(currentBedsideBedsideHospitalCommissionConfigListDto,success: (data){
      BedsideBedsideHospitalCommissionConfigListModel model = BedsideBedsideHospitalCommissionConfigListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideHospitalCommissionConfigListModelDatas.addAll(model.list);
    });
  }


  void bedsideBedsideHospitalCommissionConfigList(BedsideBedsideHospitalCommissionConfigListDto bedsideBedsideHospitalCommissionConfigListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideHospitalCommissionConfigListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideHospitalCommissionConfigListDto.toJson(),path: "/bedside/bedsidehospitalcommissionconfig/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideHospitalCommissionConfigSaveUpdate (BedsideBedsideHospitalCommissionConfigListModelData data,{success}) {
    super.openLoading();
    //2s之后关闭
    Future.delayed(Duration(milliseconds: 1500), () {
      if(super.loading) {
        super.closeLoading();
      }
    });
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsidehospitalcommissionconfig/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideHospitalCommissionConfigInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsidehospitalcommissionconfig/info/${id}").then((value){
      BedsideBedsideHospitalCommissionConfigListModelData info = BedsideBedsideHospitalCommissionConfigListModelData.fromJson(value["bedsideHospitalCommissionConfig"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideHospitalCommissionConfigDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidehospitalcommissionconfig/delete").then((value){
      this.bedsideBedsideHospitalCommissionConfigListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideHospitalCommissionConfigDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidehospitalcommissionconfig/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideHospitalCommissionConfigListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideHospitalCommissionConfigListModelDatas[0].replace(data);
    }else {
      this.bedsideBedsideHospitalCommissionConfigListModelDatas[index].replace(data);
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideHospitalCommissionConfigListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideHospitalCommissionConfigListDto.toJson());
      print(this.currentBedsideBedsideHospitalCommissionConfigListDto.page);
      this.initBedsideBedsideHospitalCommissionConfigList();
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
    print("BedsideBedsideHospitalCommissionConfigViewModel dispose ++++++++++");
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
