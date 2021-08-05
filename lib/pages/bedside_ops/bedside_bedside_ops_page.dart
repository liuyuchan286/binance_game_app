import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/constant/theme_colors.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_ops_list_model.dart';
import 'package:binance_game_app/model/list_table_column_model.dart';
import 'package:binance_game_app/model/search_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_ops/bedside_bedside_ops_view_model.dart';
import 'package:binance_game_app/widget/list_circle_checkbox.dart';
import 'package:binance_game_app/widget/list_click_text_button.dart';
import 'package:binance_game_app/widget/list_search_text_field.dart';
import 'package:binance_game_app/widget/list_select.dart';
import 'package:binance_game_app/widget/list_table_column.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';

import 'bedside_bedside_ops_hospital_page.dart';


class BedsideBedsideOpsPage extends StatelessWidget {

  static const routeName = '/bedsideopsPage';


  BedsideBedsideOpsPage() {
    print("print");
  }

  BedsideBedsideOpsViewModel _bedsideBedsideOpsViewModel = BedsideBedsideOpsViewModel();

  final TextEditingController searchController = TextEditingController();

  List<SearchModel> searchList = [
    SearchModel(key: 1,value: "人员名称",param: "name"),
    SearchModel(key: 2,value: "手机号  ",param: "phone"),
  ];
  int currentSearchListIndex = 0;

  final double lineHeight = 30.h;
  final double preferredSizeBoxh = 15.h;
  bool check = false;

