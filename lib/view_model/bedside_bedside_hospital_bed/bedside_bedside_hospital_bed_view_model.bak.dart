
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_hospital_bed/bedside_bedside_hospital_bed_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_bed_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideHospitalBedViewModel extends BaseViewModel{

  List<BedsideBedsideHospitalBedListModelData> bedsideBedsideHospitalBedListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideHospitalBedListDto currentBedsideBedsideHospitalBedListDto = BedsideBedsideHospitalBedListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideHospitalBedViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideHospitalBedList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideHospitalBedListModelDatas = [];
      currentBedsideBedsideHospitalBedListDto = BedsideBedsideHospitalBedListDto.fromJson(param);
    }
    this.bedsideBedsideHospitalBedList(currentBedsideBedsideHospitalBedListDto,success: (data){
      BedsideBedsideHospitalBedListModel model = BedsideBedsideHospitalBedListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideHospitalBedListModelDatas.addAll(model.list);
    });
  }

  void bedsideBedsideHospitalBedListAll(int roomId) {
    currentBedsideBedsideHospitalBedListDto.limit = 500;
    currentBedsideBedsideHospitalBedListDto.roomId = roomId;
    this.bedsideBedsideHospitalBedList(currentBedsideBedsideHospitalBedListDto,success: (data){
      BedsideBedsideHospitalBedListModel model = BedsideBedsideHospitalBedListModel.fromJson(data);
      bedsideBedsideHospitalBedListModelDatas = model.list;
    });
  }


  void bedsideBedsideHospitalBedList(BedsideBedsideHospitalBedListDto bedsideBedsideHospitalBedListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideHospitalBedListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideHospitalBedListDto.toJson(),path: "/bedside/bedsidehospitalbed/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideHospitalBedSaveUpdate (BedsideBedsideHospitalBedListModelData data,{success}) {
    super.openLoading();
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsidehospitalbed/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideHospitalBedInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsidehospitalbed/info/${id}").then((value){
      BedsideBedsideHospitalBedListModelData info = BedsideBedsideHospitalBedListModelData.fromJson(value["bedsideHospitalBed"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideHospitalBedDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidehospitalbed/delete").then((value){
      this.bedsideBedsideHospitalBedListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideHospitalBedDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidehospitalbed/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideHospitalBedListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideHospitalBedListModelDatas[0] = data;
    }else {
      this.bedsideBedsideHospitalBedListModelDatas[index] = data;
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideHospitalBedListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideHospitalBedListDto.toJson());
      print(this.currentBedsideBedsideHospitalBedListDto.page);
      this.initBedsideBedsideHospitalBedList();
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
    print("BedsideBedsideHospitalBedViewModel dispose ++++++++++");
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
