
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_hospital_usetime/bedside_bedside_hospital_usetime_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_usetime_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideHospitalUsetimeViewModel extends BaseViewModel{

  List<BedsideBedsideHospitalUsetimeListModelData> bedsideBedsideHospitalUsetimeListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideHospitalUsetimeListDto currentBedsideBedsideHospitalUsetimeListDto = BedsideBedsideHospitalUsetimeListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideHospitalUsetimeViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideHospitalUsetimeList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideHospitalUsetimeListModelDatas = [];
      currentBedsideBedsideHospitalUsetimeListDto = BedsideBedsideHospitalUsetimeListDto.fromJson(param);
    }
    this.bedsideBedsideHospitalUsetimeList(currentBedsideBedsideHospitalUsetimeListDto,success: (data){
      BedsideBedsideHospitalUsetimeListModel model = BedsideBedsideHospitalUsetimeListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideHospitalUsetimeListModelDatas.addAll(model.list);
    });
  }


  void bedsideBedsideHospitalUsetimeList(BedsideBedsideHospitalUsetimeListDto bedsideBedsideHospitalUsetimeListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideHospitalUsetimeListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideHospitalUsetimeListDto.toJson(),path: "/bedside/bedsidehospitalusetime/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideHospitalUsetimeSaveUpdate (BedsideBedsideHospitalUsetimeListModelData data,{success}) {
    super.openLoading();
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsidehospitalusetime/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideHospitalUsetimeInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsidehospitalusetime/info/${id}").then((value){
      BedsideBedsideHospitalUsetimeListModelData info = BedsideBedsideHospitalUsetimeListModelData.fromJson(value["bedsideHospitalUsetime"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideHospitalUsetimeDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidehospitalusetime/delete").then((value){
      this.bedsideBedsideHospitalUsetimeListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideHospitalUsetimeDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidehospitalusetime/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideHospitalUsetimeListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideHospitalUsetimeListModelDatas[0].replace(data);
    }else {
      this.bedsideBedsideHospitalUsetimeListModelDatas[index].replace(data);
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideHospitalUsetimeListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideHospitalUsetimeListDto.toJson());
      print(this.currentBedsideBedsideHospitalUsetimeListDto.page);
      this.initBedsideBedsideHospitalUsetimeList();
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
    print("BedsideBedsideHospitalUsetimeViewModel dispose ++++++++++");
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
