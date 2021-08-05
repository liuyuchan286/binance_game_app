import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/constant/theme_colors.dart';
import 'package:binance_game_app/model/bedside_bedside_order_list_model.dart';
import 'package:binance_game_app/model/list_table_column_model.dart';
import 'package:binance_game_app/model/search_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_hospital_select/bedside_bedside_hospital_select_view_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_order/bedside_bedside_order_view_model.dart';
import 'package:binance_game_app/view_model/enums/enum_view_model.dart';
import 'package:binance_game_app/widget/list_circle_checkbox.dart';
import 'package:binance_game_app/widget/list_click_text_button.dart';
import 'package:binance_game_app/widget/list_search_text_field.dart';
import 'package:binance_game_app/widget/list_select.dart';
import 'package:binance_game_app/widget/list_table_column.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideOrderPage extends StatelessWidget {

  static const routeName = '/bedsideorderPage';


  DateTimeRange _range;

  BedsideBedsideOrderPage() {
    print("print");
  }

  BedsideBedsideOrderViewModel _bedsideBedsideOrderViewModel = BedsideBedsideOrderViewModel();

  final TextEditingController searchController = TextEditingController();

  List<SearchModel> searchList = [
    SearchModel(key: 1,value: "手机号码",param: "phoneNumber"),
    SearchModel(key: 2,value: "设备编号",param: "number"),
    SearchModel(key: 2,value: "订单号码",param: "orderSn"),
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
            _bedsideBedsideOrderViewModel.scrollController.animateTo(-10.h, duration: Duration(milliseconds: 500), curve: Curves.linear);
          },
          child: Text("订单记录表",)
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
                        searchParam[searchList[currentSearchListIndex].getParam()] = searchController.text;
                      },),
                      SizedBox(width: 8.w,),
                      ListSearchTextField(
                        width: 190.w,
                        controller: searchController,
                        onTap: () {
                          refreshList();
                        },
                      ),
                      SizedBox(width: 15.w,),
                      GestureDetector(
                        onTap: () async {
                          DateTimeRange range = await showDateRangePicker(
                            context: context,
                            firstDate: DateTime(DateTime.now().year - 10),
                            lastDate: DateTime.now(),
                            initialDateRange: _range,
                            saveText: "确定",
                          );
                          _range = range;
                          print(range.start);
                          print(range.end);

                          searchParam['startTime'] = range.start.toString();
                          searchParam['endTime'] = range.end.toString();

                        },
                        child: Image.asset("assets/images/date-icon.png",
                          width: 22.w,
                          height: 22.h,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: preferredSizeBoxh,),

                Row(
                  children: [
                    Expanded(
                      child: ProviderWidget(
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
                            child: ListSelect(topHeight: preferredSizeHeight,list: model.enumAllModel.orderStatus,onChange: (value){
                              if (model.enumAllModel.orderStatus[value].getKey() == null) {
                                searchParam.remove(model.enumAllModel.orderStatus[value].getParam());
                              }else {
                                searchParam[model.enumAllModel.orderStatus[value].getParam()] = model.enumAllModel.orderStatus[value].getKey();
                              }
                            }),
                          );
                        },
                      ),
                    ),

                    Expanded(
                      child: ProviderWidget(
                        viewModel: BedsideBedsideHospitalSelectViewModel(),
                        init: (BedsideBedsideHospitalSelectViewModel model) {
                          model.bedsideBedsideHospitalListAll();
                        },
                        builder: (c,BedsideBedsideHospitalSelectViewModel model,_){
                          if (model.loading) {
                            return CupertinoActivityIndicator();
                          }
                          return Container(
                            height: lineHeight,
                            child: ListSelect(topHeight: preferredSizeHeight,list: model.bedsideBedsideHospitalListModelDatas,onChange: (value){
                              if (model.bedsideBedsideHospitalListModelDatas[value].getKey() == null) {
                                searchParam.remove(model.bedsideBedsideHospitalListModelDatas[value].getParam());
                              }else {
                                searchParam[model.bedsideBedsideHospitalListModelDatas[value].getParam()] = model.bedsideBedsideHospitalListModelDatas[value].getKey();
                              }
                            }),
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          ProviderWidget(
            viewModel: _bedsideBedsideOrderViewModel,
            init: (BedsideBedsideOrderViewModel model) {
              model.initBedsideBedsideOrderList();
            },
            builder: (c,BedsideBedsideOrderViewModel model, _) {
              if(model.loading && model.bedsideBedsideOrderListModelDatas.isEmpty) {
                return Center(child: CupertinoActivityIndicator());
              }
              return ListView.builder(
                itemCount: model.bedsideBedsideOrderListModelDatas.length + 1,
                controller: model.scrollController,
                padding: EdgeInsets.only(bottom: 45.h),
                itemBuilder: (BuildContext context, int index){
                  if((model.totalCount == model.bedsideBedsideOrderListModelDatas.length || model.currPage == model.totalPage) && index == model.bedsideBedsideOrderListModelDatas.length) {
                    return Center(
                      child: Text("没有更多数据了",
                        style: Theme.of(context).textTheme.headline2.copyWith(
                          color: ThemeColors.COLOR_BDBDBD
                        ),
                      ),
                    );
                  } else if(index == model.bedsideBedsideOrderListModelDatas.length) {
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
                                check: model.ids.contains(model.bedsideBedsideOrderListModelDatas[index].id),
                                onChanged: (value) {
                                  if(value) {
                                    model.ids.add(model.bedsideBedsideOrderListModelDatas[index].id);
                                  }else {
                                    model.ids.remove(model.bedsideBedsideOrderListModelDatas[index].id);
                                  }
                                },
                              ),
                              SizedBox(width: 9.w,),
                              ListTableColumn(
                                dataList: [
                                  ListTableColumnModel(key: "订单号：",value: model.bedsideBedsideOrderListModelDatas[index].orderSn),
                                  ListTableColumnModel(key: "设备编号",value: model.bedsideBedsideOrderListModelDatas[index].number),
                                  ListTableColumnModel(key: "用户",value: model.bedsideBedsideOrderListModelDatas[index].openid),
                                  ListTableColumnModel(key: "手机号",value: model.bedsideBedsideOrderListModelDatas[index].userPhone),
                                  ListTableColumnModel(key: "医院名称：",value: model.bedsideBedsideOrderListModelDatas[index].hospitalName),
                                  ListTableColumnModel(key: "科室名称：",value: model.bedsideBedsideOrderListModelDatas[index].officeName),
                                  ListTableColumnModel(key: "房间号名称：",value: model.bedsideBedsideOrderListModelDatas[index].roomName),
                                  ListTableColumnModel(key: "床号名称：",value: model.bedsideBedsideOrderListModelDatas[index].bedName),
                                  ListTableColumnModel(key: "使用时长（秒）：",value: model.bedsideBedsideOrderListModelDatas[index].time.toString()),
                                  ListTableColumnModel(key: "消费金额：",value: model.bedsideBedsideOrderListModelDatas[index].money.toString()),
                                  ListTableColumnModel(key: "状态",value: model.bedsideBedsideOrderListModelDatas[index].statusStr.toString()),
                                  ListTableColumnModel(key: "付款方式",value: model.bedsideBedsideOrderListModelDatas[index].payTypeStr.toString()),
                                  ListTableColumnModel(key: "付款时间：",value: model.bedsideBedsideOrderListModelDatas[index].payAt ?? ""),
                                  ListTableColumnModel(key: "退款时间：",value: model.bedsideBedsideOrderListModelDatas[index].refundAt ?? ""),

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
                                  offstage: model.bedsideBedsideOrderListModelDatas[index].status != 2,
                                  child: ListClickTextButton("退款",onPressed: () {
                                    refundHandler(context, model.bedsideBedsideOrderListModelDatas[index],index);
                                  },),
                                ),
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


  delHandler(BuildContext context,BedsideBedsideOrderListModelData data,int index) {

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
                _bedsideBedsideOrderViewModel.bedsideBedsideOrderDelete(index, [data.id],success: (value) {
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
                _bedsideBedsideOrderViewModel.bedsideBedsideOrderDelete(index, [data.id],success: (value) {
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

  refundHandler(BuildContext context,BedsideBedsideOrderListModelData data,int index) {

    if(Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('提示'),
              content: Text('确认退款[${data.id}]吗？'),
              actions: <Widget>[
                FlatButton(child: Text('取消'),onPressed: (){
                  Navigator.pop(context);
                },),
                FlatButton(child: Text('确认'),onPressed: (){
                  Navigator.pop(context);
                  EasyLoading.show(status: "退款中");
                  _bedsideBedsideOrderViewModel.bedsideBedsideOrderRefund(index, data.id,success: (value) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("退款成功");
                  },error: (err) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("退款失败:${err.toString()}");
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
              content: Text('确认退款[${data.id}]吗？'),
              actions: <Widget>[
                CupertinoDialogAction(child: Text('取消'),onPressed: (){
                  Navigator.pop(context);
                },),
                CupertinoDialogAction(child: Text('确认'),onPressed: (){
                  Navigator.pop(context);
                  EasyLoading.show(status: "退款中");
                  _bedsideBedsideOrderViewModel.bedsideBedsideOrderRefund(index, data.id,success: (value) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("退款成功");
                  },error: (err) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("退款失败:${err.toString()}");
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
                    _bedsideBedsideOrderViewModel.bedsideBedsideOrderDeleteSelect(ids,success: (value) {
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
                    _bedsideBedsideOrderViewModel.bedsideBedsideOrderDeleteSelect(ids,success: (value) {
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
    for(SearchModel model in searchList) {
      searchParam.remove(model.getParam());
    }
    searchParam[searchList[currentSearchListIndex].getParam()] = searchController.text;
    _bedsideBedsideOrderViewModel.defaultData();
    _bedsideBedsideOrderViewModel.initBedsideBedsideOrderList(param: searchParam);
  }
}
