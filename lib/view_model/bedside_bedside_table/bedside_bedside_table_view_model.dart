
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_table/bedside_bedside_table_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_table_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideTableViewModel extends BaseViewModel{

  List<BedsideBedsideTableListModelData> bedsideBedsideTableListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideTableListDto currentBedsideBedsideTableListDto = BedsideBedsideTableListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideTableViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideTableList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideTableListModelDatas = [];
      currentBedsideBedsideTableListDto = BedsideBedsideTableListDto.fromJson(param);
    }
    this.bedsideBedsideTableList(currentBedsideBedsideTableListDto,success: (data){
      BedsideBedsideTableListModel model = BedsideBedsideTableListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideTableListModelDatas.addAll(model.list);
    });
  }


  void bedsideBedsideTableList(BedsideBedsideTableListDto bedsideBedsideTableListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideTableListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideTableListDto.toJson(),path: "/bedside/bedsidetable/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideTableSaveUpdate (BedsideBedsideTableListModelData data,{success,error}) {
    super.openLoading();
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsidetable/${data.id == null ? 'save' : 'update'}").then((value) {
      super.closeLoading();
      success(value);
    }).catchError((onError){
      error(onError);
      super.closeLoading();
    });
  }

  void bedsideBedsideTableInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsidetable/info/${id}").then((value){
      BedsideBedsideTableListModelData info = BedsideBedsideTableListModelData.fromJson(value["bedsideTable"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideTableDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidetable/delete").then((value){
      this.bedsideBedsideTableListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideTableDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidetable/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideTableCalibration(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidetable/calibration").then((value){
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideTableOpenLock(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post({'ids':ids},path: "/bedside/bedsidetable/openLock").then((value){
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideTableToAep(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post({'ids':ids},path: "/bedside/bedsidetable/toAep").then((value){
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideTableToXYLock(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post({'ids':ids},path: "/bedside/bedsidetable/toXYLock").then((value){
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }


  void bedsideBedsideTableReset(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidetable/reset").then((value){
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideTableForceReset(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidetable/forceReset").then((value){
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideTableListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideTableListModelDatas[0].replace(data);
    }else {
      this.bedsideBedsideTableListModelDatas[index].replace(data);
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideTableListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideTableListDto.toJson());
      print(this.currentBedsideBedsideTableListDto.page);
      this.initBedsideBedsideTableList();
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
    print("BedsideBedsideTableViewModel dispose ++++++++++");
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
