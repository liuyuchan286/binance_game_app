import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/constant/theme_colors.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_commission_config_list_model.dart';
import 'package:binance_game_app/model/list_table_column_model.dart';
import 'package:binance_game_app/model/search_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_hospital_commission_config/bedside_bedside_hospital_commission_config_view_model.dart';
import 'package:binance_game_app/widget/list_circle_checkbox.dart';
import 'package:binance_game_app/widget/list_click_text_button.dart';
import 'package:binance_game_app/widget/list_search_text_field.dart';
import 'package:binance_game_app/widget/list_select.dart';
import 'package:binance_game_app/widget/list_table_column.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideHospitalCommissionConfigPage extends StatelessWidget {

  static const routeName = '/bedsidehospitalcommissionconfigPage';


  BedsideBedsideHospitalCommissionConfigPage() {
    print("print");
  }

  BedsideBedsideHospitalCommissionConfigViewModel _bedsideBedsideHospitalCommissionConfigViewModel = BedsideBedsideHospitalCommissionConfigViewModel();

  final TextEditingController searchController = TextEditingController();

  List<SearchModel> searchList = [
    SearchModel(key: 1,value: "医院名称",param: "hospitalName"),
  ];

  Map searchParam = {
  };

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
            _bedsideBedsideHospitalCommissionConfigViewModel.scrollController.animateTo(-10.h, duration: Duration(milliseconds: 500), curve: Curves.linear);
          },
          child: Text("医院分佣配置",)
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
                // SizedBox(height: preferredSizeBoxh,),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          ProviderWidget(
            viewModel: _bedsideBedsideHospitalCommissionConfigViewModel,
            init: (BedsideBedsideHospitalCommissionConfigViewModel model) {
              model.initBedsideBedsideHospitalCommissionConfigList();
            },
            builder: (c,BedsideBedsideHospitalCommissionConfigViewModel model, _) {
              if(model.loading && model.bedsideBedsideHospitalCommissionConfigListModelDatas.isEmpty) {
                return Center(child: CupertinoActivityIndicator());
              }
              return ListView.builder(
                itemCount: model.bedsideBedsideHospitalCommissionConfigListModelDatas.length + 1,
                controller: model.scrollController,
                padding: EdgeInsets.only(bottom: 45.h),
                itemBuilder: (BuildContext context, int index){
                  if((model.totalCount == model.bedsideBedsideHospitalCommissionConfigListModelDatas.length || model.currPage == model.totalPage) && index == model.bedsideBedsideHospitalCommissionConfigListModelDatas.length) {
                    return Center(
                      child: Text("没有更多数据了",
                        style: Theme.of(context).textTheme.headline2.copyWith(
                          color: ThemeColors.COLOR_BDBDBD
                        ),
                      ),
                    );
                  } else if(index == model.bedsideBedsideHospitalCommissionConfigListModelDatas.length) {
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
                                check: model.ids.contains(model.bedsideBedsideHospitalCommissionConfigListModelDatas[index].id),
                                onChanged: (value) {
                                  if(value) {
                                    model.ids.add(model.bedsideBedsideHospitalCommissionConfigListModelDatas[index].id);
                                  }else {
                                    model.ids.remove(model.bedsideBedsideHospitalCommissionConfigListModelDatas[index].id);
                                  }
                                },
                              ),
                              SizedBox(width: 9.w,),
                              ListTableColumn(
                                dataList: [
                                  ListTableColumnModel(key: "医院名称：",value: model.bedsideBedsideHospitalCommissionConfigListModelDatas[index].hospitalName),
                                  ListTableColumnModel(key: "分佣比例：",value: model.bedsideBedsideHospitalCommissionConfigListModelDatas[index].commissionRatio.toString()),
                                  ListTableColumnModel(key: "延迟到账：",value: model.bedsideBedsideHospitalCommissionConfigListModelDatas[index].lateArrival.toString()),
                                  ListTableColumnModel(key: "创建时间：",value: model.bedsideBedsideHospitalCommissionConfigListModelDatas[index].createdAt),
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
                                ListClickTextButton("修改",onPressed: () {
                                  Navigator.pushNamed(context,"${BedsideBedsideHospitalCommissionConfigPage.routeName.replaceFirst("Page", "SaveOrUpadtePage")}",arguments: SaveOrUpdateDto(
                                    index: index,
                                    titleStr: "修改",
                                    id: model.bedsideBedsideHospitalCommissionConfigListModelDatas[index].id,
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


  delHandler(BuildContext context,BedsideBedsideHospitalCommissionConfigListModelData data,int index) {

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
                _bedsideBedsideHospitalCommissionConfigViewModel.bedsideBedsideHospitalCommissionConfigDelete(index, [data.id],success: (value) {
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
                _bedsideBedsideHospitalCommissionConfigViewModel.bedsideBedsideHospitalCommissionConfigDelete(index, [data.id],success: (value) {
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
                    _bedsideBedsideHospitalCommissionConfigViewModel.bedsideBedsideHospitalCommissionConfigDeleteSelect(ids,success: (value) {
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
                    _bedsideBedsideHospitalCommissionConfigViewModel.bedsideBedsideHospitalCommissionConfigDeleteSelect(ids,success: (value) {
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
    _bedsideBedsideHospitalCommissionConfigViewModel.defaultData();
    _bedsideBedsideHospitalCommissionConfigViewModel.initBedsideBedsideHospitalCommissionConfigList(param: searchParam);
  }
}
