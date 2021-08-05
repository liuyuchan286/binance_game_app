
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_daily_statistics/bedside_bedside_daily_statistics_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_daily_statistics_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideDailyStatisticsViewModel extends BaseViewModel{

  List<BedsideBedsideDailyStatisticsListModelData> bedsideBedsideDailyStatisticsListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideDailyStatisticsListDto currentBedsideBedsideDailyStatisticsListDto = BedsideBedsideDailyStatisticsListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideDailyStatisticsViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideDailyStatisticsList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideDailyStatisticsListModelDatas = [];
      currentBedsideBedsideDailyStatisticsListDto = BedsideBedsideDailyStatisticsListDto.fromJson(param);
    }
    this.bedsideBedsideDailyStatisticsList(currentBedsideBedsideDailyStatisticsListDto,success: (data){
      BedsideBedsideDailyStatisticsListModel model = BedsideBedsideDailyStatisticsListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideDailyStatisticsListModelDatas.addAll(model.list);
    });
  }


  void bedsideBedsideDailyStatisticsList(BedsideBedsideDailyStatisticsListDto bedsideBedsideDailyStatisticsListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideDailyStatisticsListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideDailyStatisticsListDto.toJson(),path: "/bedside/bedsidedailystatistics/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideDailyStatisticsSaveUpdate (BedsideBedsideDailyStatisticsListModelData data,{success}) {
    super.openLoading();
    //2s之后关闭
    Future.delayed(Duration(milliseconds: 1500), () {
      if(super.loading) {
        super.closeLoading();
      }
    });
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsidedailystatistics/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideDailyStatisticsInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsidedailystatistics/info/${id}").then((value){
      BedsideBedsideDailyStatisticsListModelData info = BedsideBedsideDailyStatisticsListModelData.fromJson(value["bedsideDailyStatistics"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideDailyStatisticsDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidedailystatistics/delete").then((value){
      this.bedsideBedsideDailyStatisticsListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideDailyStatisticsDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidedailystatistics/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideDailyStatisticsListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideDailyStatisticsListModelDatas[0].replace(data);
    }else {
      this.bedsideBedsideDailyStatisticsListModelDatas[index].replace(data);
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideDailyStatisticsListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideDailyStatisticsListDto.toJson());
      print(this.currentBedsideBedsideDailyStatisticsListDto.page);
      this.initBedsideBedsideDailyStatisticsList();
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
    print("BedsideBedsideDailyStatisticsViewModel dispose ++++++++++");
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
