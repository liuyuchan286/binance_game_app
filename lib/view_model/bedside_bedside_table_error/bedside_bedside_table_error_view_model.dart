
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_table_error/bedside_bedside_table_error_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_table_error_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideTableErrorViewModel extends BaseViewModel{

  List<BedsideBedsideTableErrorListModelData> bedsideBedsideTableErrorListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideTableErrorListDto currentBedsideBedsideTableErrorListDto = BedsideBedsideTableErrorListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideTableErrorViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideTableErrorList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideTableErrorListModelDatas = [];
      currentBedsideBedsideTableErrorListDto = BedsideBedsideTableErrorListDto.fromJson(param);
    }
    this.bedsideBedsideTableErrorList(currentBedsideBedsideTableErrorListDto,success: (data){
      BedsideBedsideTableErrorListModel model = BedsideBedsideTableErrorListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideTableErrorListModelDatas.addAll(model.list);
    });
  }


  void bedsideBedsideTableErrorList(BedsideBedsideTableErrorListDto bedsideBedsideTableErrorListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideTableErrorListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideTableErrorListDto.toJson(),path: "/bedside/bedsidetableerror/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideTableErrorSaveUpdate (BedsideBedsideTableErrorListModelData data,{success}) {
    super.openLoading();
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsidetableerror/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideTableErrorInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsidetableerror/info/${id}").then((value){
      BedsideBedsideTableErrorListModelData info = BedsideBedsideTableErrorListModelData.fromJson(value["bedsideTableError"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideTableErrorDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidetableerror/delete").then((value){
      this.bedsideBedsideTableErrorListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideTableErrorDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidetableerror/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideTableErrorListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideTableErrorListModelDatas[0].replace(data);
    }else {
      this.bedsideBedsideTableErrorListModelDatas[index].replace(data);
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideTableErrorListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideTableErrorListDto.toJson());
      print(this.currentBedsideBedsideTableErrorListDto.page);
      this.initBedsideBedsideTableErrorList();
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
    print("BedsideBedsideTableErrorViewModel dispose ++++++++++");
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
