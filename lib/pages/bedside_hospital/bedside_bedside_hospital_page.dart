import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/constant/theme_colors.dart';
import 'package:binance_game_app/dto/bedside_bedside_hospital_office/bedside_bedside_hospital_office_list_dto.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_list_model.dart';
import 'package:binance_game_app/model/list_table_column_model.dart';
import 'package:binance_game_app/model/search_model.dart';
import 'package:binance_game_app/pages/bedside_hospital_office/bedside_bedside_hospital_office_page.dart';
import 'package:binance_game_app/view_model/bedside_bedside_hospital/bedside_bedside_hospital_view_model.dart';
import 'package:binance_game_app/widget/list_circle_checkbox.dart';
import 'package:binance_game_app/widget/list_click_text_button.dart';
import 'package:binance_game_app/widget/list_search_text_field.dart';
import 'package:binance_game_app/widget/list_select.dart';
import 'package:binance_game_app/widget/list_table_column.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideHospitalPage extends StatelessWidget {

  static const routeName = '/bedsidehospitalPage';


  BedsideBedsideHospitalPage() {
    print("print");
  }

  BedsideBedsideHospitalViewModel _bedsideBedsideHospitalViewModel = BedsideBedsideHospitalViewModel();

  final TextEditingController searchController = TextEditingController();

  List<SearchModel> searchList = [
    SearchModel(key: 1,value: "医院名称",param: "name"),
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
            _bedsideBedsideHospitalViewModel.scrollController.animateTo(-10.h, duration: Duration(milliseconds: 500), curve: Curves.linear);
          },
          child: Text("医院记录表",)
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
                // SizedBox(height: preferredSizeBoxh,),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          ProviderWidget(
            viewModel: _bedsideBedsideHospitalViewModel,
            init: (BedsideBedsideHospitalViewModel model) {
              model.initBedsideBedsideHospitalList();
            },
            builder: (c,BedsideBedsideHospitalViewModel model, _) {
              if(model.loading && model.bedsideBedsideHospitalListModelDatas.isEmpty) {
                return Center(child: CupertinoActivityIndicator());
              }
              return ListView.builder(
                itemCount: model.bedsideBedsideHospitalListModelDatas.length + 1,
                controller: model.scrollController,
                padding: EdgeInsets.only(bottom: 45.h),
                itemBuilder: (BuildContext context, int index){
                  if((model.totalCount == model.bedsideBedsideHospitalListModelDatas.length || model.currPage == model.totalPage) && index == model.bedsideBedsideHospitalListModelDatas.length) {
                    return Center(
                      child: Text("没有更多数据了",
                        style: Theme.of(context).textTheme.headline2.copyWith(
                          color: ThemeColors.COLOR_BDBDBD
                        ),
                      ),
                    );
                  } else if(index == model.bedsideBedsideHospitalListModelDatas.length) {
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
                                check: model.ids.contains(model.bedsideBedsideHospitalListModelDatas[index].id),
                                onChanged: (value) {
                                  if(value) {
                                    model.ids.add(model.bedsideBedsideHospitalListModelDatas[index].id);
                                  }else {
                                    model.ids.remove(model.bedsideBedsideHospitalListModelDatas[index].id);
                                  }
                                },
                              ),
                              SizedBox(width: 9.w,),
                              ListTableColumn(
                                dataList: [
                                  ListTableColumnModel(key: "医院名称",value: model.bedsideBedsideHospitalListModelDatas[index].name,onTab: () {
                                    Navigator.of(context).pushNamed(BedsideBedsideHospitalOfficePage.routeName,arguments: BedsideBedsideHospitalOfficeListDto(
                                      hospitalId: model.bedsideBedsideHospitalListModelDatas[index].id
                                    ));
                                  }),
                                  ListTableColumnModel(key: "联系人",value: model.bedsideBedsideHospitalListModelDatas[index].contact),
                                  ListTableColumnModel(key: "手机号",value: model.bedsideBedsideHospitalListModelDatas[index].phone),
                                  ListTableColumnModel(key: "地区",value: "${model.bedsideBedsideHospitalListModelDatas[index].province}-${model.bedsideBedsideHospitalListModelDatas[index].city}-${model.bedsideBedsideHospitalListModelDatas[index].county}"),
                                  ListTableColumnModel(key: "使用时间",value: model.bedsideBedsideHospitalListModelDatas[index].getUsetimeAll()),
                                  ListTableColumnModel(key: "创建时间",value: model.bedsideBedsideHospitalListModelDatas[index].createdAt.toString()),
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
                                  Navigator.pushNamed(context,"${BedsideBedsideHospitalPage.routeName.replaceFirst("Page", "SaveOrUpadtePage")}",arguments: SaveOrUpdateDto(
                                    index: index,
                                    titleStr: "修改",
                                    id: model.bedsideBedsideHospitalListModelDatas[index].id,
                                    callback: (data) {
                                      model.refreshList(data, index);
                                    }
                                  ));
                                },),
                                ListClickTextButton("删除",onPressed: () {
                                  delHandler(context, model.bedsideBedsideHospitalListModelDatas[index],index);
                                },),
                                ListClickTextButton("刷新",onPressed: () {
                                  refreshHandler(context, model.bedsideBedsideHospitalListModelDatas[index]);
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
                      _bedsideBedsideHospitalViewModel.selectAll(value);
                    },),
                    SizedBox(width: 5.w,),
                    Text("全选",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Spacer(),
                    PopupMenuButton<int>(
                      onSelected: (value) {
                        if(value == 1) {
                          delSelectHandler(context, _bedsideBedsideHospitalViewModel.ids);
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
                Navigator.pushNamed(context,"${BedsideBedsideHospitalPage.routeName.replaceFirst("Page", "SaveOrUpadtePage")}",arguments: SaveOrUpdateDto(
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


  delHandler(BuildContext context,BedsideBedsideHospitalListModelData data,int index) {

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
                _bedsideBedsideHospitalViewModel.bedsideBedsideHospitalDelete(index, [data.id],success: (value) {
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
                _bedsideBedsideHospitalViewModel.bedsideBedsideHospitalDelete(index, [data.id],success: (value) {
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
                    _bedsideBedsideHospitalViewModel.bedsideBedsideHospitalDeleteSelect(ids,success: (value) {
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
                    _bedsideBedsideHospitalViewModel.bedsideBedsideHospitalDeleteSelect(ids,success: (value) {
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

  refreshHandler(BuildContext context,BedsideBedsideHospitalListModelData data) {
    if (Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('提示'),
              content: Text('确认刷新吗？'),
              actions: <Widget>[
                FlatButton(child: Text('取消'),onPressed: (){
                  Navigator.pop(context);
                },),
                FlatButton(child: Text('确认'),onPressed: (){
                  Navigator.pop(context);
                  EasyLoading.show(status: "刷新中");
                  _bedsideBedsideHospitalViewModel.bedsideBedsideHospitalRefresh([data.id],success: (value) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("刷新成功");
                    refreshList();
                  },error: (err) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("刷新失败:${err.toString()}");
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
              content: Text('确认批量刷新吗？'),
              actions: <Widget>[
                CupertinoDialogAction(child: Text('取消'),onPressed: (){
                  Navigator.pop(context);
                },),
                CupertinoDialogAction(child: Text('确认'),onPressed: (){
                  Navigator.pop(context);
                  EasyLoading.show(status: "刷新中");
                  _bedsideBedsideHospitalViewModel.bedsideBedsideHospitalRefresh([data.id],success: (value) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("刷新成功");
                    refreshList();
                  },error: (err) {
                    EasyLoading.dismiss();
                    EasyLoading.showToast("刷新失败:${err.toString()}");
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
    _bedsideBedsideHospitalViewModel.defaultData();
    _bedsideBedsideHospitalViewModel.initBedsideBedsideHospitalList(param: searchParam);
  }
}
