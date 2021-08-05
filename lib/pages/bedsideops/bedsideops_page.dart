import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/constant/theme_colors.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedsideops_list_model.dart';
import 'package:binance_game_app/model/list_table_column_model.dart';
import 'package:binance_game_app/model/search_model.dart';
import 'package:binance_game_app/view_model/bedside_bedsideops/bedside_bedsideops_view_model.dart';
import 'package:binance_game_app/widget/list_circle_checkbox.dart';
import 'package:binance_game_app/widget/list_click_text_button.dart';
import 'package:binance_game_app/widget/list_search_text_field.dart';
import 'package:binance_game_app/widget/list_select.dart';
import 'package:binance_game_app/widget/list_table_column.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideopsPage extends StatelessWidget {

  static const routeName = '/bedsideopsPage';


  BedsideopsPage() {
    print("print");
  }

  BedsideBedsideopsViewModel _bedsideBedsideopsViewModel = BedsideBedsideopsViewModel();

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
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onDoubleTap: () {
            _bedsideBedsideopsViewModel.scrollController.animateTo(-10.h, duration: Duration(milliseconds: 500), curve: Curves.linear);
          },
          child: Text("运维管理",)
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
            viewModel: _bedsideBedsideopsViewModel,
            init: (BedsideBedsideopsViewModel model) {
              model.initBedsideBedsideopsList();
            },
            builder: (c,BedsideBedsideopsViewModel model, _) {
              if(model.loading && model.bedsideBedsideopsListModelDatas.isEmpty) {
                return CupertinoActivityIndicator();
              }
              return ListView.builder(
                itemCount: model.bedsideBedsideopsListModelDatas.length + 1,
                controller: model.scrollController,
                padding: EdgeInsets.only(bottom: 45.h),
                itemBuilder: (BuildContext context, int index){
                  if((model.totalCount == model.bedsideBedsideopsListModelDatas.length || model.currPage == model.totalPage) && index == model.bedsideBedsideopsListModelDatas.length) {
                    return Center(
                      child: Text("没有更多数据了",
                        style: Theme.of(context).textTheme.headline2.copyWith(
                          color: ThemeColors.COLOR_BDBDBD
                        ),
                      ),
                    );
                  } else if(index == model.bedsideBedsideopsListModelDatas.length) {
                    return CupertinoActivityIndicator();
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
                                check: model.ids.contains(model.bedsideBedsideopsListModelDatas[index].id),
                                onChanged: (value) {
                                  if(value) {
                                    model.ids.add(model.bedsideBedsideopsListModelDatas[index].id);
                                  }else {
                                    model.ids.remove(model.bedsideBedsideopsListModelDatas[index].id);
                                  }
                                },
                              ),
                              SizedBox(width: 9.w,),
                              ListTableColumn(
                                dataList: [
                                  ListTableColumnModel(key: "运维人员名称：",value: model.bedsideBedsideopsListModelDatas[index].name),
                                  ListTableColumnModel(key: "手机号：",value: model.bedsideBedsideopsListModelDatas[index].phone),
                                  ListTableColumnModel(key: "总管理：",value: model.bedsideBedsideopsListModelDatas[index].isManageStr),
                                  ListTableColumnModel(key: "创建时间：",value: model.bedsideBedsideopsListModelDatas[index].createdAt),
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
                                // ListClickTextButton("负责医院"),
                                // ListClickTextButton("设为管理"),
                                ListClickTextButton("修改",onPressed: () {
                                  Navigator.pushNamed(context,"${BedsideopsPage.routeName.replaceFirst("Page", "SaveOrUpadtePage")}",arguments: SaveOrUpdateDto(
                                    index: index,
                                    titleStr: "修改",
                                    id: model.bedsideBedsideopsListModelDatas[index].id,
                                    callback: (data) {
                                      model.refreshList(data, index);
                                    }
                                  ));
                                },),
                                ListClickTextButton("删除",onPressed: () {
                                  delHandler(context, model.bedsideBedsideopsListModelDatas[index],index);
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
                      _bedsideBedsideopsViewModel.selectAll(value);
                    },),
                    SizedBox(width: 5.w,),
                    Text("全选",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Spacer(),
                    PopupMenuButton<int>(
                      onSelected: (value) {
                        if(value == 1) {
                          delSelectHandler(context, _bedsideBedsideopsViewModel.ids);
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
                Navigator.pushNamed(context,"${BedsideopsPage.routeName.replaceFirst("Page", "SaveOrUpadtePage")}",arguments: SaveOrUpdateDto(
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


  delHandler(BuildContext context,BedsideBedsideopsListModelData data,int index) {
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
                _bedsideBedsideopsViewModel.bedsideBedsideopsDelete(index, [data.id],success: (value) {
                  EasyLoading.dismiss();
                  EasyLoading.showToast("删除成功");
                });
              },),
            ],
          );
        });
  }

  delSelectHandler(BuildContext context,List<int> ids) {
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
                _bedsideBedsideopsViewModel.bedsideBedsideopsDeleteSelect(ids,success: (value) {
                  EasyLoading.dismiss();
                  EasyLoading.showToast("删除成功");
                  refreshList();
                });
              },),
            ],
          );
        });
  }

  refreshList() {
    _bedsideBedsideopsViewModel.defaultData();
    Map param = {
      searchList[currentSearchListIndex].getParam() : searchController.text
    };
    _bedsideBedsideopsViewModel.initBedsideBedsideopsList(param: param);
  }
}
