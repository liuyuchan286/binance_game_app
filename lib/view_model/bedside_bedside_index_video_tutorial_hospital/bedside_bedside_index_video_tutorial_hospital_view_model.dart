
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_index_video_tutorial_hospital/bedside_bedside_index_video_tutorial_hospital_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_index_video_tutorial_hospital_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideIndexVideoTutorialHospitalViewModel extends BaseViewModel{

  List<BedsideBedsideIndexVideoTutorialHospitalListModelData> bedsideBedsideIndexVideoTutorialHospitalListModelDatas = [];

  List<int> ids = [];

  List<int> selectIds = [];

  BedsideBedsideIndexVideoTutorialHospitalListDto currentBedsideBedsideIndexVideoTutorialHospitalListDto = BedsideBedsideIndexVideoTutorialHospitalListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideIndexVideoTutorialHospitalViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideIndexVideoTutorialHospitalList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideIndexVideoTutorialHospitalListModelDatas = [];
      currentBedsideBedsideIndexVideoTutorialHospitalListDto = BedsideBedsideIndexVideoTutorialHospitalListDto.fromJson(param);
    }
    this.bedsideBedsideIndexVideoTutorialHospitalList(currentBedsideBedsideIndexVideoTutorialHospitalListDto,success: (data){
      BedsideBedsideIndexVideoTutorialHospitalListModel model = BedsideBedsideIndexVideoTutorialHospitalListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideIndexVideoTutorialHospitalListModelDatas.addAll(model.list);
    });
  }

  void initBedsideBedsideIndexVideoTutorialHospitalListAll(int id) {
    this.bedsideBedsideIndexVideoTutorialHospitalList(BedsideBedsideIndexVideoTutorialHospitalListDto(),success: (data){
      bedsideBedsideIndexVideoTutorialHospitalListModelDatas = [];
      selectIds = [];
      if (data != null) {
        data.forEach((v) {
          BedsideBedsideIndexVideoTutorialHospitalListModelData data = BedsideBedsideIndexVideoTutorialHospitalListModelData.fromJson(v)..infoId = id;
          bedsideBedsideIndexVideoTutorialHospitalListModelDatas.add(data);
          if(data.selected()) {
            selectIds.add(data.id);
          }
        });
      }
    });
  }


  void bedsideBedsideIndexVideoTutorialHospitalList(BedsideBedsideIndexVideoTutorialHospitalListDto bedsideBedsideIndexVideoTutorialHospitalListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideIndexVideoTutorialHospitalListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideIndexVideoTutorialHospitalListDto.toJson(),path: "/bedside/bedsideindexvideotutorialhospital/list").then((value){
      print(value['data']);
      success(value['data']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideIndexVideoTutorialHospitalSaveUpdate (BedsideBedsideIndexVideoTutorialHospitalListModelData data,{success}) {
    super.openLoading();
    //2s之后关闭
    Future.delayed(Duration(milliseconds: 1500), () {
      if(super.loading) {
        super.closeLoading();
      }
    });
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsideindexvideotutorialhospital/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideIndexVideoTutorialHospitalInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsideindexvideotutorialhospital/info/${id}").then((value){
      BedsideBedsideIndexVideoTutorialHospitalListModelData info = BedsideBedsideIndexVideoTutorialHospitalListModelData.fromJson(value["bedsideIndexVideoTutorialHospital"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideIndexVideoTutorialHospitalDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideindexvideotutorialhospital/delete").then((value){
      this.bedsideBedsideIndexVideoTutorialHospitalListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideIndexVideoTutorialHospitalDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideindexvideotutorialhospital/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideIndexVideoTutorialHospitalListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideIndexVideoTutorialHospitalListModelDatas[0].replace(data);
    }else {
      this.bedsideBedsideIndexVideoTutorialHospitalListModelDatas[index].replace(data);
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideIndexVideoTutorialHospitalListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideIndexVideoTutorialHospitalListDto.toJson());
      print(this.currentBedsideBedsideIndexVideoTutorialHospitalListDto.page);
      this.initBedsideBedsideIndexVideoTutorialHospitalList();
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
    print("BedsideBedsideIndexVideoTutorialHospitalViewModel dispose ++++++++++");
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
