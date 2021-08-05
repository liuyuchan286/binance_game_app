
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_problem/bedside_bedside_problem_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_problem_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideProblemViewModel extends BaseViewModel{

  List<BedsideBedsideProblemListModelData> bedsideBedsideProblemListModelDatas = [];

  List<int> ids = [];

  BedsideBedsideProblemListDto currentBedsideBedsideProblemListDto = BedsideBedsideProblemListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideProblemViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideProblemList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideProblemListModelDatas = [];
      currentBedsideBedsideProblemListDto = BedsideBedsideProblemListDto.fromJson(param);
    }
    this.bedsideBedsideProblemList(currentBedsideBedsideProblemListDto,success: (data){
      BedsideBedsideProblemListModel model = BedsideBedsideProblemListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideProblemListModelDatas.addAll(model.list);
    });
  }


  void bedsideBedsideProblemList(BedsideBedsideProblemListDto bedsideBedsideProblemListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideProblemListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideProblemListDto.toJson(),path: "/bedside/bedsideproblem/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideProblemSaveUpdate (BedsideBedsideProblemListModelData data,{success}) {
    super.openLoading();
    //2s之后关闭
    Future.delayed(Duration(milliseconds: 1500), () {
      if(super.loading) {
        super.closeLoading();
      }
    });
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsideproblem/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideProblemInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsideproblem/info/${id}").then((value){
      BedsideBedsideProblemListModelData info = BedsideBedsideProblemListModelData.fromJson(value["bedsideProblem"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideProblemDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideproblem/delete").then((value){
      this.bedsideBedsideProblemListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideProblemDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideproblem/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideProblemListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideProblemListModelDatas[0].replace(data);
    }else {
      this.bedsideBedsideProblemListModelDatas[index].replace(data);
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideProblemListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideProblemListDto.toJson());
      print(this.currentBedsideBedsideProblemListDto.page);
      this.initBedsideBedsideProblemList();
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
    print("BedsideBedsideProblemViewModel dispose ++++++++++");
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
