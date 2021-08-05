
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_hospital_room/bedside_bedside_hospital_room_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_room_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideHospitalRoomViewModel extends BaseViewModel{

  List<BedsideBedsideHospitalRoomListModelData> bedsideBedsideHospitalRoomListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideHospitalRoomListDto currentBedsideBedsideHospitalRoomListDto = BedsideBedsideHospitalRoomListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideHospitalRoomViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideHospitalRoomList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideHospitalRoomListModelDatas = [];
      currentBedsideBedsideHospitalRoomListDto = BedsideBedsideHospitalRoomListDto.fromJson(param);
    }
    this.bedsideBedsideHospitalRoomList(currentBedsideBedsideHospitalRoomListDto,success: (data){
      BedsideBedsideHospitalRoomListModel model = BedsideBedsideHospitalRoomListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideHospitalRoomListModelDatas.addAll(model.list);
    });
  }

  void bedsideBedsideHospitalRoomListAll(int officeId,{success}) {
    currentBedsideBedsideHospitalRoomListDto.limit = 500;
    currentBedsideBedsideHospitalRoomListDto.officeId = officeId;
    this.bedsideBedsideHospitalRoomList(currentBedsideBedsideHospitalRoomListDto,success: (data){
      BedsideBedsideHospitalRoomListModel model = BedsideBedsideHospitalRoomListModel.fromJson(data);
      bedsideBedsideHospitalRoomListModelDatas = model.list;
      success(model.list);
    });
  }

  void bedsideBedsideHospitalRoomList(BedsideBedsideHospitalRoomListDto bedsideBedsideHospitalRoomListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideHospitalRoomListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideHospitalRoomListDto.toJson(),path: "/bedside/bedsidehospitalroom/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideHospitalRoomSaveUpdate (BedsideBedsideHospitalRoomListModelData data,{success}) {
    super.openLoading();
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsidehospitalroom/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideHospitalRoomInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsidehospitalroom/info/${id}").then((value){
      BedsideBedsideHospitalRoomListModelData info = BedsideBedsideHospitalRoomListModelData.fromJson(value["bedsideHospitalRoom"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideHospitalRoomDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidehospitalroom/delete").then((value){
      this.bedsideBedsideHospitalRoomListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideHospitalRoomDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidehospitalroom/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideHospitalRoomListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideHospitalRoomListModelDatas[0] = data;
    }else {
      this.bedsideBedsideHospitalRoomListModelDatas[index] = data;
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideHospitalRoomListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideHospitalRoomListDto.toJson());
      print(this.currentBedsideBedsideHospitalRoomListDto.page);
      this.initBedsideBedsideHospitalRoomList();
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
    print("BedsideBedsideHospitalRoomViewModel dispose ++++++++++");
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
