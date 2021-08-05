import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/constant/theme_colors.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_user_hospital_deposit_list_model.dart';
import 'package:binance_game_app/model/list_table_column_model.dart';
import 'package:binance_game_app/model/search_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_hospital/bedside_bedside_hospital_view_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_user_hospital_deposit/bedside_bedside_user_hospital_deposit_view_model.dart';
import 'package:binance_game_app/view_model/enums/enum_view_model.dart';
import 'package:binance_game_app/widget/list_circle_checkbox.dart';
import 'package:binance_game_app/widget/list_click_text_button.dart';
import 'package:binance_game_app/widget/list_search_text_field.dart';
import 'package:binance_game_app/widget/list_select.dart';
import 'package:binance_game_app/widget/list_table_column.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideUserHospitalDepositPage extends StatelessWidget {

  static const routeName = '/bedsideuserhospitaldepositPage';


  BedsideBedsideUserHospitalDepositPage() {
    print("print");
  }

  BedsideBedsideUserHospitalDepositViewModel _bedsideBedsideUserHospitalDepositViewModel = BedsideBedsideUserHospitalDepositViewModel();

  final TextEditingController searchController = TextEditingController();

  List<SearchModel> searchList = [
    SearchModel(key: 1,value: "手机号",param: "phoneNumber"),
  ];

  Map searchParam = {
  };

  int currentSearchListIndex = 0;

  final double lineHeight = 30.h;
  final double preferredSizeBoxh = 15.h;
  bool check = false;

  @override
  Widget build(BuildContext context) {
    double preferredSizeHeight = (lineHeight + preferredSizeBoxh) * 2;
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onDoubleTap: () {
            _bedsideBedsideUserHospitalDepositViewModel.scrollController.animateTo(-10.h, duration: Duration(milliseconds: 500), curve: Curves.linear);
          },
          child: Text("用户医院押金表",)
        ),
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, preferredSizeHeight),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: preferredSizeBoxh,horizontal: 15.w),
            child: Column(
              children: [
                Container(
                  height: lineHeight,
                  child: Row(
                    children: [
                      ListSelect(topHeight: preferredSizeHeight,list: searchList,onChange: (value){
                        this.currentSearchListIndex = value;
                        searchParam[searchList[currentSearchListIndex].getParam()] = searchController.text;
                      },),
                      SizedBox(width: 8.w,),
                      ListSearchTextField(
                        width: 210.w,
                        controller: searchController,
                        onTap: () {
                          refreshList();
                        },
                      ),
                      SizedBox(width: 15.w,),
                    ],
                  ),
                ),
                SizedBox(height: preferredSizeBoxh,),
                ProviderWidget(
                  viewModel: BedsideBedsideHospitalViewModel(),
                  init: (BedsideBedsideHospitalViewModel model) {
                    model.bedsideBedsideHospitalListAll();
                  },
                  builder: (c,BedsideBedsideHospitalViewModel model,_){
                    if (model.loading) {
                      return CupertinoActivityIndicator();
                    }
                    return Container(
                      height: lineHeight,
                      child: Row(
                        children: [
                          Expanded(
                            child: ListSelect(topHeight: preferredSizeHeight,list: model.bedsideBedsideHospitalListModelDatas,onChange: (value){
                              if (model.bedsideBedsideHospitalListModelDatas[value].getKey() == null) {
                                searchParam.remove(model.bedsideBedsideHospitalListModelDatas[value].getParam());
                              }else {
                                searchParam[model.bedsideBedsideHospitalListModelDatas[value].getParam()] = model.bedsideBedsideHospitalListModelDatas[value].getKey();
                              }
                            },),
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          ProviderWidget(
            viewModel: _bedsideBedsideUserHospitalDepositViewModel,
            init: (BedsideBedsideUserHospitalDepositViewModel model) {
              model.initBedsideBedsideUserHospitalDepositList();
            },
            builder: (c,BedsideBedsideUserHospitalDepositViewModel model, _) {
              if(model.loading && model.bedsideBedsideUserHospitalDepositListModelDatas.isEmpty) {
                return Center(child: CupertinoActivityIndicator());
              }
              return ListView.builder(
                itemCount: model.bedsideBedsideUserHospitalDepositListModelDatas.length + 1,
                controller: model.scrollController,
                padding: EdgeInsets.only(bottom: 45.h),
                itemBuilder: (BuildContext context, int index){
                  if((model.totalCount == model.bedsideBedsideUserHospitalDepositListModelDatas.length || model.currPage == model.totalPage) && index == model.bedsideBedsideUserHospitalDepositListModelDatas.length) {
                    return Center(
                      child: Text("没有更多数据了",
                        style: Theme.of(context).textTheme.headline2.copyWith(
                          color: ThemeColors.COLOR_BDBDBD
                        ),
                      ),
                    );
                  } else if(index == model.bedsideBedsideUserHospitalDepositListModelDatas.length) {
                    return Center(child: CupertinoActivityIndicator());
                  }
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10.h,horizontal: 15.w),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 4.w),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListCircleCheckbox(
                                check: model.ids.contains(model.bedsideBedsideUserHospitalDepositListModelDatas[index].id),
                                onChanged: (value) {
                                  if(value) {
                                    model.ids.add(model.bedsideBedsideUserHospitalDepositListModelDatas[index].id);
                                  }else {
                                    model.ids.remove(model.bedsideBedsideUserHospitalDepositListModelDatas[index].id);
                                  }
                                },
                              ),
                              SizedBox(width: 9.w,),
                              ListTableColumn(
                                dataList: [
                                  ListTableColumnModel(key: "用户id：",value: model.bedsideBedsideUserHospitalDepositListModelDatas[index].userId.toString()),
                                  ListTableColumnModel(key: "手机号",value: model.bedsideBedsideUserHospitalDepositListModelDatas[index].phoneNumber.toString()),
                                  ListTableColumnModel(key: "医院",value: model.bedsideBedsideUserHospitalDepositListModelDatas[index].hospitalName.toString()),
                                  ListTableColumnModel(key: "保证金：",value: model.bedsideBedsideUserHospitalDepositListModelDatas[index].deposit.toString()),
                                  ListTableColumnModel(key: "退款中保证金：",value: model.bedsideBedsideUserHospitalDepositListModelDatas[index].refundingDeposit.toString()),
                                  ListTableColumnModel(key: "创建时间：",value: model.bedsideBedsideUserHospitalDepositListModelDatas[index].createdAt),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 16.h,),
                          Container(
                            width: double.infinity,
                            child: Wrap(
                              runSpacing: 15.h,
                              alignment: WrapAlignment.end,
                              children: [
                                Offstage(
                                  offstage: model.bedsideBedsideUserHospitalDepositListModelDatas[index].deposit <= 0,
                                  child: ListClickTextButton("退押金",onPressed: () {
                                    refundHandler(context, model.bedsideBedsideUserHospitalDepositListModelDatas[index],index);
                                  },),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          ),
        ],
      ),
    );
  }


  delHandler(BuildContext context,BedsideBedsideUserHospitalDepositListModelData data,int index) {

    if(Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) {
        return AlertDialog(
          title: Text('提示'),
          content: Text('确认删除[${data.id}]吗？'),
          actions: <Widget>[
            FlatButton(child: Text('取消'),onPressed: (){
              Navigator.pop(context);
            },),
            FlatButton(child: Text('确认'),onPressed: (){
                Navigator.pop(context);
                EasyLoading.show(status: "删除中");
                _bedsideBedsideUserHospitalDepositViewModel.bedsideBedsideUserHospitalDepositDelete(index, [data.id],success: (value) {
                  EasyLoading.dismiss();
                  EasyLoading.showToast("删除成功");
                },error: (err) {
                  EasyLoading.dismiss();
                  EasyLoading.showToast("删除失败:${err.toString()}");
                });
            },),
          ],
        );
      });
    }else if(Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
        return CupertinoAlertDialog(
          title: Text('提示'),
          content: Text('确认删除[${data.id}]吗？'),
          actions: <Widget>[
            CupertinoDialogAction(child: Text('取消'),onPressed: (){
              Navigator.pop(context);
            },),
            CupertinoDialogAction(child: Text('确认'),onPressed: (){
                Navigator.pop(context);
                EasyLoading.show(status: "删除中");
                _bedsideBedsideUserHospitalDepositViewModel.bedsideBedsideUserHospitalDepositDelete(index, [data.id],success: (value) {
                  EasyLoading.dismiss();
                  EasyLoading.showToast("删除成功");
                },error: (err) {
                  EasyLoading.dismiss();
                  EasyLoading.showToast("删除失败:${err.toString()}");
                });
            },),
          ],
        );
      });
    }
  }

  delSelectHandler(BuildContext context,List<int> ids) {
    if (ids.isEmpty) {
      EasyLoading.showToast("请选择删除的数据");
      return;
    }
    if (Platform.isAndroid) {
          showDialog(
            context: context,
            builder: (context) {
            return AlertDialog(
              title: Text('提示'),
              content: Text('确认批量删除吗？'),
              actions: <Widget>[
                FlatButton(child: Text('取消'),onPressed: (){
                  Navigator.pop(context);
                },),
                FlatButton(child: Text('确认'),onPressed: (){
                    Navigator.pop(context);
                    EasyLoading.show(status: "删除中");
                    _bedsideBedsideUserHospitalDepositViewModel.bedsideBedsideUserHospitalDepositDeleteSelect(ids,success: (value) {
                      EasyLoading.dismiss();
                      EasyLoading.showToast("删除成功");
                      refreshList();
                    },error: (err) {
                      EasyLoading.dismiss();
                      EasyLoading.showToast("删除失败:${err.toString()}");
                    });
                },),
              ],
            );
          });
        }else if(Platform.isIOS) {
          showCupertinoDialog(
            context: context,
            builder: (context) {
            return CupertinoAlertDialog(
              title: Text('提示'),
              content: Text('确认批量删除吗？'),
              actions: <Widget>[
                CupertinoDialogAction(child: Text('取消'),onPressed: (){
                  Navigator.pop(context);
                },),
                CupertinoDialogAction(child: Text('确认'),onPressed: (){
                    Navigator.pop(context);
                    EasyLoading.show(status: "删除中");
                    _bedsideBedsideUserHospitalDepositViewModel.bedsideBedsideUserHospitalDepositDeleteSelect(ids,success: (value) {
                      EasyLoading.dismiss();
                      EasyLoading.showToast("删除成功");
                      refreshList();
                    },error: (err) {
                      EasyLoading.dismiss();
                      EasyLoading.showToast("删除失败:${err.toString()}");
                    });
                },),
              ],
            );
          });
        }
  }

  refundHandler(BuildContext context,BedsideBedsideUserHospitalDepositListModelData data,int index) {

    if(Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('提示'),
              content: Text('确认对[${data.phoneNumber}进行退押金]吗？'),
              actions: <Widget>[
                FlatButton(child: Text('取消'),onPressed: (){
                  Navigator.pop(context);
                },),
                FlatButton(child: Text('确认'),onPressed: (){
                  Navigator.pop(context);
                  EasyLoading.show(status: "退押金中");
                  _bedsideBedsideUserHospitalDepositViewModel.bedsideBedsideuserhospitaldepositRefund([data.id],success: (value) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("退押金成功");
                    refreshList();
                  },error: (err) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("退押金失败:${err.toString()}");
                  });
                },),
              ],
            );
          });
    }else if(Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('提示'),
              content: Text('确认对[${data.phoneNumber}进行退押金]吗？'),
              actions: <Widget>[
                CupertinoDialogAction(child: Text('取消'),onPressed: (){
                  Navigator.pop(context);
                },),
                CupertinoDialogAction(child: Text('确认'),onPressed: (){
                  Navigator.pop(context);
                  EasyLoading.show(status: "退押金中");
                  _bedsideBedsideUserHospitalDepositViewModel.bedsideBedsideuserhospitaldepositRefund([data.id],success: (value) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("退押金成功");
                    refreshList();
                  },error: (err) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("退押金失败:${err.toString()}");
                  });
                },),
              ],
            );
          });
    }
  }

  refreshList() {
    if(searchController.text.isEmpty) {
      searchParam.remove(searchList[currentSearchListIndex].getParam());
    }else if(searchController.text.isNotEmpty) {
      searchParam[searchList[currentSearchListIndex].getParam()] = searchController.text;
    }
    _bedsideBedsideUserHospitalDepositViewModel.defaultData();
    _bedsideBedsideUserHospitalDepositViewModel.initBedsideBedsideUserHospitalDepositList(param: searchParam);
  }
}
