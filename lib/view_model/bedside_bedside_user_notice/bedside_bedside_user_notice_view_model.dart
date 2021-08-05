
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_user_notice/bedside_bedside_user_notice_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_user_notice_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideUserNoticeViewModel extends BaseViewModel{

  List<BedsideBedsideUserNoticeListModelData> bedsideBedsideUserNoticeListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideUserNoticeListDto currentBedsideBedsideUserNoticeListDto = BedsideBedsideUserNoticeListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideUserNoticeViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideUserNoticeList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideUserNoticeListModelDatas = [];
      currentBedsideBedsideUserNoticeListDto = BedsideBedsideUserNoticeListDto.fromJson(param);
    }
    this.bedsideBedsideUserNoticeList(currentBedsideBedsideUserNoticeListDto,success: (data){
      BedsideBedsideUserNoticeListModel model = BedsideBedsideUserNoticeListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideUserNoticeListModelDatas.addAll(model.list);
    });
  }


  void bedsideBedsideUserNoticeList(BedsideBedsideUserNoticeListDto bedsideBedsideUserNoticeListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideUserNoticeListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideUserNoticeListDto.toJson(),path: "/bedside/bedsideusernotice/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideUserNoticeSaveUpdate (BedsideBedsideUserNoticeListModelData data,{success}) {
    super.openLoading();
    //2s之后关闭
    Future.delayed(Duration(milliseconds: 1500), () {
      if(super.loading) {
        super.closeLoading();
      }
    });
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsideusernotice/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideUserNoticeInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsideusernotice/info/${id}").then((value){
      BedsideBedsideUserNoticeListModelData info = BedsideBedsideUserNoticeListModelData.fromJson(value["bedsideUserNotice"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideUserNoticeDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideusernotice/delete").then((value){
      this.bedsideBedsideUserNoticeListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideUserNoticeDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideusernotice/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideUserNoticeListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideUserNoticeListModelDatas[0].replace(data);
    }else {
      this.bedsideBedsideUserNoticeListModelDatas[index].replace(data);
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideUserNoticeListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideUserNoticeListDto.toJson());
      print(this.currentBedsideBedsideUserNoticeListDto.page);
      this.initBedsideBedsideUserNoticeList();
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
    print("BedsideBedsideUserNoticeViewModel dispose ++++++++++");
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
