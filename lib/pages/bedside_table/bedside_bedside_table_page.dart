import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/constant/theme_colors.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_table_list_model.dart';
import 'package:binance_game_app/model/list_table_column_model.dart';
import 'package:binance_game_app/model/search_model.dart';
import 'package:binance_game_app/pages/bedside_order_unlock/bedside_bedside_order_unlock_page.dart';
import 'package:binance_game_app/view_model/bedside_bedside_table/bedside_bedside_table_view_model.dart';
import 'package:binance_game_app/view_model/enums/enum_view_model.dart';
import 'package:binance_game_app/widget/list_circle_checkbox.dart';
import 'package:binance_game_app/widget/list_click_text_button.dart';
import 'package:binance_game_app/widget/list_search_hospital_select.dart';
import 'package:binance_game_app/widget/list_search_text_field.dart';
import 'package:binance_game_app/widget/list_select.dart';
import 'package:binance_game_app/widget/list_table_column.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideTablePage extends StatelessWidget {

  static const routeName = '/bedsidetablePage';


  BedsideBedsideTablePage() {
    print("print");
  }

  BedsideBedsideTableViewModel _bedsideBedsideTableViewModel = BedsideBedsideTableViewModel();

  final TextEditingController searchController = TextEditingController();

  List<SearchModel> searchList = [
    SearchModel(key: 1,value: "二维码号",param: "number"),
    SearchModel(key: 2,value: "设备编号",param: "deviceId"),
  ];


  Map searchParam = {
  };

  int currentSearchListIndex = 0;

  final double lineHeight = 30.h;
  final double preferredSizeBoxh = 15.h;
  bool check = false;



  @override
  Widget build(BuildContext context) {
    double preferredSizeHeight = (lineHeight + preferredSizeBoxh) * 3;
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onDoubleTap: () {
            _bedsideBedsideTableViewModel.scrollController.animateTo(-10.h, duration: Duration(milliseconds: 500), curve: Curves.linear);
          },
          child: Text("床头柜记录表",)
        ),
        bottom: PreferredSize(
          preferredSize: Size(double.infinity,preferredSizeHeight),
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
                ListSearchHospitalSelect(lineHeight: lineHeight, preferredSizeBoxh: preferredSizeBoxh, searchParam: searchParam,topHeight: preferredSizeHeight,),
                SizedBox(height: preferredSizeBoxh,),

                ProviderWidget(
                  viewModel: EnumViewModel(),
                  init: (EnumViewModel model) {
                    model.appEnumsAll();
                  },
                  builder: (c,EnumViewModel model,_){
                    if (model.loading) {
                      return CupertinoActivityIndicator();
                    }
                    return Container(
                      height: lineHeight,
                      child: Row(
                        children: [
                          Expanded(
                            child: ListSelect(topHeight: preferredSizeHeight,list: model.enumAllModel.tableStatus,onChange: (value){
                              if (model.enumAllModel.tableStatus[value].getKey() == null) {
                                searchParam.remove(model.enumAllModel.tableStatus[value].getParam());
                              }else {
                                searchParam[model.enumAllModel.tableStatus[value].getParam()] = model.enumAllModel.tableStatus[value].getKey();
                              }
                            }),
                          ),
                          Expanded(
                            child: ListSelect(topHeight: preferredSizeHeight,list: model.enumAllModel.tableSource,onChange: (value){
                              if (model.enumAllModel.tableSource[value].getKey() == null) {
                                searchParam.remove(model.enumAllModel.tableSource[value].getParam());
                              }else {
                                searchParam[model.enumAllModel.tableSource[value].getParam()] = model.enumAllModel.tableSource[value].getKey();
                              }
                            }),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          ProviderWidget(
            viewModel: _bedsideBedsideTableViewModel,
            init: (BedsideBedsideTableViewModel model) {
              model.initBedsideBedsideTableList();
            },
            builder: (c,BedsideBedsideTableViewModel model, _) {
              if(model.loading && model.bedsideBedsideTableListModelDatas.isEmpty) {
                return Center(child: CupertinoActivityIndicator());
              }
              return ListView.builder(
                itemCount: model.bedsideBedsideTableListModelDatas.length + 1,
                controller: model.scrollController,
                padding: EdgeInsets.only(bottom: 45.h),
                itemBuilder: (BuildContext context, int index){
                  if((model.totalCount == model.bedsideBedsideTableListModelDatas.length || model.currPage == model.totalPage) && index == model.bedsideBedsideTableListModelDatas.length) {
                    return Center(
                      child: Text("没有更多数据了",
                        style: Theme.of(context).textTheme.headline2.copyWith(
                          color: ThemeColors.COLOR_BDBDBD
                        ),
                      ),
                    );
                  } else if(index == model.bedsideBedsideTableListModelDatas.length) {
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
                                check: model.ids.contains(model.bedsideBedsideTableListModelDatas[index].id),
                                onChanged: (value) {
                                  if(value) {
                                    model.ids.add(model.bedsideBedsideTableListModelDatas[index].id);
                                  }else {
                                    model.ids.remove(model.bedsideBedsideTableListModelDatas[index].id);
                                  }
                                },
                              ),
                              SizedBox(width: 9.w,),
                              ListTableColumn(
                                dataList: [
                                  ListTableColumnModel(key: "二维码编号：",value: model.bedsideBedsideTableListModelDatas[index].number),
                                  ListTableColumnModel(key: "医院名称：",value: model.bedsideBedsideTableListModelDatas[index].hospitalName),
                                  ListTableColumnModel(key: "科室名称：",value: model.bedsideBedsideTableListModelDatas[index].officeName),
                                  ListTableColumnModel(key: "房间号名称：",value: model.bedsideBedsideTableListModelDatas[index].roomName),
                                  ListTableColumnModel(key: "床号名称：",value: model.bedsideBedsideTableListModelDatas[index].bedName),
                                  ListTableColumnModel(key: "设备编号：",value: model.bedsideBedsideTableListModelDatas[index].deviceId),
                                  ListTableColumnModel(key: "状态",value: model.bedsideBedsideTableListModelDatas[index].statusStr.toString()),

                                  ListTableColumnModel(key: "信号强度：",value: model.bedsideBedsideTableListModelDatas[index].signal.toString()),
                                  ListTableColumnModel(key: "电量：",value: model.bedsideBedsideTableListModelDatas[index].battery.toString()),
                                  ListTableColumnModel(key: "累计使用次数：",value: model.bedsideBedsideTableListModelDatas[index].num.toString()),
                                  ListTableColumnModel(key: "累计赚取金额：",value: model.bedsideBedsideTableListModelDatas[index].money.toString()),
                                  ListTableColumnModel(key: "创建时间：",value: model.bedsideBedsideTableListModelDatas[index].createdAt),
                                  ListTableColumnModel(key: "锁厂",value: model.bedsideBedsideTableListModelDatas[index].sourceStr.toString()),

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
                                ListClickTextButton("开锁",onPressed: () {
                                  openLockHandler(context,id: model.bedsideBedsideTableListModelDatas[index].id);
                                },),
                                Offstage(
                                  offstage: model.bedsideBedsideTableListModelDatas[index].source != 3,
                                  child: ListClickTextButton("转到AEP",onPressed: () {
                                    toAepHandler(context,id: model.bedsideBedsideTableListModelDatas[index].id);
                                  },),
                                ),
                                Offstage(
                                  offstage: model.bedsideBedsideTableListModelDatas[index].source != 4,
                                  child: ListClickTextButton("转到行越",onPressed: () {
                                    toXYLockHandler(context,id: model.bedsideBedsideTableListModelDatas[index].id);
                                  },),
                                ),
                                ListClickTextButton("强制重置",onPressed: () {
                                  forceResetHandler(context,id: model.bedsideBedsideTableListModelDatas[index].id);
                                },),

                                ListClickTextButton("正常重置",onPressed: () {
                                  resetHandler(context,id: model.bedsideBedsideTableListModelDatas[index].id);
                                },),

                                ListClickTextButton("开锁记录",onPressed: () {
                                  Navigator.pushNamed(context, BedsideBedsideOrderUnlockPage.routeName,arguments: model.bedsideBedsideTableListModelDatas[index].number);
                                },),

                                ListClickTextButton("校准",onPressed: () {
                                  calibrationHandler(context,id: model.bedsideBedsideTableListModelDatas[index].id);
                                },),

                                Offstage(
                                  offstage: model.bedsideBedsideTableListModelDatas[index].status != 1,
                                  child: ListClickTextButton("禁用",onPressed: () {
                                    updateStatusHandler(context, model.bedsideBedsideTableListModelDatas[index].id,4,"禁用");
                                  },),
                                ),

                                Offstage(
                                  offstage: model.bedsideBedsideTableListModelDatas[index].status != 4,
                                  child: ListClickTextButton("启用",onPressed: () {
                                    updateStatusHandler(context, model.bedsideBedsideTableListModelDatas[index].id,1,"启用");
                                  },),
                                ),

                                ListClickTextButton("修改",onPressed: () {
                                  Navigator.pushNamed(context,"${BedsideBedsideTablePage.routeName.replaceFirst("Page", "SaveOrUpadtePage")}",arguments: SaveOrUpdateDto(
                                    index: index,
                                    titleStr: "修改",
                                    id: model.bedsideBedsideTableListModelDatas[index].id,
                                    callback: (data) {
                                      model.refreshList(data, index);
                                    }
                                  ));
                                },),
                                ListClickTextButton("删除",onPressed: () {
                                  delHandler(context, model.bedsideBedsideTableListModelDatas[index],index);
                                },),
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
          Positioned(
            bottom: 0.h,
            child: Card(
              borderOnForeground: true,
              child: Container(
                width: 375.w,
                height: 45.h,
                padding: EdgeInsets.symmetric(horizontal: 19.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListCircleCheckbox(topPadding: 0.h,onChanged: (value) {
                      print(value);
                      _bedsideBedsideTableViewModel.selectAll(value);
                    },),
                    SizedBox(width: 5.w,),
                    Text("全选",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Spacer(),
                    PopupMenuButton<int>(
                      onSelected: (value) {
                        if(value == 1) {
                          delSelectHandler(context, _bedsideBedsideTableViewModel.ids);
                        }else if(value == 2) {
                          calibrationHandler(context, ids: _bedsideBedsideTableViewModel.ids);
                        }else if(value == 3) {
                          resetHandler(context, ids: _bedsideBedsideTableViewModel.ids);
                        }else if(value == 4) {
                          forceResetHandler(context, ids: _bedsideBedsideTableViewModel.ids);
                        }
                      },
                      itemBuilder: (context) {
                        TextStyle selectAllStyle = Theme.of(context).textTheme.headline2.copyWith(color: ThemeColors.COLOR_333333);
                        return <PopupMenuEntry<int>>[
                          PopupMenuItem<int>(
                            value: 1,
                            child: Text('批量删除',
                              style: selectAllStyle,
                            ),
                          ),
                          PopupMenuItem<int>(
                            value: 2,
                            child: Text('批量校准',
                              style: selectAllStyle,
                            ),
                          ),
                          PopupMenuItem<int>(
                            value: 3,
                            child: Text('批量正常重置',
                              style: selectAllStyle,
                            ),
                          ),
                          PopupMenuItem<int>(
                            value: 4,
                            child: Text('批量强制重置',
                              style: selectAllStyle,
                            ),
                          ),
                        ];
                      },
                    )
                    // Image.asset("assets/images/select_all_more.png")
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  delHandler(BuildContext context,BedsideBedsideTableListModelData data,int index) {

    if(Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) {
        return AlertDialog(
          title: Text('提示'),
          content: Text('确认删除[${data.number}]吗？'),
          actions: <Widget>[
            FlatButton(child: Text('取消'),onPressed: (){
              Navigator.pop(context);
            },),
            FlatButton(child: Text('确认'),onPressed: (){
                Navigator.pop(context);
                EasyLoading.show(status: "删除中");
                _bedsideBedsideTableViewModel.bedsideBedsideTableDelete(index, [data.id],success: (value) {
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
          content: Text('确认删除[${data.number}]吗？'),
          actions: <Widget>[
            CupertinoDialogAction(child: Text('取消'),onPressed: (){
              Navigator.pop(context);
            },),
            CupertinoDialogAction(child: Text('确认'),onPressed: (){
                Navigator.pop(context);
                EasyLoading.show(status: "删除中");
                _bedsideBedsideTableViewModel.bedsideBedsideTableDelete(index, [data.id],success: (value) {
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
                    _bedsideBedsideTableViewModel.bedsideBedsideTableDeleteSelect(ids,success: (value) {
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
                    _bedsideBedsideTableViewModel.bedsideBedsideTableDeleteSelect(ids,success: (value) {
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


  calibrationHandler(BuildContext context,{int id,List<int> ids}) {
    if (id != null) {
      ids = [id];
    }else{
      if(ids.isEmpty) {
        EasyLoading.showToast("请选择校准的数据");
        return;
      }
    }
    if(Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('提示'),
              content: Text('确认[校准]吗？'),
              actions: <Widget>[
                FlatButton(child: Text('取消'),onPressed: (){
                  Navigator.pop(context);
                },),
                FlatButton(child: Text('确认'),onPressed: (){
                  Navigator.pop(context);
                  EasyLoading.show(status: "校准中");
                  _bedsideBedsideTableViewModel.bedsideBedsideTableCalibration(ids,success: (value) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("校准成功");
                    refreshList();
                  },error: (err) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("校准失败:${err.toString()}");
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
              content: Text('确认[校准]吗？'),
              actions: <Widget>[
                CupertinoDialogAction(child: Text('取消'),onPressed: (){
                  Navigator.pop(context);
                },),
                CupertinoDialogAction(child: Text('确认'),onPressed: (){
                  Navigator.pop(context);
                  EasyLoading.show(status: "校准中");
                  _bedsideBedsideTableViewModel.bedsideBedsideTableCalibration(ids,success: (value) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("校准成功");
                    refreshList();
                  },error: (err) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("校准失败:${err.toString()}");
                  });
                },),
              ],
            );
          });
    }

  }


  openLockHandler(BuildContext context,{int id,List<int> ids}) {
    if (id != null) {
      ids = [id];
    }else{
      if(ids.isEmpty) {
        EasyLoading.showToast("请选择开锁的数据");
        return;
      }
    }
    if(Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('提示'),
              content: Text('确认[开锁]吗？'),
              actions: <Widget>[
                FlatButton(child: Text('取消'),onPressed: (){
                  Navigator.pop(context);
                },),
                FlatButton(child: Text('确认'),onPressed: (){
                  Navigator.pop(context);
                  EasyLoading.show(status: "开锁中");
                  _bedsideBedsideTableViewModel.bedsideBedsideTableOpenLock(ids,success: (value) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("开锁成功");
                    refreshList();
                  },error: (err) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("开锁失败:${err.toString()}");
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
              content: Text('确认[开锁]吗？'),
              actions: <Widget>[
                CupertinoDialogAction(child: Text('取消'),onPressed: (){
                  Navigator.pop(context);
                },),
                CupertinoDialogAction(child: Text('确认'),onPressed: (){
                  Navigator.pop(context);
                  EasyLoading.show(status: "开锁中");
                  _bedsideBedsideTableViewModel.bedsideBedsideTableOpenLock(ids,success: (value) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("开锁成功");
                    refreshList();
                  },error: (err) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("开锁失败:${err.toString()}");
                  });
                },),
              ],
            );
          });
    }

  }



  toAepHandler(BuildContext context,{int id,List<int> ids}) {
    if (id != null) {
      ids = [id];
    }else{
      if(ids.isEmpty) {
        EasyLoading.showToast("请选择转锁厂的数据");
        return;
      }
    }
    if(Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('提示'),
              content: Text('确认[转锁厂]吗？'),
              actions: <Widget>[
                FlatButton(child: Text('取消'),onPressed: (){
                  Navigator.pop(context);
                },),
                FlatButton(child: Text('确认'),onPressed: (){
                  Navigator.pop(context);
                  EasyLoading.show(status: "转锁厂中");
                  _bedsideBedsideTableViewModel.bedsideBedsideTableToAep(ids,success: (value) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("转锁厂成功");
                    refreshList();
                  },error: (err) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("转锁厂失败:${err.toString()}");
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
              content: Text('确认[转锁厂]吗？'),
              actions: <Widget>[
                CupertinoDialogAction(child: Text('取消'),onPressed: (){
                  Navigator.pop(context);
                },),
                CupertinoDialogAction(child: Text('确认'),onPressed: (){
                  Navigator.pop(context);
                  EasyLoading.show(status: "转锁厂中");
                  _bedsideBedsideTableViewModel.bedsideBedsideTableToAep(ids,success: (value) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("转锁厂成功");
                    refreshList();
                  },error: (err) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("转锁厂失败:${err.toString()}");
                  });
                },),
              ],
            );
          });
    }

  }

  toXYLockHandler(BuildContext context,{int id,List<int> ids}) {
    if (id != null) {
      ids = [id];
    }else{
      if(ids.isEmpty) {
        EasyLoading.showToast("请选择转锁厂的数据");
        return;
      }
    }
    if(Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('提示'),
              content: Text('确认[转锁厂]吗？'),
              actions: <Widget>[
                FlatButton(child: Text('取消'),onPressed: (){
                  Navigator.pop(context);
                },),
                FlatButton(child: Text('确认'),onPressed: (){
                  Navigator.pop(context);
                  EasyLoading.show(status: "转锁厂中");
                  _bedsideBedsideTableViewModel.bedsideBedsideTableToXYLock(ids,success: (value) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("转锁厂成功");
                    refreshList();
                  },error: (err) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("转锁厂失败:${err.toString()}");
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
              content: Text('确认[转锁厂]吗？'),
              actions: <Widget>[
                CupertinoDialogAction(child: Text('取消'),onPressed: (){
                  Navigator.pop(context);
                },),
                CupertinoDialogAction(child: Text('确认'),onPressed: (){
                  Navigator.pop(context);
                  EasyLoading.show(status: "转锁厂中");
                  _bedsideBedsideTableViewModel.bedsideBedsideTableToXYLock(ids,success: (value) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("转锁厂成功");
                    refreshList();
                  },error: (err) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("转锁厂失败:${err.toString()}");
                  });
                },),
              ],
            );
          });
    }

  }


  resetHandler(BuildContext context,{int id,List<int> ids}) {
    if (id != null) {
      ids = [id];
    }else{
      if(ids.isEmpty) {
        EasyLoading.showToast("请选择重置的数据");
        return;
      }
    }
    if(Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('提示'),
              content: Text('确认[重置]吗？'),
              actions: <Widget>[
                FlatButton(child: Text('取消'),onPressed: (){
                  Navigator.pop(context);
                },),
                FlatButton(child: Text('确认'),onPressed: (){
                  Navigator.pop(context);
                  EasyLoading.show(status: "重置中");
                  _bedsideBedsideTableViewModel.bedsideBedsideTableReset(ids,success: (value) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("重置成功");
                    refreshList();
                  },error: (err) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("重置失败:${err.toString()}");
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
              content: Text('确认[重置]吗？'),
              actions: <Widget>[
                CupertinoDialogAction(child: Text('取消'),onPressed: (){
                  Navigator.pop(context);
                },),
                CupertinoDialogAction(child: Text('确认'),onPressed: (){
                  Navigator.pop(context);
                  EasyLoading.show(status: "重置中");
                  _bedsideBedsideTableViewModel.bedsideBedsideTableReset(ids,success: (value) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("重置成功");
                    refreshList();
                  },error: (err) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("重置失败:${err.toString()}");
                  });
                },),
              ],
            );
          });
    }

  }


  forceResetHandler(BuildContext context,{int id,List<int> ids}) {
    if (id != null) {
      ids = [id];
    }else{
      if(ids.isEmpty) {
        EasyLoading.showToast("请选择重置的数据");
        return;
      }
    }
    if(Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('提示'),
              content: Text('确认[重置]吗？'),
              actions: <Widget>[
                FlatButton(child: Text('取消'),onPressed: (){
                  Navigator.pop(context);
                },),
                FlatButton(child: Text('确认'),onPressed: (){
                  Navigator.pop(context);
                  EasyLoading.show(status: "重置中");
                  _bedsideBedsideTableViewModel.bedsideBedsideTableForceReset(ids,success: (value) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("重置成功");
                    refreshList();
                  },error: (err) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("重置失败:${err.toString()}");
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
              content: Text('确认[重置]吗？'),
              actions: <Widget>[
                CupertinoDialogAction(child: Text('取消'),onPressed: (){
                  Navigator.pop(context);
                },),
                CupertinoDialogAction(child: Text('确认'),onPressed: (){
                  Navigator.pop(context);
                  EasyLoading.show(status: "重置中");
                  _bedsideBedsideTableViewModel.bedsideBedsideTableForceReset(ids,success: (value) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("重置成功");
                    refreshList();
                  },error: (err) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("重置失败:${err.toString()}");
                  });
                },),
              ],
            );
          });
    }

  }


  updateStatusHandler(BuildContext context,int id,int status,String statusStr) {

    BedsideBedsideTableListModelData data = BedsideBedsideTableListModelData(
      id: id,
      status: status
    );


    if(Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('提示'),
              content: Text('确认[重置]吗？'),
              actions: <Widget>[
                FlatButton(child: Text('取消'),onPressed: (){
                  Navigator.pop(context);
                },),
                FlatButton(child: Text('确认'),onPressed: (){
                  Navigator.pop(context);
                  EasyLoading.show(status: "${statusStr}中");
                  _bedsideBedsideTableViewModel.bedsideBedsideTableSaveUpdate(data,success: (value) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("${statusStr}成功");
                    refreshList();
                  },error: (err) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("${statusStr}失败:${err.toString()}");
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
              content: Text('确认[${statusStr}]吗？'),
              actions: <Widget>[
                CupertinoDialogAction(child: Text('取消'),onPressed: (){
                  Navigator.pop(context);
                },),
                CupertinoDialogAction(child: Text('确认'),onPressed: (){
                  Navigator.pop(context);
                  EasyLoading.show(status: "${statusStr}中");
                  _bedsideBedsideTableViewModel.bedsideBedsideTableSaveUpdate(data,success: (value) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("${statusStr}成功");
                    refreshList();
                  },error: (err) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("${statusStr}失败:${err.toString()}");
                  });
                },),
              ],
            );
          });
    }
  }

  refreshList() {
    for(SearchModel model in searchList) {
      searchParam.remove(model.getParam());
    }
    searchParam[searchList[currentSearchListIndex].getParam()] = searchController.text;
    _bedsideBedsideTableViewModel.defaultData();
    _bedsideBedsideTableViewModel.initBedsideBedsideTableList(param: searchParam);


  }
}
