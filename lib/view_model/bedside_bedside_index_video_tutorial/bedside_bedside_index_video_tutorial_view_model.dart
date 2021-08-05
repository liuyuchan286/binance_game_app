
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_index_video_tutorial/bedside_bedside_index_video_tutorial_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_index_video_tutorial_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideIndexVideoTutorialViewModel extends BaseViewModel{

  List<BedsideBedsideIndexVideoTutorialListModelData> bedsideBedsideIndexVideoTutorialListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideIndexVideoTutorialListDto currentBedsideBedsideIndexVideoTutorialListDto = BedsideBedsideIndexVideoTutorialListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideIndexVideoTutorialViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideIndexVideoTutorialList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideIndexVideoTutorialListModelDatas = [];
      currentBedsideBedsideIndexVideoTutorialListDto = BedsideBedsideIndexVideoTutorialListDto.fromJson(param);
    }
    this.bedsideBedsideIndexVideoTutorialList(currentBedsideBedsideIndexVideoTutorialListDto,success: (data){
      BedsideBedsideIndexVideoTutorialListModel model = BedsideBedsideIndexVideoTutorialListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideIndexVideoTutorialListModelDatas.addAll(model.list);
    });
  }


  void bedsideBedsideIndexVideoTutorialList(BedsideBedsideIndexVideoTutorialListDto bedsideBedsideIndexVideoTutorialListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideIndexVideoTutorialListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideIndexVideoTutorialListDto.toJson(),path: "/bedside/bedsideindexvideotutorial/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideIndexVideoTutorialSaveUpdate (BedsideBedsideIndexVideoTutorialListModelData data,{success}) {
    super.openLoading();
    //2s之后关闭
    Future.delayed(Duration(milliseconds: 1500), () {
      if(super.loading) {
        super.closeLoading();
      }
    });
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsideindexvideotutorial/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideIndexVideoTutorialInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsideindexvideotutorial/info/${id}").then((value){
      BedsideBedsideIndexVideoTutorialListModelData info = BedsideBedsideIndexVideoTutorialListModelData.fromJson(value["bedsideIndexVideoTutorial"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideIndexVideoTutorialDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideindexvideotutorial/delete").then((value){
      this.bedsideBedsideIndexVideoTutorialListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideIndexVideoTutorialDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideindexvideotutorial/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideIndexVideoTutorialListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideIndexVideoTutorialListModelDatas[0].replace(data);
    }else {
      this.bedsideBedsideIndexVideoTutorialListModelDatas[index].replace(data);
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideIndexVideoTutorialListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideIndexVideoTutorialListDto.toJson());
      print(this.currentBedsideBedsideIndexVideoTutorialListDto.page);
      this.initBedsideBedsideIndexVideoTutorialList();
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
    print("BedsideBedsideIndexVideoTutorialViewModel dispose ++++++++++");
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
