
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_graphic_tutorial/bedside_bedside_graphic_tutorial_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_graphic_tutorial_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideGraphicTutorialViewModel extends BaseViewModel{

  List<BedsideBedsideGraphicTutorialListModelData> bedsideBedsideGraphicTutorialListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideGraphicTutorialListDto currentBedsideBedsideGraphicTutorialListDto = BedsideBedsideGraphicTutorialListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideGraphicTutorialViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideGraphicTutorialList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideGraphicTutorialListModelDatas = [];
      currentBedsideBedsideGraphicTutorialListDto = BedsideBedsideGraphicTutorialListDto.fromJson(param);
    }
    this.bedsideBedsideGraphicTutorialList(currentBedsideBedsideGraphicTutorialListDto,success: (data){
      BedsideBedsideGraphicTutorialListModel model = BedsideBedsideGraphicTutorialListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideGraphicTutorialListModelDatas.addAll(model.list);
    });
  }


  void bedsideBedsideGraphicTutorialList(BedsideBedsideGraphicTutorialListDto bedsideBedsideGraphicTutorialListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideGraphicTutorialListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideGraphicTutorialListDto.toJson(),path: "/bedside/bedsidegraphictutorial/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideGraphicTutorialSaveUpdate (BedsideBedsideGraphicTutorialListModelData data,{success}) {
    super.openLoading();
    //2s之后关闭
    Future.delayed(Duration(milliseconds: 1500), () {
      if(super.loading) {
        super.closeLoading();
      }
    });
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsidegraphictutorial/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideGraphicTutorialInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsidegraphictutorial/info/${id}").then((value){
      BedsideBedsideGraphicTutorialListModelData info = BedsideBedsideGraphicTutorialListModelData.fromJson(value["bedsideGraphicTutorial"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideGraphicTutorialDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidegraphictutorial/delete").then((value){
      this.bedsideBedsideGraphicTutorialListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideGraphicTutorialDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidegraphictutorial/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideGraphicTutorialListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideGraphicTutorialListModelDatas[0].replace(data);
    }else {
      this.bedsideBedsideGraphicTutorialListModelDatas[index].replace(data);
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideGraphicTutorialListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideGraphicTutorialListDto.toJson());
      print(this.currentBedsideBedsideGraphicTutorialListDto.page);
      this.initBedsideBedsideGraphicTutorialList();
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
    print("BedsideBedsideGraphicTutorialViewModel dispose ++++++++++");
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
