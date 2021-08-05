import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/constant/theme_colors.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_table_repairs_list_model.dart';
import 'package:binance_game_app/model/list_table_column_model.dart';
import 'package:binance_game_app/model/search_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_table_repairs/bedside_bedside_table_repairs_view_model.dart';
import 'package:binance_game_app/view_model/enums/enum_view_model.dart';
import 'package:binance_game_app/widget/list_circle_checkbox.dart';
import 'package:binance_game_app/widget/list_click_text_button.dart';
import 'package:binance_game_app/widget/list_search_text_field.dart';
import 'package:binance_game_app/widget/list_select.dart';
import 'package:binance_game_app/widget/list_table_column.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideTableRepairsPage extends StatelessWidget {

  static const routeName = '/bedsidetablerepairsPage';


  BedsideBedsideTableRepairsPage() {
    print("print");
  }

  BedsideBedsideTableRepairsViewModel _bedsideBedsideTableRepairsViewModel = BedsideBedsideTableRepairsViewModel();

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
            _bedsideBedsideTableRepairsViewModel.scrollController.animateTo(-10.h, duration: Duration(milliseconds: 500), curve: Curves.linear);
          },
          child: Text("床头柜报修记录表",)
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
                            child: ListSelect(topHeight: preferredSizeHeight,list: model.enumAllModel.tableRepairsStatus,onChange: (value){
                              if (model.enumAllModel.tableRepairsStatus[value].getKey() == null) {
                                searchParam.remove(model.enumAllModel.tableRepairsStatus[value].getParam());
                              }else {
                                searchParam[model.enumAllModel.tableRepairsStatus[value].getParam()] = model.enumAllModel.tableRepairsStatus[value].getKey();
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
            viewModel: _bedsideBedsideTableRepairsViewModel,
            init: (BedsideBedsideTableRepairsViewModel model) {
              model.initBedsideBedsideTableRepairsList();
            },
            builder: (c,BedsideBedsideTableRepairsViewModel model, _) {
              if(model.loading && model.bedsideBedsideTableRepairsListModelDatas.isEmpty) {
                return Center(child: CupertinoActivityIndicator());
              }
              return ListView.builder(
                itemCount: model.bedsideBedsideTableRepairsListModelDatas.length + 1,
                controller: model.scrollController,
                padding: EdgeInsets.only(bottom: 45.h),
                itemBuilder: (BuildContext context, int index){
                  if((model.totalCount == model.bedsideBedsideTableRepairsListModelDatas.length || model.currPage == model.totalPage) && index == model.bedsideBedsideTableRepairsListModelDatas.length) {
                    return Center(
                      child: Text("没有更多数据了",
                        style: Theme.of(context).textTheme.headline2.copyWith(
                          color: ThemeColors.COLOR_BDBDBD
                        ),
                      ),
                    );
                  } else if(index == model.bedsideBedsideTableRepairsListModelDatas.length) {
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
                                check: model.ids.contains(model.bedsideBedsideTableRepairsListModelDatas[index].id),
                                onChanged: (value) {
                                  if(value) {
                                    model.ids.add(model.bedsideBedsideTableRepairsListModelDatas[index].id);
                                  }else {
                                    model.ids.remove(model.bedsideBedsideTableRepairsListModelDatas[index].id);
                                  }
                                },
                              ),
                              SizedBox(width: 9.w,),
                              ListTableColumn(
                                dataList: [
                                  ListTableColumnModel(key: "设备编号",value: model.bedsideBedsideTableRepairsListModelDatas[index].number.toString()),
                                  ListTableColumnModel(key: "用户",value: model.bedsideBedsideTableRepairsListModelDatas[index].openid),
                                  ListTableColumnModel(key: "运维",value: model.bedsideBedsideTableRepairsListModelDatas[index].opsName.toString()),
                                  ListTableColumnModel(key: "医院",value: model.bedsideBedsideTableRepairsListModelDatas[index].hospitalName.toString()),
                                  ListTableColumnModel(key: "科室",value: model.bedsideBedsideTableRepairsListModelDatas[index].officeName.toString()),
                                  ListTableColumnModel(key: "房间",value: model.bedsideBedsideTableRepairsListModelDatas[index].roomName.toString()),
                                  ListTableColumnModel(key: "报修内容：",value: model.bedsideBedsideTableRepairsListModelDatas[index].content),
                                  ListTableColumnModel(key: "图片：",value: "查看图片",onTab: () {
                                    showImageList(context, model, index);
                                  }),
                                  ListTableColumnModel(key: "来源",value: model.bedsideBedsideTableRepairsListModelDatas[index].typeStr.toString()),
                                  ListTableColumnModel(key: "订单编号",value: model.bedsideBedsideTableRepairsListModelDatas[index].orderSn.toString()),
                                  ListTableColumnModel(key: "退款金额",value: model.bedsideBedsideTableRepairsListModelDatas[index].refundMoney.toString()),
                                  ListTableColumnModel(key: "设备状态",value: model.bedsideBedsideTableRepairsListModelDatas[index].tableStatusStr.toString()),

                                  ListTableColumnModel(key: "状态",value: model.bedsideBedsideTableRepairsListModelDatas[index].statusStr.toString()),

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
                                  offstage: model.bedsideBedsideTableRepairsListModelDatas[index].status != 1,
                                  child: ListClickTextButton("工单指派",onPressed: () {
                                    Navigator.pushNamed(context,"${BedsideBedsideTableRepairsPage.routeName.replaceFirst("Page", "SaveOrUpadtePage")}",arguments: SaveOrUpdateDto(
                                      index: index,
                                      titleStr: "修改",
                                      id: model.bedsideBedsideTableRepairsListModelDatas[index].id,
                                      callback: (data) {
                                        refreshList();
                                      }
                                    ));
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

  void showImageList(BuildContext context, BedsideBedsideTableRepairsViewModel model, int index) {
    if(model.bedsideBedsideTableRepairsListModelDatas[index].getImaList().isEmpty) {
      EasyLoading.showToast("用户没有上传图片");
      return;
    }

    showGeneralDialog(
        context: context,
        barrierDismissible:true,
        barrierLabel: '',
        barrierColor: Colors.black,
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Center(
            child: Container(
              width: 300.w,
              height: 500.h,
              child: PageView(
                children: <Widget>[
                  for(var value in model.bedsideBedsideTableRepairsListModelDatas[index].getImaList())
                    Image.network(value,width: 375.w,fit: BoxFit.cover,)
                ],
              ),
            ),
          );
        });
  }


  delHandler(BuildContext context,BedsideBedsideTableRepairsListModelData data,int index) {

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
                _bedsideBedsideTableRepairsViewModel.bedsideBedsideTableRepairsDelete(index, [data.id],success: (value) {
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
                _bedsideBedsideTableRepairsViewModel.bedsideBedsideTableRepairsDelete(index, [data.id],success: (value) {
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
                    _bedsideBedsideTableRepairsViewModel.bedsideBedsideTableRepairsDeleteSelect(ids,success: (value) {
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
                    _bedsideBedsideTableRepairsViewModel.bedsideBedsideTableRepairsDeleteSelect(ids,success: (value) {
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
    _bedsideBedsideTableRepairsViewModel.defaultData();
    _bedsideBedsideTableRepairsViewModel.initBedsideBedsideTableRepairsList(param: searchParam);
  }
}
