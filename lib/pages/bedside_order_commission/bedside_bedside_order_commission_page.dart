import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/constant/theme_colors.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_order_commission_list_model.dart';
import 'package:binance_game_app/model/list_table_column_model.dart';
import 'package:binance_game_app/model/search_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_hospital_select/bedside_bedside_hospital_select_view_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_order_commission/bedside_bedside_order_commission_view_model.dart';
import 'package:binance_game_app/view_model/enums/enum_view_model.dart';
import 'package:binance_game_app/widget/list_circle_checkbox.dart';
import 'package:binance_game_app/widget/list_click_text_button.dart';
import 'package:binance_game_app/widget/list_search_text_field.dart';
import 'package:binance_game_app/widget/list_select.dart';
import 'package:binance_game_app/widget/list_table_column.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideOrderCommissionPage extends StatelessWidget {

  static const routeName = '/bedsideordercommissionPage';


  BedsideBedsideOrderCommissionPage() {
    print("print");
  }

  BedsideBedsideOrderCommissionViewModel _bedsideBedsideOrderCommissionViewModel = BedsideBedsideOrderCommissionViewModel();

  final TextEditingController searchController = TextEditingController();

  List<SearchModel> searchList = [
    SearchModel(key: 1,value: "订单编号",param: "orderSn"),
  ];

  Map searchParam = {
  };

  int currentSearchListIndex = 0;

  final double lineHeight = 30.h;
  final double preferredSizeBoxh = 15.h;
  bool check = false;
  //日期
  DateTimeRange _range;
  @override
  Widget build(BuildContext context) {
    double preferredSizeHeight = (lineHeight + preferredSizeBoxh) * 2;

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onDoubleTap: () {
            _bedsideBedsideOrderCommissionViewModel.scrollController.animateTo(-10.h, duration: Duration(milliseconds: 500), curve: Curves.linear);
          },
          child: Text("订单分佣",)
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
                        width: 180.w,
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
                            lastDate: DateTime(DateTime.now().year + 1),
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
                            child: ListSelect(topHeight: preferredSizeHeight,list: model.enumAllModel.commissionStatus,onChange: (value){
                              print(value);
                              if (model.enumAllModel.commissionStatus[value].getKey() == null) {
                                searchParam.remove(model.enumAllModel.commissionStatus[value].getParam());
                              }else {
                                searchParam[model.enumAllModel.commissionStatus[value].getParam()] = model.enumAllModel.commissionStatus[value].getKey();
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
            viewModel: _bedsideBedsideOrderCommissionViewModel,
            init: (BedsideBedsideOrderCommissionViewModel model) {
              model.initBedsideBedsideOrderCommissionList();
            },
            builder: (c,BedsideBedsideOrderCommissionViewModel model, _) {
              if(model.loading && model.bedsideBedsideOrderCommissionListModelDatas.isEmpty) {
                return Center(child: CupertinoActivityIndicator());
              }
              return ListView.builder(
                itemCount: model.bedsideBedsideOrderCommissionListModelDatas.length + 1,
                controller: model.scrollController,
                padding: EdgeInsets.only(bottom: 45.h),
                itemBuilder: (BuildContext context, int index){
                  if((model.totalCount == model.bedsideBedsideOrderCommissionListModelDatas.length || model.currPage == model.totalPage) && index == model.bedsideBedsideOrderCommissionListModelDatas.length) {
                    return Center(
                      child: Text("没有更多数据了",
                        style: Theme.of(context).textTheme.headline2.copyWith(
                          color: ThemeColors.COLOR_BDBDBD
                        ),
                      ),
                    );
                  } else if(index == model.bedsideBedsideOrderCommissionListModelDatas.length) {
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
                                check: model.ids.contains(model.bedsideBedsideOrderCommissionListModelDatas[index].id),
                                onChanged: (value) {
                                  if(value) {
                                    model.ids.add(model.bedsideBedsideOrderCommissionListModelDatas[index].id);
                                  }else {
                                    model.ids.remove(model.bedsideBedsideOrderCommissionListModelDatas[index].id);
                                  }
                                },
                              ),
                              SizedBox(width: 9.w,),
                              ListTableColumn(
                                dataList: [
                                  ListTableColumnModel(key: "订单编号：",value: model.bedsideBedsideOrderCommissionListModelDatas[index].orderSn),
                                  ListTableColumnModel(key: "医院名称：",value: model.bedsideBedsideOrderCommissionListModelDatas[index].hospitalName),
                                  ListTableColumnModel(key: "用户支付：",value: model.bedsideBedsideOrderCommissionListModelDatas[index].userMoney.toString()),
                                  ListTableColumnModel(key: "微信到账：",value: model.bedsideBedsideOrderCommissionListModelDatas[index].wechatMoney.toString()),
                                  ListTableColumnModel(key: "代理费名称：",value: model.bedsideBedsideOrderCommissionListModelDatas[index].agentName),
                                  ListTableColumnModel(key: "佣金比例：",value: model.bedsideBedsideOrderCommissionListModelDatas[index].commissionRatio.toString()),
                                  ListTableColumnModel(key: "资源方金额：",value: model.bedsideBedsideOrderCommissionListModelDatas[index].agentMoney.toString()),
                                  ListTableColumnModel(key: "我方金额：",value: model.bedsideBedsideOrderCommissionListModelDatas[index].ourMoney.toString()),
                                  ListTableColumnModel(key: "订单完成时间：",value: model.bedsideBedsideOrderCommissionListModelDatas[index].orderCompletionTime),
                                  ListTableColumnModel(key: "转为审核时间：",value: model.bedsideBedsideOrderCommissionListModelDatas[index].toReviewTime),
                                  ListTableColumnModel(key: "审核时间：",value: model.bedsideBedsideOrderCommissionListModelDatas[index].reviewTime),
                                  ListTableColumnModel(key: "转为提现时间：",value: model.bedsideBedsideOrderCommissionListModelDatas[index].toWithdrawalTime),
                                  ListTableColumnModel(key: "状态：",value: model.bedsideBedsideOrderCommissionListModelDatas[index].statusStr.toString()),
                                  ListTableColumnModel(key: "备注：",value: model.bedsideBedsideOrderCommissionListModelDatas[index].remarks),
                                  ListTableColumnModel(key: "创建时间：",value: model.bedsideBedsideOrderCommissionListModelDatas[index].createdAt),
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
                                ListClickTextButton("备注",onPressed: () {
                                  Navigator.pushNamed(context,"${BedsideBedsideOrderCommissionPage.routeName.replaceFirst("Page", "SaveOrUpadtePage")}",arguments: SaveOrUpdateDto(
                                    index: index,
                                    titleStr: "备注",
                                    id: model.bedsideBedsideOrderCommissionListModelDatas[index].id,
                                    callback: (data) {
                                      model.refreshList(data, index);
                                    }
                                  ));
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
        ],
      ),
    );
  }


  delHandler(BuildContext context,BedsideBedsideOrderCommissionListModelData data,int index) {

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
                _bedsideBedsideOrderCommissionViewModel.bedsideBedsideOrderCommissionDelete(index, [data.id],success: (value) {
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
                _bedsideBedsideOrderCommissionViewModel.bedsideBedsideOrderCommissionDelete(index, [data.id],success: (value) {
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
                    _bedsideBedsideOrderCommissionViewModel.bedsideBedsideOrderCommissionDeleteSelect(ids,success: (value) {
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
                    _bedsideBedsideOrderCommissionViewModel.bedsideBedsideOrderCommissionDeleteSelect(ids,success: (value) {
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
    _bedsideBedsideOrderCommissionViewModel.defaultData();
    _bedsideBedsideOrderCommissionViewModel.initBedsideBedsideOrderCommissionList(param: searchParam);
  }
}
