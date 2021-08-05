
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_order_unlock/bedside_bedside_order_unlock_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_order_unlock_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideOrderUnlockViewModel extends BaseViewModel{

  List<BedsideBedsideOrderUnlockListModelData> bedsideBedsideOrderUnlockListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideOrderUnlockListDto currentBedsideBedsideOrderUnlockListDto = BedsideBedsideOrderUnlockListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideOrderUnlockViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideOrderUnlockList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideOrderUnlockListModelDatas = [];
      currentBedsideBedsideOrderUnlockListDto = BedsideBedsideOrderUnlockListDto.fromJson(param);
    }
    this.bedsideBedsideOrderUnlockList(currentBedsideBedsideOrderUnlockListDto,success: (data){
      BedsideBedsideOrderUnlockListModel model = BedsideBedsideOrderUnlockListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideOrderUnlockListModelDatas.addAll(model.list);
    });
  }


  void bedsideBedsideOrderUnlockList(BedsideBedsideOrderUnlockListDto bedsideBedsideOrderUnlockListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideOrderUnlockListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideOrderUnlockListDto.toJson(),path: "/bedside/bedsideorderunlock/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideOrderUnlockSaveUpdate (BedsideBedsideOrderUnlockListModelData data,{success}) {
    super.openLoading();
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsideorderunlock/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideOrderUnlockInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsideorderunlock/info/${id}").then((value){
      BedsideBedsideOrderUnlockListModelData info = BedsideBedsideOrderUnlockListModelData.fromJson(value["bedsideOrderUnlock"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideOrderUnlockDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideorderunlock/delete").then((value){
      this.bedsideBedsideOrderUnlockListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideOrderUnlockDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideorderunlock/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideOrderUnlockListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideOrderUnlockListModelDatas[0].replace(data);
    }else {
      this.bedsideBedsideOrderUnlockListModelDatas[index].replace(data);
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideOrderUnlockListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideOrderUnlockListDto.toJson());
      print(this.currentBedsideBedsideOrderUnlockListDto.page);
      this.initBedsideBedsideOrderUnlockList();
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
    print("BedsideBedsideOrderUnlockViewModel dispose ++++++++++");
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
