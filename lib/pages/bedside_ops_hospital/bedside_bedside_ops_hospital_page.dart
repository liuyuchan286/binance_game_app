import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/constant/theme_colors.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_ops_hospital_list_model.dart';
import 'package:binance_game_app/model/list_table_column_model.dart';
import 'package:binance_game_app/model/search_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_ops_hospital/bedside_bedside_ops_hospital_view_model.dart';
import 'package:binance_game_app/widget/list_circle_checkbox.dart';
import 'package:binance_game_app/widget/list_click_text_button.dart';
import 'package:binance_game_app/widget/list_search_text_field.dart';
import 'package:binance_game_app/widget/list_select.dart';
import 'package:binance_game_app/widget/list_table_column.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideOpsHospitalPage extends StatelessWidget {

  static const routeName = '/bedsideopshospitalPage';


  BedsideBedsideOpsHospitalPage() {
    print("print");
  }

  BedsideBedsideOpsHospitalViewModel _bedsideBedsideOpsHospitalViewModel = BedsideBedsideOpsHospitalViewModel();

  final TextEditingController searchController = TextEditingController();

  List<SearchModel> searchList = [
    SearchModel(key: 1,value: "人员名称",param: "name"),
    SearchModel(key: 2,value: "手机号  ",param: "phone"),
  ];

  Map searchParam = {
  };

  int currentSearchListIndex = 0;

  final double lineHeight = 30.h;
  final double preferredSizeBoxh = 15.h;
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onDoubleTap: () {
            _bedsideBedsideOpsHospitalViewModel.scrollController.animateTo(-10.h, duration: Duration(milliseconds: 500), curve: Curves.linear);
          },
          child: Text("运维人员-医院记录表",)
        ),
        bottom: PreferredSize(
          preferredSize: Size(double.infinity,lineHeight + preferredSizeBoxh),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: preferredSizeBoxh,horizontal: 15.w),
            child: Column(
              children: [
                Container(
                  height: lineHeight,
                  child: Row(
                    children: [
                      ListSelect(topHeight: lineHeight * 2 + preferredSizeBoxh,list: searchList,onChange: (value){
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
            viewModel: _bedsideBedsideOpsHospitalViewModel,
            init: (BedsideBedsideOpsHospitalViewModel model) {
              model.initBedsideBedsideOpsHospitalList();
            },
            builder: (c,BedsideBedsideOpsHospitalViewModel model, _) {
              if(model.loading && model.bedsideBedsideOpsHospitalListModelDatas.isEmpty) {
                return Center(child: CupertinoActivityIndicator());
              }
              return ListView.builder(
                itemCount: model.bedsideBedsideOpsHospitalListModelDatas.length + 1,
                controller: model.scrollController,
                padding: EdgeInsets.only(bottom: 45.h),
                itemBuilder: (BuildContext context, int index){
                  if((model.totalCount == model.bedsideBedsideOpsHospitalListModelDatas.length || model.currPage == model.totalPage) && index == model.bedsideBedsideOpsHospitalListModelDatas.length) {
                    return Center(
                      child: Text("没有更多数据了",
                        style: Theme.of(context).textTheme.headline2.copyWith(
                          color: ThemeColors.COLOR_BDBDBD
                        ),
                      ),
                    );
                  } else if(index == model.bedsideBedsideOpsHospitalListModelDatas.length) {
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
                                check: model.ids.contains(model.bedsideBedsideOpsHospitalListModelDatas[index].id),
                                onChanged: (value) {
                                  if(value) {
                                    model.ids.add(model.bedsideBedsideOpsHospitalListModelDatas[index].id);
                                  }else {
                                    model.ids.remove(model.bedsideBedsideOpsHospitalListModelDatas[index].id);
                                  }
                                },
                              ),
                              SizedBox(width: 9.w,),
                              ListTableColumn(
                                dataList: [
                                  ListTableColumnModel(key: "运维人员ID：",value: model.bedsideBedsideOpsHospitalListModelDatas[index].opsId.toString()),
                                  ListTableColumnModel(key: "医院ID：",value: model.bedsideBedsideOpsHospitalListModelDatas[index].hospitalId.toString()),
                                  ListTableColumnModel(key: "：",value: model.bedsideBedsideOpsHospitalListModelDatas[index].createdAt),
                                  ListTableColumnModel(key: "：",value: model.bedsideBedsideOpsHospitalListModelDatas[index].updatedAt),
                                  ListTableColumnModel(key: "是否自动推送：",value: model.bedsideBedsideOpsHospitalListModelDatas[index].autoPush.toString()),
                                  ListTableColumnModel(key: "自动派单：",value: model.bedsideBedsideOpsHospitalListModelDatas[index].autoAssign.toString()),
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
                                  Navigator.pushNamed(context,"${BedsideBedsideOpsHospitalPage.routeName.replaceFirst("Page", "SaveOrUpadtePage")}",arguments: SaveOrUpdateDto(
                                    index: index,
                                    titleStr: "修改",
                                    id: model.bedsideBedsideOpsHospitalListModelDatas[index].id,
                                    callback: (data) {
                                      model.refreshList(data, index);
                                    }
                                  ));
                                },),
                                ListClickTextButton("删除",onPressed: () {
                                  delHandler(context, model.bedsideBedsideOpsHospitalListModelDatas[index],index);
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
                      _bedsideBedsideOpsHospitalViewModel.selectAll(value);
                    },),
                    SizedBox(width: 5.w,),
                    Text("全选",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Spacer(),
                    PopupMenuButton<int>(
                      onSelected: (value) {
                        if(value == 1) {
                          delSelectHandler(context, _bedsideBedsideOpsHospitalViewModel.ids);
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
                Navigator.pushNamed(context,"${BedsideBedsideOpsHospitalPage.routeName.replaceFirst("Page", "SaveOrUpadtePage")}",arguments: SaveOrUpdateDto(
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


  delHandler(BuildContext context,BedsideBedsideOpsHospitalListModelData data,int index) {

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
                _bedsideBedsideOpsHospitalViewModel.bedsideBedsideOpsHospitalDelete(index, [data.id],success: (value) {
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
                _bedsideBedsideOpsHospitalViewModel.bedsideBedsideOpsHospitalDelete(index, [data.id],success: (value) {
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
                    _bedsideBedsideOpsHospitalViewModel.bedsideBedsideOpsHospitalDeleteSelect(ids,success: (value) {
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
                    _bedsideBedsideOpsHospitalViewModel.bedsideBedsideOpsHospitalDeleteSelect(ids,success: (value) {
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
    if (!searchParam.containsKey(searchList[currentSearchListIndex].getParam())) {
      searchParam[searchList[currentSearchListIndex].getParam()] = searchController.text;
    }else if(searchController.text.isEmpty) {
      searchParam.remove(searchList[currentSearchListIndex].getParam());
    }
    _bedsideBedsideOpsHospitalViewModel.defaultData();
    _bedsideBedsideOpsHospitalViewModel.initBedsideBedsideOpsHospitalList(param: searchParam);
  }
}
