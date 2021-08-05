
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_user/bedside_bedside_user_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_user_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideUserViewModel extends BaseViewModel{

  List<BedsideBedsideUserListModelData> bedsideBedsideUserListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideUserListDto currentBedsideBedsideUserListDto = BedsideBedsideUserListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideUserViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideUserList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideUserListModelDatas = [];
      currentBedsideBedsideUserListDto = BedsideBedsideUserListDto.fromJson(param);
    }
    this.bedsideBedsideUserList(currentBedsideBedsideUserListDto,success: (data){
      BedsideBedsideUserListModel model = BedsideBedsideUserListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideUserListModelDatas.addAll(model.list);
    });
  }


  void bedsideBedsideUserList(BedsideBedsideUserListDto bedsideBedsideUserListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideUserListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideUserListDto.toJson(),path: "/bedside/bedsideuser/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideUserSaveUpdate (BedsideBedsideUserListModelData data,{success}) {
    super.openLoading();
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsideuser/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideUserInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsideuser/info/${id}").then((value){
      BedsideBedsideUserListModelData info = BedsideBedsideUserListModelData.fromJson(value["bedsideUser"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideUserDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideuser/delete").then((value){
      this.bedsideBedsideUserListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideUserDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideuser/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideUserListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideUserListModelDatas[0].replace(data);
    }else {
      this.bedsideBedsideUserListModelDatas[index].replace(data);
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideUserListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideUserListDto.toJson());
      print(this.currentBedsideBedsideUserListDto.page);
      this.initBedsideBedsideUserList();
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
    print("BedsideBedsideUserViewModel dispose ++++++++++");
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
