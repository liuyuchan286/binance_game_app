
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_agent_hospital/bedside_bedside_agent_hospital_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_agent_hospital_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideAgentHospitalViewModel extends BaseViewModel{

  List<BedsideBedsideAgentHospitalListModelData> bedsideBedsideAgentHospitalListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideAgentHospitalListDto currentBedsideBedsideAgentHospitalListDto = BedsideBedsideAgentHospitalListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideAgentHospitalViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideAgentHospitalList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideAgentHospitalListModelDatas = [];
      currentBedsideBedsideAgentHospitalListDto = BedsideBedsideAgentHospitalListDto.fromJson(param);
    }
    this.bedsideBedsideAgentHospitalList(currentBedsideBedsideAgentHospitalListDto,success: (data){
      BedsideBedsideAgentHospitalListModel model = BedsideBedsideAgentHospitalListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideAgentHospitalListModelDatas.addAll(model.list);
    });
  }


  void bedsideBedsideAgentHospitalList(BedsideBedsideAgentHospitalListDto bedsideBedsideAgentHospitalListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideAgentHospitalListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideAgentHospitalListDto.toJson(),path: "/bedside/bedsideagenthospital/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideAgentHospitalSaveUpdate (BedsideBedsideAgentHospitalListModelData data,{success,error}) {
    super.openLoading();
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsideagenthospital/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError){
      error(onError);
      super.closeLoading();
    });
  }

  void bedsideBedsideAgentHospitalInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsideagenthospital/info/${id}").then((value){
      BedsideBedsideAgentHospitalListModelData info = BedsideBedsideAgentHospitalListModelData.fromJson(value["bedsideAgentHospital"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideAgentHospitalDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideagenthospital/delete").then((value){
      this.bedsideBedsideAgentHospitalListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideAgentHospitalDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideagenthospital/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideAgentHospitalListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideAgentHospitalListModelDatas[0].replace(data);
    }else {
      this.bedsideBedsideAgentHospitalListModelDatas[index].replace(data);
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideAgentHospitalListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideAgentHospitalListDto.toJson());
      print(this.currentBedsideBedsideAgentHospitalListDto.page);
      this.initBedsideBedsideAgentHospitalList();
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
    print("BedsideBedsideAgentHospitalViewModel dispose ++++++++++");
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
