
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_hospital_office/bedside_bedside_hospital_office_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_office_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideHospitalOfficeViewModel extends BaseViewModel{

  List<BedsideBedsideHospitalOfficeListModelData> bedsideBedsideHospitalOfficeListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideHospitalOfficeListDto currentBedsideBedsideHospitalOfficeListDto = BedsideBedsideHospitalOfficeListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideHospitalOfficeViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideHospitalOfficeList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideHospitalOfficeListModelDatas = [];
      currentBedsideBedsideHospitalOfficeListDto = BedsideBedsideHospitalOfficeListDto.fromJson(param);
    }
    this.bedsideBedsideHospitalOfficeList(currentBedsideBedsideHospitalOfficeListDto,success: (data){
      BedsideBedsideHospitalOfficeListModel model = BedsideBedsideHospitalOfficeListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideHospitalOfficeListModelDatas.addAll(model.list);
    });
  }

  void bedsideBedsideHospitalOfficeListAll(int hospitalId,{success}) {
    currentBedsideBedsideHospitalOfficeListDto.limit = 500;
    currentBedsideBedsideHospitalOfficeListDto.hospitalId = hospitalId;
    this.bedsideBedsideHospitalOfficeList(currentBedsideBedsideHospitalOfficeListDto,success: (data){
      BedsideBedsideHospitalOfficeListModel model = BedsideBedsideHospitalOfficeListModel.fromJson(data);
      bedsideBedsideHospitalOfficeListModelDatas = model.list;
      print(bedsideBedsideHospitalOfficeListModelDatas);
      success(model.list);
    });
  }


  void bedsideBedsideHospitalOfficeList(BedsideBedsideHospitalOfficeListDto bedsideBedsideHospitalOfficeListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideHospitalOfficeListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideHospitalOfficeListDto.toJson(),path: "/bedside/bedsidehospitaloffice/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideHospitalOfficeSaveUpdate (BedsideBedsideHospitalOfficeListModelData data,{success}) {
    super.openLoading();
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsidehospitaloffice/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideHospitalOfficeInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsidehospitaloffice/info/${id}").then((value){
      BedsideBedsideHospitalOfficeListModelData info = BedsideBedsideHospitalOfficeListModelData.fromJson(value["bedsideHospitalOffice"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideHospitalOfficeDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidehospitaloffice/delete").then((value){
      this.bedsideBedsideHospitalOfficeListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideHospitalOfficeDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidehospitaloffice/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideHospitalOfficeListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideHospitalOfficeListModelDatas[0] = data;
    }else {
      this.bedsideBedsideHospitalOfficeListModelDatas[index] = data;
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideHospitalOfficeListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideHospitalOfficeListDto.toJson());
      print(this.currentBedsideBedsideHospitalOfficeListDto.page);
      this.initBedsideBedsideHospitalOfficeList();
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
    print("BedsideBedsideHospitalOfficeViewModel dispose ++++++++++");
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
