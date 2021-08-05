import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/constant/theme_colors.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_daily_statistics_list_model.dart';
import 'package:binance_game_app/model/list_table_column_model.dart';
import 'package:binance_game_app/model/search_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_daily_statistics/bedside_bedside_daily_statistics_view_model.dart';
import 'package:binance_game_app/widget/list_circle_checkbox.dart';
import 'package:binance_game_app/widget/list_click_text_button.dart';
import 'package:binance_game_app/widget/list_search_hospital_select.dart';
import 'package:binance_game_app/widget/list_search_text_field.dart';
import 'package:binance_game_app/widget/list_select.dart';
import 'package:binance_game_app/widget/list_table_column.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideDailyStatisticsPage extends StatelessWidget {

  static const routeName = '/bedsidedailystatisticsPage';


  BedsideBedsideDailyStatisticsPage() {
    print("print");
  }

  BedsideBedsideDailyStatisticsViewModel _bedsideBedsideDailyStatisticsViewModel = BedsideBedsideDailyStatisticsViewModel();

  final TextEditingController searchController = TextEditingController();
  DateTimeRange _range;
  List<SearchModel> searchList = [
    SearchModel(key: 1,value: "参数名",param: "name"),
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
            _bedsideBedsideDailyStatisticsViewModel.scrollController.animateTo(-10.h, duration: Duration(milliseconds: 500), curve: Curves.linear);
          },
          child: Text("每日统计表",)
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
                      ),
                    ],
                  ),
                ),
                SizedBox(height: preferredSizeBoxh,),
                ListSearchHospitalSelect(lineHeight: lineHeight, preferredSizeBoxh: preferredSizeBoxh, searchParam: searchParam,topHeight: preferredSizeHeight,),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          ProviderWidget(
            viewModel: _bedsideBedsideDailyStatisticsViewModel,
            init: (BedsideBedsideDailyStatisticsViewModel model) {
              model.initBedsideBedsideDailyStatisticsList();
            },
            builder: (c,BedsideBedsideDailyStatisticsViewModel model, _) {
              if(model.loading && model.bedsideBedsideDailyStatisticsListModelDatas.isEmpty) {
                return Center(child: CupertinoActivityIndicator());
              }
              return ListView.builder(
                itemCount: model.bedsideBedsideDailyStatisticsListModelDatas.length + 1,
                controller: model.scrollController,
                padding: EdgeInsets.only(bottom: 45.h),
                itemBuilder: (BuildContext context, int index){
                  if((model.totalCount == model.bedsideBedsideDailyStatisticsListModelDatas.length || model.currPage == model.totalPage) && index == model.bedsideBedsideDailyStatisticsListModelDatas.length) {
                    return Center(
                      child: Text("没有更多数据了",
                        style: Theme.of(context).textTheme.headline2.copyWith(
                          color: ThemeColors.COLOR_BDBDBD
                        ),
                      ),
                    );
                  } else if(index == model.bedsideBedsideDailyStatisticsListModelDatas.length) {
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
                                check: model.ids.contains(model.bedsideBedsideDailyStatisticsListModelDatas[index].id),
                                onChanged: (value) {
                                  if(value) {
                                    model.ids.add(model.bedsideBedsideDailyStatisticsListModelDatas[index].id);
                                  }else {
                                    model.ids.remove(model.bedsideBedsideDailyStatisticsListModelDatas[index].id);
                                  }
                                },
                              ),
                              SizedBox(width: 9.w,),
                              ListTableColumn(
                                dataList: [
                                  ListTableColumnModel(key: "日期：",value: model.bedsideBedsideDailyStatisticsListModelDatas[index].date),
                                  ListTableColumnModel(key: "订单数量：",value: model.bedsideBedsideDailyStatisticsListModelDatas[index].ordersCount.toString()),
                                  ListTableColumnModel(key: "按天：",value: model.bedsideBedsideDailyStatisticsListModelDatas[index].money0.toString()),
                                  ListTableColumnModel(key: "押金按时：",value: model.bedsideBedsideDailyStatisticsListModelDatas[index].money1.toString()),
                                  ListTableColumnModel(key: "时间包段收费：",value: model.bedsideBedsideDailyStatisticsListModelDatas[index].money2.toString()),
                                  ListTableColumnModel(key: "押金按天：",value: model.bedsideBedsideDailyStatisticsListModelDatas[index].money3.toString()),
                                  ListTableColumnModel(key: "退款：",value: model.bedsideBedsideDailyStatisticsListModelDatas[index].refundMonty.toString()),
                                  ListTableColumnModel(key: "使用数量：",value: model.bedsideBedsideDailyStatisticsListModelDatas[index].useCount.toString()),
                                  ListTableColumnModel(key: "使用中数量：",value: model.bedsideBedsideDailyStatisticsListModelDatas[index].countInUse.toString()),
                                  ListTableColumnModel(key: "开锁次数：",value: model.bedsideBedsideDailyStatisticsListModelDatas[index].unlocksCount.toString()),
                                  ListTableColumnModel(key: "设备总数量：",value: model.bedsideBedsideDailyStatisticsListModelDatas[index].tableTotalCount.toString()),
                                  ListTableColumnModel(key: "医院名称：",value: model.bedsideBedsideDailyStatisticsListModelDatas[index].hospitalName ?? ""),
                                  ListTableColumnModel(key: "科室名称：",value: model.bedsideBedsideDailyStatisticsListModelDatas[index].officeName ?? ""),
                                  ListTableColumnModel(key: "房间号名称：",value: model.bedsideBedsideDailyStatisticsListModelDatas[index].roomName ?? ""),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 16.h,),
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


  delHandler(BuildContext context,BedsideBedsideDailyStatisticsListModelData data,int index) {

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
                _bedsideBedsideDailyStatisticsViewModel.bedsideBedsideDailyStatisticsDelete(index, [data.id],success: (value) {
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
                _bedsideBedsideDailyStatisticsViewModel.bedsideBedsideDailyStatisticsDelete(index, [data.id],success: (value) {
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
                    _bedsideBedsideDailyStatisticsViewModel.bedsideBedsideDailyStatisticsDeleteSelect(ids,success: (value) {
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
                    _bedsideBedsideDailyStatisticsViewModel.bedsideBedsideDailyStatisticsDeleteSelect(ids,success: (value) {
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
    _bedsideBedsideDailyStatisticsViewModel.defaultData();
    _bedsideBedsideDailyStatisticsViewModel.initBedsideBedsideDailyStatisticsList(param: searchParam);
  }
}
