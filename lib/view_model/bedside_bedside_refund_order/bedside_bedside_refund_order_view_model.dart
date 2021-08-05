
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_refund_order/bedside_bedside_refund_order_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_refund_order_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideRefundOrderViewModel extends BaseViewModel{

  List<BedsideBedsideRefundOrderListModelData> bedsideBedsideRefundOrderListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideRefundOrderListDto currentBedsideBedsideRefundOrderListDto = BedsideBedsideRefundOrderListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideRefundOrderViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideRefundOrderList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideRefundOrderListModelDatas = [];
      currentBedsideBedsideRefundOrderListDto = BedsideBedsideRefundOrderListDto.fromJson(param);
    }
    this.bedsideBedsideRefundOrderList(currentBedsideBedsideRefundOrderListDto,success: (data){
      BedsideBedsideRefundOrderListModel model = BedsideBedsideRefundOrderListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideRefundOrderListModelDatas.addAll(model.list);
    });
  }


  void bedsideBedsideRefundOrderList(BedsideBedsideRefundOrderListDto bedsideBedsideRefundOrderListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideRefundOrderListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideRefundOrderListDto.toJson(),path: "/bedside/bedsiderefundorder/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideRefundOrderSaveUpdate (BedsideBedsideRefundOrderListModelData data,{success}) {
    super.openLoading();
    //2s之后关闭
    Future.delayed(Duration(milliseconds: 1500), () {
      if(super.loading) {
        super.closeLoading();
      }
    });
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsiderefundorder/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideRefundOrderInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsiderefundorder/info/${id}").then((value){
      BedsideBedsideRefundOrderListModelData info = BedsideBedsideRefundOrderListModelData.fromJson(value["bedsideRefundOrder"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideRefundOrderDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsiderefundorder/delete").then((value){
      this.bedsideBedsideRefundOrderListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideRefundOrderDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsiderefundorder/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideRefundOrderListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideRefundOrderListModelDatas[0].replace(data);
    }else {
      this.bedsideBedsideRefundOrderListModelDatas[index].replace(data);
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideRefundOrderListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideRefundOrderListDto.toJson());
      print(this.currentBedsideBedsideRefundOrderListDto.page);
      this.initBedsideBedsideRefundOrderList();
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
    print("BedsideBedsideRefundOrderViewModel dispose ++++++++++");
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
