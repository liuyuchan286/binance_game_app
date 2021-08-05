
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_table_repairs/bedside_bedside_table_repairs_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_table_repairs_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideTableRepairsViewModel extends BaseViewModel{

  List<BedsideBedsideTableRepairsListModelData> bedsideBedsideTableRepairsListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideTableRepairsListDto currentBedsideBedsideTableRepairsListDto = BedsideBedsideTableRepairsListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideTableRepairsViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideTableRepairsList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideTableRepairsListModelDatas = [];
      currentBedsideBedsideTableRepairsListDto = BedsideBedsideTableRepairsListDto.fromJson(param);
    }
    this.bedsideBedsideTableRepairsList(currentBedsideBedsideTableRepairsListDto,success: (data){
      BedsideBedsideTableRepairsListModel model = BedsideBedsideTableRepairsListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideTableRepairsListModelDatas.addAll(model.list);
    });
  }


  void bedsideBedsideTableRepairsList(BedsideBedsideTableRepairsListDto bedsideBedsideTableRepairsListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideTableRepairsListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideTableRepairsListDto.toJson(),path: "/bedside/bedsidetablerepairs/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideTableRepairsSaveUpdate (BedsideBedsideTableRepairsListModelData data,{success}) {
    super.openLoading();
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsidetablerepairs/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideTableRepairsAssign (BedsideBedsideTableRepairsListModelData data,{success}) {
    super.openLoading();
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsidetablerepairs/assign").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideTableRepairsInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsidetablerepairs/info/${id}").then((value){
      BedsideBedsideTableRepairsListModelData info = BedsideBedsideTableRepairsListModelData.fromJson(value["bedsideTableRepairs"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideTableRepairsDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidetablerepairs/delete").then((value){
      this.bedsideBedsideTableRepairsListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideTableRepairsDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidetablerepairs/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideTableRepairsListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideTableRepairsListModelDatas[0].replace(data);
    }else {
      this.bedsideBedsideTableRepairsListModelDatas[index].replace(data);
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideTableRepairsListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideTableRepairsListDto.toJson());
      print(this.currentBedsideBedsideTableRepairsListDto.page);
      this.initBedsideBedsideTableRepairsList();
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
    print("BedsideBedsideTableRepairsViewModel dispose ++++++++++");
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
