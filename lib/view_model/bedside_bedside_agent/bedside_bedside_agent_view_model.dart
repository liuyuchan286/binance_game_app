
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_agent/bedside_bedside_agent_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_agent_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideAgentViewModel extends BaseViewModel{

  List<BedsideBedsideAgentListModelData> bedsideBedsideAgentListModelDatas = [];

  List<int> ids = [];

  List<int> hospitalIds = [];

  BedsideBedsideAgentListDto currentBedsideBedsideAgentListDto = BedsideBedsideAgentListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideAgentViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideAgentList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideAgentListModelDatas = [];
      currentBedsideBedsideAgentListDto = BedsideBedsideAgentListDto.fromJson(param);
    }
    this.bedsideBedsideAgentList(currentBedsideBedsideAgentListDto,success: (data){
      BedsideBedsideAgentListModel model = BedsideBedsideAgentListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideAgentListModelDatas.addAll(model.list);
    });
  }


  void bedsideBedsideAgentList(BedsideBedsideAgentListDto bedsideBedsideAgentListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideAgentListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideAgentListDto.toJson(),path: "/bedside/bedsideagent/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideAgentSaveUpdate (BedsideBedsideAgentListModelData data,{success}) {
    //2s之后关闭
    Future.delayed(Duration(milliseconds: 1500), () {
      if(super.loading) {
        super.closeLoading();
      }
    });
    super.openLoading();
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsideagent/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideAgentInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsideagent/info/${id}").then((value){
      BedsideBedsideAgentListModelData info = BedsideBedsideAgentListModelData.fromJson(value["bedsideAgent"]);
      super.closeLoading();
      success(info);
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideagenthospitalListByAgentId(int agentId,{success}) {
    Map<String,int> queryParameters = {
      "agentId": agentId
    };
    super.openLoading();
    Http.getInstance().get(queryParameters,path: "/bedside/bedsideagenthospital/listByAgentId").then((value){
      hospitalIds = [];
      value.data.forEach((v) {
        hospitalIds.add(v);
      });
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
    });
  }

  void bedsideBedsideAgentDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideagent/delete").then((value){
      this.bedsideBedsideAgentListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideAgentDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideagent/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideAgentListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideAgentListModelDatas[0].replace(data);
    }else {
      this.bedsideBedsideAgentListModelDatas[index].replace(data);
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideAgentListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideAgentListDto.toJson());
      print(this.currentBedsideBedsideAgentListDto.page);
      this.initBedsideBedsideAgentList();
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
    print("BedsideBedsideAgentViewModel dispose ++++++++++");
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
