
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_user_hospital_deposit_refund_order/bedside_bedside_user_hospital_deposit_refund_order_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_user_hospital_deposit_refund_order_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideUserHospitalDepositRefundOrderViewModel extends BaseViewModel{

  List<BedsideBedsideUserHospitalDepositRefundOrderListModelData> bedsideBedsideUserHospitalDepositRefundOrderListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideUserHospitalDepositRefundOrderListDto currentBedsideBedsideUserHospitalDepositRefundOrderListDto = BedsideBedsideUserHospitalDepositRefundOrderListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideUserHospitalDepositRefundOrderViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideUserHospitalDepositRefundOrderList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideUserHospitalDepositRefundOrderListModelDatas = [];
      currentBedsideBedsideUserHospitalDepositRefundOrderListDto = BedsideBedsideUserHospitalDepositRefundOrderListDto.fromJson(param);
    }
    this.bedsideBedsideUserHospitalDepositRefundOrderList(currentBedsideBedsideUserHospitalDepositRefundOrderListDto,success: (data){
      BedsideBedsideUserHospitalDepositRefundOrderListModel model = BedsideBedsideUserHospitalDepositRefundOrderListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideUserHospitalDepositRefundOrderListModelDatas.addAll(model.list);
    });
  }


  void bedsideBedsideUserHospitalDepositRefundOrderList(BedsideBedsideUserHospitalDepositRefundOrderListDto bedsideBedsideUserHospitalDepositRefundOrderListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideUserHospitalDepositRefundOrderListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideUserHospitalDepositRefundOrderListDto.toJson(),path: "/bedside/bedsideuserhospitaldepositrefundorder/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideUserHospitalDepositRefundOrderSaveUpdate (BedsideBedsideUserHospitalDepositRefundOrderListModelData data,{success}) {
    super.openLoading();
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsideuserhospitaldepositrefundorder/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideUserHospitalDepositRefundOrderInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsideuserhospitaldepositrefundorder/info/${id}").then((value){
      BedsideBedsideUserHospitalDepositRefundOrderListModelData info = BedsideBedsideUserHospitalDepositRefundOrderListModelData.fromJson(value["bedsideUserHospitalDepositRefundOrder"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideUserHospitalDepositRefundOrderDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideuserhospitaldepositrefundorder/delete").then((value){
      this.bedsideBedsideUserHospitalDepositRefundOrderListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideUserHospitalDepositRefundOrderDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideuserhospitaldepositrefundorder/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideUserHospitalDepositRefundOrderListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideUserHospitalDepositRefundOrderListModelDatas[0].replace(data);
    }else {
      this.bedsideBedsideUserHospitalDepositRefundOrderListModelDatas[index].replace(data);
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideUserHospitalDepositRefundOrderListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideUserHospitalDepositRefundOrderListDto.toJson());
      print(this.currentBedsideBedsideUserHospitalDepositRefundOrderListDto.page);
      this.initBedsideBedsideUserHospitalDepositRefundOrderList();
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
    print("BedsideBedsideUserHospitalDepositRefundOrderViewModel dispose ++++++++++");
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
