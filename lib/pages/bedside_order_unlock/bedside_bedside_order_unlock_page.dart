import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/constant/theme_colors.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_order_unlock_list_model.dart';
import 'package:binance_game_app/model/list_table_column_model.dart';
import 'package:binance_game_app/model/search_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_order_unlock/bedside_bedside_order_unlock_view_model.dart';
import 'package:binance_game_app/view_model/enums/enum_view_model.dart';
import 'package:binance_game_app/widget/list_circle_checkbox.dart';
import 'package:binance_game_app/widget/list_click_text_button.dart';
import 'package:binance_game_app/widget/list_search_text_field.dart';
import 'package:binance_game_app/widget/list_select.dart';
import 'package:binance_game_app/widget/list_table_column.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideOrderUnlockPage extends StatelessWidget {

  static const routeName = '/bedsideorderunlockPage';


  String number;


  BedsideBedsideOrderUnlockPage({this.number});

  BedsideBedsideOrderUnlockViewModel _bedsideBedsideOrderUnlockViewModel = BedsideBedsideOrderUnlockViewModel();

  final TextEditingController searchController = TextEditingController();

  List<SearchModel> searchList = [
    SearchModel(key: 1,value: "设备编号",param: "number"),
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
            _bedsideBedsideOrderUnlockViewModel.scrollController.animateTo(-10.h, duration: Duration(milliseconds: 500), curve: Curves.linear);
          },
          child: Text("设备开锁记录",)
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
                            child: ListSelect(topHeight: preferredSizeHeight,list: model.enumAllModel.orderUnlockStatus,onChange: (value){
                              if (model.enumAllModel.orderUnlockStatus[value].getKey() == null) {
                                searchParam.remove(model.enumAllModel.orderUnlockStatus[value].getParam());
                              }else {
                                searchParam[model.enumAllModel.orderUnlockStatus[value].getParam()] = model.enumAllModel.orderUnlockStatus[value].getKey();
                              }
                            },),
                          ),
                          Expanded(
                            child: ListSelect(topHeight: preferredSizeHeight,list: model.enumAllModel.orderUnlockType,onChange: (value){
                              if (model.enumAllModel.orderUnlockType[value].getKey() == null) {
                                searchParam.remove(model.enumAllModel.orderUnlockType[value].getParam());
                              }else {
                                searchParam[model.enumAllModel.orderUnlockType[value].getParam()] = model.enumAllModel.orderUnlockType[value].getKey();
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
            viewModel: _bedsideBedsideOrderUnlockViewModel,
            init: (BedsideBedsideOrderUnlockViewModel model) {
              if(number == null) {
                model.initBedsideBedsideOrderUnlockList();
              }else {
                searchController.text = number;
                this.refreshList();
              }
            },
            builder: (c,BedsideBedsideOrderUnlockViewModel model, _) {
              if(model.loading && model.bedsideBedsideOrderUnlockListModelDatas.isEmpty) {
                return Center(child: CupertinoActivityIndicator());
              }
              return ListView.builder(
                itemCount: model.bedsideBedsideOrderUnlockListModelDatas.length + 1,
                controller: model.scrollController,
                padding: EdgeInsets.only(bottom: 45.h),
                itemBuilder: (BuildContext context, int index){
                  if((model.totalCount == model.bedsideBedsideOrderUnlockListModelDatas.length || model.currPage == model.totalPage) && index == model.bedsideBedsideOrderUnlockListModelDatas.length) {
                    return Center(
                      child: Text("没有更多数据了",
                        style: Theme.of(context).textTheme.headline2.copyWith(
                          color: ThemeColors.COLOR_BDBDBD
                        ),
                      ),
                    );
                  } else if(index == model.bedsideBedsideOrderUnlockListModelDatas.length) {
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
                                check: model.ids.contains(model.bedsideBedsideOrderUnlockListModelDatas[index].id),
                                onChanged: (value) {
                                  if(value) {
                                    model.ids.add(model.bedsideBedsideOrderUnlockListModelDatas[index].id);
                                  }else {
                                    model.ids.remove(model.bedsideBedsideOrderUnlockListModelDatas[index].id);
                                  }
                                },
                              ),
                              SizedBox(width: 9.w,),
                              ListTableColumn(
                                dataList: [
                                  ListTableColumnModel(key: "订单号：",value: model.bedsideBedsideOrderUnlockListModelDatas[index].orderSn),
                                  ListTableColumnModel(key: "二维码编号：",value: model.bedsideBedsideOrderUnlockListModelDatas[index].number),
                                  ListTableColumnModel(key: "用户唯一标识：",value: model.bedsideBedsideOrderUnlockListModelDatas[index].openid),
                                  ListTableColumnModel(key: "开锁状态",value: model.bedsideBedsideOrderUnlockListModelDatas[index].statusStr.toString()),
                                  ListTableColumnModel(key: "开锁方式",value: model.bedsideBedsideOrderUnlockListModelDatas[index].typeStr.toString()),
                                  ListTableColumnModel(key: "使用时长（秒）：",value: model.bedsideBedsideOrderUnlockListModelDatas[index].time.toString()),
                                  ListTableColumnModel(key: "消费金额：",value: model.bedsideBedsideOrderUnlockListModelDatas[index].money.toString()),
                                  ListTableColumnModel(key: "指令内容",value: model.bedsideBedsideOrderUnlockListModelDatas[index].content),
                                  ListTableColumnModel(key: "发起开锁时间：",value: model.bedsideBedsideOrderUnlockListModelDatas[index].createdAt),
                                  ListTableColumnModel(key: "命令下发时间：",value: model.bedsideBedsideOrderUnlockListModelDatas[index].sendAt),
                                  ListTableColumnModel(key: "实际开锁时间：",value: model.bedsideBedsideOrderUnlockListModelDatas[index].startAt),
                                  ListTableColumnModel(key: "关锁时间：",value: model.bedsideBedsideOrderUnlockListModelDatas[index].endAt),
                                  ListTableColumnModel(key: "规定关锁时间",value: model.bedsideBedsideOrderUnlockListModelDatas[index].usertimEndAt),
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


  delHandler(BuildContext context,BedsideBedsideOrderUnlockListModelData data,int index) {

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
                _bedsideBedsideOrderUnlockViewModel.bedsideBedsideOrderUnlockDelete(index, [data.id],success: (value) {
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
                _bedsideBedsideOrderUnlockViewModel.bedsideBedsideOrderUnlockDelete(index, [data.id],success: (value) {
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
                    _bedsideBedsideOrderUnlockViewModel.bedsideBedsideOrderUnlockDeleteSelect(ids,success: (value) {
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
                    _bedsideBedsideOrderUnlockViewModel.bedsideBedsideOrderUnlockDeleteSelect(ids,success: (value) {
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
    if(searchController.text.isEmpty) {
      searchParam.remove(searchList[currentSearchListIndex].getParam());
    }else if(searchController.text.isNotEmpty) {
      searchParam[searchList[currentSearchListIndex].getParam()] = searchController.text;
    }
    _bedsideBedsideOrderUnlockViewModel.defaultData();
    _bedsideBedsideOrderUnlockViewModel.initBedsideBedsideOrderUnlockList(param: searchParam);
  }
}
