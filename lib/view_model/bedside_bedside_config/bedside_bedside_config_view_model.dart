
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_config/bedside_bedside_config_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_config_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideConfigViewModel extends BaseViewModel{

  List<BedsideBedsideConfigListModelData> bedsideBedsideConfigListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideConfigListDto currentBedsideBedsideConfigListDto = BedsideBedsideConfigListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideConfigViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideConfigList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideConfigListModelDatas = [];
      currentBedsideBedsideConfigListDto = BedsideBedsideConfigListDto.fromJson(param);
    }
    this.bedsideBedsideConfigList(currentBedsideBedsideConfigListDto,success: (data){
      BedsideBedsideConfigListModel model = BedsideBedsideConfigListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideConfigListModelDatas.addAll(model.list);
    });
  }


  void bedsideBedsideConfigList(BedsideBedsideConfigListDto bedsideBedsideConfigListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideConfigListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideConfigListDto.toJson(),path: "/bedside/bedsideconfig/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideConfigSaveUpdate (BedsideBedsideConfigListModelData data,{success}) {
    super.openLoading();
    //2s之后关闭
    Future.delayed(Duration(milliseconds: 1500), () {
      if(super.loading) {
        super.closeLoading();
      }
    });
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsideconfig/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideConfigInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsideconfig/info/${id}").then((value){
      BedsideBedsideConfigListModelData info = BedsideBedsideConfigListModelData.fromJson(value["bedsideConfig"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideConfigDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideconfig/delete").then((value){
      this.bedsideBedsideConfigListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideConfigRefresh(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideconfig/refresh").then((value){
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideConfigDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideconfig/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideConfigListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideConfigListModelDatas[0].replace(data);
    }else {
      this.bedsideBedsideConfigListModelDatas[index].replace(data);
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideConfigListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideConfigListDto.toJson());
      print(this.currentBedsideBedsideConfigListDto.page);
      this.initBedsideBedsideConfigList();
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
    print("BedsideBedsideConfigViewModel dispose ++++++++++");
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
