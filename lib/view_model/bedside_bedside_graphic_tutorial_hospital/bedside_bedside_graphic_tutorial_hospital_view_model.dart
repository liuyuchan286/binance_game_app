
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_graphic_tutorial_hospital/bedside_bedside_graphic_tutorial_hospital_list_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_graphic_tutorial_hospital_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideGraphicTutorialHospitalViewModel extends BaseViewModel{

  List<BedsideBedsideGraphicTutorialHospitalListModelData> bedsideBedsideGraphicTutorialHospitalListModelDatas = [];

  List<int> ids = [];

  List<int> selectIds = [];

  BedsideBedsideGraphicTutorialHospitalListDto currentBedsideBedsideGraphicTutorialHospitalListDto = BedsideBedsideGraphicTutorialHospitalListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideGraphicTutorialHospitalViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideGraphicTutorialHospitalList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideGraphicTutorialHospitalListModelDatas = [];
      currentBedsideBedsideGraphicTutorialHospitalListDto = BedsideBedsideGraphicTutorialHospitalListDto.fromJson(param);
    }
    this.bedsideBedsideGraphicTutorialHospitalList(currentBedsideBedsideGraphicTutorialHospitalListDto,success: (data){
      BedsideBedsideGraphicTutorialHospitalListModel model = BedsideBedsideGraphicTutorialHospitalListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideGraphicTutorialHospitalListModelDatas.addAll(model.list);
    });
  }

  void initBedsideBedsideGraphicTutorialHospitalListAll(int id) {
    this.bedsideBedsideGraphicTutorialHospitalList(BedsideBedsideGraphicTutorialHospitalListDto(),success: (data){
      bedsideBedsideGraphicTutorialHospitalListModelDatas = [];
      if (data != null) {
        data.forEach((v) {
          BedsideBedsideGraphicTutorialHospitalListModelData data = BedsideBedsideGraphicTutorialHospitalListModelData.fromJson(v)..infoId = id;
          bedsideBedsideGraphicTutorialHospitalListModelDatas.add(data);
          if(data.selected()) {
            selectIds.add(data.id);
          }
        });
      }
    });
  }


  void bedsideBedsideGraphicTutorialHospitalList(BedsideBedsideGraphicTutorialHospitalListDto bedsideBedsideGraphicTutorialHospitalListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideGraphicTutorialHospitalListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideGraphicTutorialHospitalListDto.toJson(),path: "/bedside/bedsidegraphictutorialhospital/list").then((value){
      success(value['data']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideGraphicTutorialHospitalSaveUpdate (BedsideBedsideGraphicTutorialHospitalListModelData data,{success}) {
    super.openLoading();
    //2s之后关闭
    Future.delayed(Duration(milliseconds: 1500), () {
      if(super.loading) {
        super.closeLoading();
      }
    });
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsidegraphictutorialhospital/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideGraphicTutorialHospitalInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsidegraphictutorialhospital/info/${id}").then((value){
      BedsideBedsideGraphicTutorialHospitalListModelData info = BedsideBedsideGraphicTutorialHospitalListModelData.fromJson(value["bedsideGraphicTutorialHospital"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideGraphicTutorialHospitalDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidegraphictutorialhospital/delete").then((value){
      this.bedsideBedsideGraphicTutorialHospitalListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideGraphicTutorialHospitalDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsidegraphictutorialhospital/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideGraphicTutorialHospitalListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideGraphicTutorialHospitalListModelDatas[0].replace(data);
    }else {
      this.bedsideBedsideGraphicTutorialHospitalListModelDatas[index].replace(data);
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideGraphicTutorialHospitalListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideGraphicTutorialHospitalListDto.toJson());
      print(this.currentBedsideBedsideGraphicTutorialHospitalListDto.page);
      this.initBedsideBedsideGraphicTutorialHospitalList();
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
    print("BedsideBedsideGraphicTutorialHospitalViewModel dispose ++++++++++");
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
