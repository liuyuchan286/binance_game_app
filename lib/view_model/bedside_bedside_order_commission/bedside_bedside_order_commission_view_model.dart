
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_order_commission/bedside_bedside_order_commission_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_order_commission_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideOrderCommissionViewModel extends BaseViewModel{

  List<BedsideBedsideOrderCommissionListModelData> bedsideBedsideOrderCommissionListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideOrderCommissionListDto currentBedsideBedsideOrderCommissionListDto = BedsideBedsideOrderCommissionListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideOrderCommissionViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideOrderCommissionList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideOrderCommissionListModelDatas = [];
      currentBedsideBedsideOrderCommissionListDto = BedsideBedsideOrderCommissionListDto.fromJson(param);
    }
    this.bedsideBedsideOrderCommissionList(currentBedsideBedsideOrderCommissionListDto,success: (data){
      BedsideBedsideOrderCommissionListModel model = BedsideBedsideOrderCommissionListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideOrderCommissionListModelDatas.addAll(model.list);
    });
  }


  void bedsideBedsideOrderCommissionList(BedsideBedsideOrderCommissionListDto bedsideBedsideOrderCommissionListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideOrderCommissionListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideOrderCommissionListDto.toJson(),path: "/bedside/bedsideordercommission/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideOrderCommissionSaveUpdate (BedsideBedsideOrderCommissionListModelData data,{success}) {
    super.openLoading();
    //2s之后关闭
    Future.delayed(Duration(milliseconds: 1500), () {
      if(super.loading) {
        super.closeLoading();
      }
    });
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsideordercommission/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideOrderCommissionInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsideordercommission/info/${id}").then((value){
      BedsideBedsideOrderCommissionListModelData info = BedsideBedsideOrderCommissionListModelData.fromJson(value["bedsideOrderCommission"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideOrderCommissionDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideordercommission/delete").then((value){
      this.bedsideBedsideOrderCommissionListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideOrderCommissionDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideordercommission/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideOrderCommissionListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideOrderCommissionListModelDatas[0].replace(data);
    }else {
      this.bedsideBedsideOrderCommissionListModelDatas[index].replace(data);
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideOrderCommissionListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideOrderCommissionListDto.toJson());
      print(this.currentBedsideBedsideOrderCommissionListDto.page);
      this.initBedsideBedsideOrderCommissionList();
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
    print("BedsideBedsideOrderCommissionViewModel dispose ++++++++++");
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
