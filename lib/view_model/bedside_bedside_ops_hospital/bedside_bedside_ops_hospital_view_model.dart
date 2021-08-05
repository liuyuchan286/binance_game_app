
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_ops_hospital/bedside_bedside_ops_hospital_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_ops_hospital_list_model.dart';
import 'package:binance_game_app/model/bedside_bedside_ops_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideOpsHospitalViewModel extends BaseViewModel{

  List<BedsideBedsideOpsHospitalListModelData> bedsideBedsideOpsHospitalListModelDatas = [];

  List<BedsideBedsideOpsListModelData> bedsideBedsideOpsListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideOpsHospitalListDto currentBedsideBedsideOpsHospitalListDto = BedsideBedsideOpsHospitalListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideOpsHospitalViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideOpsHospitalList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideOpsHospitalListModelDatas = [];
      currentBedsideBedsideOpsHospitalListDto = BedsideBedsideOpsHospitalListDto.fromJson(param);
    }
    this.bedsideBedsideOpsHospitalList(currentBedsideBedsideOpsHospitalListDto,success: (data){
      BedsideBedsideOpsHospitalListModel model = BedsideBedsideOpsHospitalListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideOpsHospitalListModelDatas.addAll(model.list);
    });
  }

  void bedsideBedsideopshospitalListOpsByTableId(int tableId) {
    super.openLoading();
    Map<String,int> queryParameters = {
      "tableId": tableId
    };
    Http.getInstance().get(queryParameters,path: "/bedside/bedsideopshospital/listOpsByTableId").then((value){
      bedsideBedsideOpsListModelDatas = (value.data as List).map((e) => BedsideBedsideOpsListModelData.fromJson(e)).toList();
      super.closeLoading();
    }).catchError((onError){

      super.closeLoading();
    });
  }


  void bedsideBedsideOpsHospitalList(BedsideBedsideOpsHospitalListDto bedsideBedsideOpsHospitalListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideOpsHospitalListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideOpsHospitalListDto.toJson(),path: "/bedside/bedsideopshospital/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideOpsHospitalSaveUpdate (BedsideBedsideOpsHospitalListModelData data,{success}) {
    super.openLoading();
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsideopshospital/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideOpsHospitalInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsideopshospital/info/${id}").then((value){
      BedsideBedsideOpsHospitalListModelData info = BedsideBedsideOpsHospitalListModelData.fromJson(value["bedsideOpsHospital"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideOpsHospitalDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideopshospital/delete").then((value){
      this.bedsideBedsideOpsHospitalListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideOpsHospitalDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideopshospital/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideOpsHospitalListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideOpsHospitalListModelDatas[0].replace(data);
    }else {
      this.bedsideBedsideOpsHospitalListModelDatas[index].replace(data);
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideOpsHospitalListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideOpsHospitalListDto.toJson());
      print(this.currentBedsideBedsideOpsHospitalListDto.page);
      this.initBedsideBedsideOpsHospitalList();
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
    print("BedsideBedsideOpsHospitalViewModel dispose ++++++++++");
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
