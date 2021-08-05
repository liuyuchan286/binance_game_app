
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/dto/bedside_bedside_ops/bedside_bedside_ops_list_dto.dart';
import 'package:binance_game_app/dto/bedside_bedside_ops/bedside_bedsideopshospital_save_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_ops_hospital_listbyopsid_model.dart';
import 'package:binance_game_app/model/bedside_bedside_ops_list_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideBedsideOpsViewModel extends BaseViewModel{

  List<BedsideBedsideOpsListModelData> bedsideBedsideOpsListModelDatas = [];

  List<BedsideBedsideOpsHospitalListbyopsidModel> bedsideBedsideOpsHospitalListbyopsidModels = [];

  List<int> ids = [];

  BedsideBedsideOpsListDto currentBedsideBedsideOpsListDto = BedsideBedsideOpsListDto();

  ScrollController scrollController = ScrollController();

  int _currPage;
  int _totalPage;
  int _totalCount;




  BedsideBedsideOpsViewModel(){
    this.defaultData();
    scrollController.addListener(_scrollListener);
  }

  void initBedsideBedsideOpsList({dynamic param}) {
    if (param != null) {
      this.bedsideBedsideOpsListModelDatas = [];
      currentBedsideBedsideOpsListDto = BedsideBedsideOpsListDto.fromJson(param);
    }
    this.bedsideBedsideOpsList(currentBedsideBedsideOpsListDto,success: (data){
      BedsideBedsideOpsListModel model = BedsideBedsideOpsListModel.fromJson(data);
      _currPage = model.currPage;
      _totalPage = model.totalPage;
      _totalCount = model.totalCount;
      bedsideBedsideOpsListModelDatas.addAll(model.list);
    });
  }


  void bedsideBedsideOpsList(BedsideBedsideOpsListDto bedsideBedsideOpsListDto,{success}) {
    //如果正在加载中
    if(super.loading) {
      return;
    }
    if (_currPage == _totalPage) {
      return;
    }
    this.currentBedsideBedsideOpsListDto.page = _currPage +  1;
    super.openLoading();
    Http.getInstance().getDyJson(bedsideBedsideOpsListDto.toJson(),path: "/bedside/bedsideops/list").then((value){
      success(value['page']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideOpsSaveUpdate (BedsideBedsideOpsListModelData data,{success}) {
    //2s之后关闭
    Future.delayed(Duration(milliseconds: 1500), () {
      if(super.loading) {
        super.closeLoading();
      }
    });
    super.openLoading();
    Http.getInstance().post(data.toJson(),path: "/bedside/bedsideops/${data.id == null ? 'save' : 'update'}").then((value) {
      success(value);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideOpsInfo(int id,{success}) {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/bedside/bedsideops/info/${id}").then((value){
      BedsideBedsideOpsListModelData info = BedsideBedsideOpsListModelData.fromJson(value["bedsideOps"]);
      success(info);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

  void bedsideBedsideOpsDelete(index,List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideops/delete").then((value){
      this.bedsideBedsideOpsListModelDatas.removeAt(index);
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideOpsDeleteSelect(List<int> ids,{success,error}) {
    super.openLoading();
    Http.getInstance().post(ids,path: "/bedside/bedsideops/delete").then((value){
      this.ids = [];
      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void bedsideBedsideopshospitalListByOpsId(int id,{success,error}) {
    super.openLoading();
    Map<String,int> queryParameters = {
      "opsId": id
    };
    Http.getInstance().get(queryParameters,path: "/bedside/bedsideopshospital/listByOpsId").then((value){
      bedsideBedsideOpsHospitalListbyopsidModels = (value.data as List).map((e) => BedsideBedsideOpsHospitalListbyopsidModel.fromJson(e)).toList();
      super.closeLoading();
    }).catchError((onError) {
      super.closeLoading();
    });
  }

  void bedsideBedsideopshospitalSave(BedsideBedsideopshospitalSaveDto dto,{success,error}) {
    super.openLoading();
    Http.getInstance().post(dto.toJson(),path: "/bedside/bedsideopshospital/save").then((value){

      super.closeLoading();
      success(value);
    }).catchError((onError){
      super.closeLoading();
      error(onError);
    });
  }

  void refreshList(BedsideBedsideOpsListModelData data,int index) {
    if(index == null) {
      this.bedsideBedsideOpsListModelDatas[0] = data;
    }else {
      this.bedsideBedsideOpsListModelDatas[index] = data;
    }
    this.notifyListeners();
  }

  void selectAll(bool checked) {
    if(checked) {
      ids = bedsideBedsideOpsListModelDatas.map((e) => e.id).toList();
    }else {
      ids = List.filled(0, null);
    }
    super.notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 1) {
      print(this.currentBedsideBedsideOpsListDto.toJson());
      print(this.currentBedsideBedsideOpsListDto.page);
      this.initBedsideBedsideOpsList();
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
    print("BedsideBedsideOpsViewModel dispose ++++++++++");
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  int get totalCount => _totalCount;

  int get totalPage => _totalPage;

  int get currPage => _currPage;
}
