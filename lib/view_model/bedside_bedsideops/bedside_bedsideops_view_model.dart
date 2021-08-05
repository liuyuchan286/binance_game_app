
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedsideops/bedside_bedsideops_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedsideops_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideopsViewModel extends BaseViewModel{

  List<BedsideBedsideopsListModelData> bedsideBedsideopsListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideopsListDto currentBedsideBedsideopsListDto = BedsideBedsideopsListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideopsViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideopsList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideopsListModelDatas = [];
      currentBedsideBedsideopsListDto = BedsideBedsideopsListDto.fromJson(param);
    }
    this.bedsideBedsideopsList(currentBedsideBedsideopsListDto,success: (data){
      BedsideBedsideopsListModel model = BedsideBedsideopsListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideopsListModelDatas.addAll(model.list);
    });
  }


  void bedsideBedsideopsList(BedsideBedsideopsListDto bedsideBedsideopsListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideopsListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideopsListDto.toJson(),path: "/bedside/bedsideops/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideopsSaveUpdate (BedsideBedsideopsListModelData data,{success}) {
    super.openLoading();
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsideops/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }
  
  void bedsideBedsideopsInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsideops/info/${id}").then((value){
      BedsideBedsideopsListModelData info = BedsideBedsideopsListModelData.fromJson(value["bedsideOps"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideopsDelete(index,List<int> ids,{success}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideops/delete").then((value){
      this.bedsideBedsideopsListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideopsDeleteSelect(List<int> ids,{success}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideops/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError) => super.closeLoading());
  }

  void refreshList(BedsideBedsideopsListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideopsListModelDatas[0] = data;
    }else {
      data.isManageStr = this.bedsideBedsideopsListModelDatas[index].isManageStr;
      data.createdAt = this.bedsideBedsideopsListModelDatas[index].createdAt;
      this.bedsideBedsideopsListModelDatas[index] = data;
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideopsListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideopsListDto.toJson());
      print(this.currentBedsideBedsideopsListDto.page);
      this.initBedsideBedsideopsList();
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
    print("BedsideBedsideopsViewModel dispose ++++++++++");
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