
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_hospital/bedside_bedside_hospital_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideHospitalViewModel extends BaseViewModel{

  List<BedsideBedsideHospitalListModelData> bedsideBedsideHospitalListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideHospitalListDto currentBedsideBedsideHospitalListDto = BedsideBedsideHospitalListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideHospitalViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideHospitalList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideHospitalListModelDatas = [];
      currentBedsideBedsideHospitalListDto = BedsideBedsideHospitalListDto.fromJson(param);
    }
    this.bedsideBedsideHospitalList(currentBedsideBedsideHospitalListDto,success: (data){
      BedsideBedsideHospitalListModel model = BedsideBedsideHospitalListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideHospitalListModelDatas.addAll(model.list);
    });
  }


  void bedsideBedsideHospitalList(BedsideBedsideHospitalListDto bedsideBedsideHospitalListDto,{success,error}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideHospitalListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideHospitalListDto.toJson(),path: "/bedside/bedsidehospital/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideHospitalListAll({success,error}) {
    currentBedsideBedsideHospitalListDto.limit = 500;
    this.bedsideBedsideHospitalList(currentBedsideBedsideHospitalListDto,success: (data){
      BedsideBedsideHospitalListModel model = BedsideBedsideHospitalListModel.fromJson(data);
      bedsideBedsideHospitalListModelDatas = model.list;
      success(model.list);
    },error: (onError) {
      error(onError);
    });
  }

  void bedsideBedsideHospitalSaveUpdate (BedsideBedsideHospitalListModelData data,{success}) {
    super.openLoading();
    //2s之后关闭
    Future.delayed(Duration(milliseconds: 1500), () {
      if(super.loading) {
        super.closeLoading();
      }
    });
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsidehospital/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideHospitalInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsidehospital/info/${id}").then((value){
      BedsideBedsideHospitalListModelData info = BedsideBedsideHospitalListModelData.fromJson(value["bedsideHospital"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideHospitalDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidehospital/delete").then((value){
      this.bedsideBedsideHospitalListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideHospitalRefresh(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidehospital/refresh").then((value){
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideHospitalDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidehospital/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideHospitalListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideHospitalListModelDatas[0].replace(data);
    }else {
      this.bedsideBedsideHospitalListModelDatas[index].replace(data);
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideHospitalListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideHospitalListDto.toJson());
      print(this.currentBedsideBedsideHospitalListDto.page);
      this.initBedsideBedsideHospitalList();
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
    print("BedsideBedsideHospitalViewModel dispose ++++++++++");
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