  @override
  Widget build(BuildContext context) {
    double preferredSizeHeight = (lineHeight + preferredSizeBoxh);
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onDoubleTap: () {
            _bedsideBedsideOpsViewModel.scrollController.animateTo(-10.h, duration: Duration(milliseconds: 500), curve: Curves.linear);
          },
          child: Text("运维管理",)
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
                // SizedBox(height: preferredSizeBoxh,),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          ProviderWidget(
            viewModel: _bedsideBedsideOpsViewModel,
            init: (BedsideBedsideOpsViewModel model) {
              model.initBedsideBedsideOpsList();
            },
            builder: (c,BedsideBedsideOpsViewModel model, _) {
              if(model.loading && model.bedsideBedsideOpsListModelDatas.isEmpty) {
                return Center(child: CupertinoActivityIndicator());
              }
              return ListView.builder(
                itemCount: model.bedsideBedsideOpsListModelDatas.length + 1,
                controller: model.scrollController,
                padding: EdgeInsets.only(bottom: 45.h),
                itemBuilder: (BuildContext context, int index){
                  if((model.totalCount == model.bedsideBedsideOpsListModelDatas.length || model.currPage == model.totalPage) && index == model.bedsideBedsideOpsListModelDatas.length) {
                    return Center(
                      child: Text("没有更多数据了",
                        style: Theme.of(context).textTheme.headline2.copyWith(
                          color: ThemeColors.COLOR_BDBDBD
                        ),
                      ),
                    );
                  } else if(index == model.bedsideBedsideOpsListModelDatas.length) {
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
                                check: model.ids.contains(model.bedsideBedsideOpsListModelDatas[index].id),
                                onChanged: (value) {
                                  if(value) {
                                    model.ids.add(model.bedsideBedsideOpsListModelDatas[index].id);
                                  }else {
                                    model.ids.remove(model.bedsideBedsideOpsListModelDatas[index].id);
                                  }
                                },
                              ),
                              SizedBox(width: 9.w,),
                              ListTableColumn(
                                dataList: [
                                  ListTableColumnModel(key: "运维人员名称：",value: model.bedsideBedsideOpsListModelDatas[index].name),
                                  ListTableColumnModel(key: "手机号：",value: model.bedsideBedsideOpsListModelDatas[index].phone),
                                  ListTableColumnModel(key: "联系地址：",value: model.bedsideBedsideOpsListModelDatas[index].address),
                                  ListTableColumnModel(key: "是否运维总管理：",value: model.bedsideBedsideOpsListModelDatas[index].isManageStr.toString()),
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
                                ListClickTextButton("负责医院",onPressed: () {
                                  Navigator.pushNamed(context,"${BedsideBedsideOpsHospitalPage.routeName}",arguments: SaveOrUpdateDto(
                                      index: index,
                                      id: model.bedsideBedsideOpsListModelDatas[index].id,
                                  ));
                                },),
                                ListClickTextButton("${model.bedsideBedsideOpsListModelDatas[index].isManage == 1 ? "设为管理" : "取消管理" }",onPressed: () {
                                  setManage(model.bedsideBedsideOpsListModelDatas[index], context);
                                },),
                                ListClickTextButton("修改",onPressed: () {
                                  Navigator.pushNamed(context,"${BedsideBedsideOpsPage.routeName.replaceFirst("Page", "SaveOrUpadtePage")}",arguments: SaveOrUpdateDto(
                                    index: index,
                                    titleStr: "修改",
                                    id: model.bedsideBedsideOpsListModelDatas[index].id,
                                    callback: (data) {
                                      model.refreshList(data, index);
                                    }
                                  ));
                                },),
                                ListClickTextButton("删除",onPressed: () {
                                  delHandler(context, model.bedsideBedsideOpsListModelDatas[index],index);
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
                      _bedsideBedsideOpsViewModel.selectAll(value);
                    },),
                    SizedBox(width: 5.w,),
                    Text("全选",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Spacer(),
                    PopupMenuButton<int>(
                      onSelected: (value) {
                        if(value == 1) {
                          delSelectHandler(context, _bedsideBedsideOpsViewModel.ids);
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
                        ];
                      },
                    )
                    // Image.asset("assets/images/select_all_more.png")
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 0.w,
            top: 300.h,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context,"${BedsideBedsideOpsPage.routeName.replaceFirst("Page", "SaveOrUpadtePage")}",arguments: SaveOrUpdateDto(
                    titleStr: "新增",
                    id: null,
                    callback: (data) {
                      refreshList();
                    }
                )
                );
              },
              child: Image.asset("assets/images/list_add_icon.png",
                width: 35.w,
                height: 35.h,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 设置或者取消管理
  void setManage(BedsideBedsideOpsListModelData data, BuildContext context) {

    int isManage = 1;
    String isManageTitle = "取消";
    String isManageStr = "否";
    if(data.isManage == 1) {
      isManage = 2;
      isManageTitle = "设置";
      isManageStr = "是";
    }
    if(Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('提示'),
              content: Text('确认将[${data.name}]${isManageTitle}管理吗？'),
              actions: <Widget>[
                FlatButton(child: Text('取消'),onPressed: (){
                  Navigator.pop(context);
                },),
                FlatButton(child: Text('确认'),onPressed: (){
                  Navigator.pop(context);
                  EasyLoading.show(status: "${isManageTitle}中");

                  BedsideBedsideOpsListModelData bedsideBedsideOpsListModelData = BedsideBedsideOpsListModelData(
                      id: data.id,
                      isManage: isManage
                  );
                  _bedsideBedsideOpsViewModel.bedsideBedsideOpsSaveUpdate(bedsideBedsideOpsListModelData,success: (value) {
                    data.isManageStr = isManageStr;
                    data.isManage = isManage;
                    EasyLoading.dismiss();
                    EasyLoading.showToast("${isManageTitle}成功");
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
              content: Text('确认删除[${data.name}]吗？'),
              actions: <Widget>[
                CupertinoDialogAction(child: Text('取消'),onPressed: (){
                  Navigator.pop(context);
                },),
                CupertinoDialogAction(child: Text('确认'),onPressed: (){
                  Navigator.pop(context);
                  EasyLoading.show(status: "${isManageTitle}中");

                  BedsideBedsideOpsListModelData bedsideBedsideOpsListModelData = BedsideBedsideOpsListModelData(
                    id: data.id,
                    isManage: isManage
                  );
                  _bedsideBedsideOpsViewModel.bedsideBedsideOpsSaveUpdate(bedsideBedsideOpsListModelData,success: (value) {
                    data.isManageStr = isManageStr;
                    data.isManage = isManage;
                    EasyLoading.dismiss();
                    EasyLoading.showToast("${isManageTitle}成功");
                  });
                },),
              ],
            );
          });
    }

  }


  delHandler(BuildContext context,BedsideBedsideOpsListModelData data,int index) {

    if(Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) {
        return AlertDialog(
          title: Text('提示'),
          content: Text('确认删除[${data.name}]吗？'),
          actions: <Widget>[
            FlatButton(child: Text('取消'),onPressed: (){
              Navigator.pop(context);
            },),
            FlatButton(child: Text('确认'),onPressed: (){
                Navigator.pop(context);
                EasyLoading.show(status: "删除中");
                _bedsideBedsideOpsViewModel.bedsideBedsideOpsDelete(index, [data.id],success: (value) {
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
          content: Text('确认删除[${data.name}]吗？'),
          actions: <Widget>[
            CupertinoDialogAction(child: Text('取消'),onPressed: (){
              Navigator.pop(context);
            },),
            CupertinoDialogAction(child: Text('确认'),onPressed: (){
                Navigator.pop(context);
                EasyLoading.show(status: "删除中");
                _bedsideBedsideOpsViewModel.bedsideBedsideOpsDelete(index, [data.id],success: (value) {
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
                    _bedsideBedsideOpsViewModel.bedsideBedsideOpsDeleteSelect(ids,success: (value) {
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
                    _bedsideBedsideOpsViewModel.bedsideBedsideOpsDeleteSelect(ids,success: (value) {
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

  refreshList() {
    _bedsideBedsideOpsViewModel.defaultData();
    Map param = {
      searchList[currentSearchListIndex].getParam() : searchController.text
    };
    _bedsideBedsideOpsViewModel.initBedsideBedsideOpsList(param: param);
  }
}
