
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_order/bedside_bedside_order_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_order_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideOrderViewModel extends BaseViewModel{

  List<BedsideBedsideOrderListModelData> bedsideBedsideOrderListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideOrderListDto currentBedsideBedsideOrderListDto = BedsideBedsideOrderListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideOrderViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideOrderList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideOrderListModelDatas = [];
      currentBedsideBedsideOrderListDto = BedsideBedsideOrderListDto.fromJson(param);
    }
    this.bedsideBedsideOrderList(currentBedsideBedsideOrderListDto,success: (data){
      BedsideBedsideOrderListModel model = BedsideBedsideOrderListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideOrderListModelDatas.addAll(model.list);
    });
  }


  void bedsideBedsideOrderList(BedsideBedsideOrderListDto bedsideBedsideOrderListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideOrderListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideOrderListDto.toJson(),path: "/bedside/bedsideorder/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideOrderSaveUpdate (BedsideBedsideOrderListModelData data,{success}) {
    super.openLoading();
    //2s之后关闭
    Future.delayed(Duration(milliseconds: 1500), () {
      if(super.loading) {
        super.closeLoading();
      }
    });
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsideorder/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideOrderInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsideorder/info/${id}").then((value){
      BedsideBedsideOrderListModelData info = BedsideBedsideOrderListModelData.fromJson(value["bedsideOrder"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideOrderDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideorder/delete").then((value){
      this.bedsideBedsideOrderListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideOrderRefund(index,int id,{success,error}) {
    super.openLoading();
    Http.getInstance().post({"id":id},path: "/bedside/bedsideorder/refund").then((value){
      this.bedsideBedsideOrderListModelDatas[index].statusStr = "已退款";
      refreshList(this.bedsideBedsideOrderListModelDatas[index], index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideOrderDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideorder/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideOrderListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideOrderListModelDatas[0].replace(data);
    }else {
      this.bedsideBedsideOrderListModelDatas[index].replace(data);
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideOrderListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideOrderListDto.toJson());
      print(this.currentBedsideBedsideOrderListDto.page);
      this.initBedsideBedsideOrderList();
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
    print("BedsideBedsideOrderViewModel dispose ++++++++++");
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
