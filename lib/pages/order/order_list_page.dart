import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/constant/theme_colors.dart';
import 'package:binance_game_app/model/list_table_column_model.dart';
import 'package:binance_game_app/widget/list_circle_checkbox.dart';
import 'package:binance_game_app/widget/list_click_text_button.dart';
import 'package:binance_game_app/widget/list_search_text_field.dart';
import 'package:binance_game_app/widget/list_select.dart';
import 'package:binance_game_app/widget/list_table_column.dart';

class OrderListPage extends StatefulWidget {

  static const routeName = '/orderListPage';

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {

  final double lineHeight = 30.h;
  final double preferredSizeBoxh = 15.h;
  bool check = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("订单列表",),
        bottom: PreferredSize(
          preferredSize: Size(double.infinity,127.h),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: preferredSizeBoxh,horizontal: 15.w),
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: lineHeight,
                      child: Row(
                        children: [
                          ListSelect(topHeight: lineHeight + preferredSizeBoxh,),
                          SizedBox(width: 8.w,),
                          ListSearchTextField(),
                          SizedBox(width: 15.w,),
                          Image.asset("assets/images/date-icon.png",
                            width: 22.w,
                            height: 22.h,
                          ),
                          SizedBox(width: 10.w,),
                          Image.asset("assets/images/export-icon.png",
                            width: 22.w,
                            height: 22.h,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: preferredSizeBoxh,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height: 30.h,
                    child: Row(
                      children: [
                        ListClickTextButton("未支付"),
                        ListClickTextButton("已支付",isSelect: true,),
                        ListClickTextButton("押金预支付"),
                        ListClickTextButton("已退款"),
                        ListClickTextButton("退款中"),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: preferredSizeBoxh,),
                Container(
                  height: 30.h,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListSelect(topHeight: lineHeight*3 + preferredSizeBoxh*3,),
                      ),
                      Expanded(
                        child: ListSelect(topHeight: lineHeight*3 + preferredSizeBoxh*3,),
                      ),
                      Expanded(
                        child: ListSelect(topHeight: lineHeight*3 + preferredSizeBoxh*3,),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemBuilder: (BuildContext context, int index){
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10.h,horizontal: 15.w),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 4.w),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListCircleCheckbox(),
                          SizedBox(width: 9.w,),
                          ListTableColumn(
                            dataList: [
                              ListTableColumnModel(key: "订单编号：",value: "202105061318134871358"),
                              ListTableColumnModel(key: "医院名称：",value: "周口市第六人民医院"),
                              ListTableColumnModel(key: "用户支付：",value: "9"),
                              ListTableColumnModel(key: "微信到账：",value: "8.96"),
                              ListTableColumnModel(key: "资源方：",value: "周口市第六人民医院"),
                              ListTableColumnModel(key: "分账比例：",value: "0.6"),
                              ListTableColumnModel(key: "资源方分账：",value: "5.36	"),
                              ListTableColumnModel(key: "我方分账：",value: "3.6"),
                              ListTableColumnModel(key: "完成时间：",value: "2021-04-21 16:45:37"),
                              ListTableColumnModel(key: "转为待审核时间：",value: "2021-04-21 16:45:37"),
                              ListTableColumnModel(key: "转为已入账时间：",value: "2021-04-21 16:45:37"),
                              ListTableColumnModel(key: "状态：",value: "待结算"),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 16.h,),
                      Wrap(
                        runSpacing: 15.h,
                        children: [
                          ListClickTextButton("转到AEP"),
                          ListClickTextButton("禁用"),
                          ListClickTextButton("修改"),
                          ListClickTextButton("开锁记录"),
                          ListClickTextButton("强制重置"),
                          ListClickTextButton("正常重置"),
                          ListClickTextButton("删除"),
                          ListClickTextButton("校准"),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
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
                    ListCircleCheckbox(topPadding: 0.h,),
                    SizedBox(width: 5.w,),
                    Text("全选",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Spacer(),
                    PopupMenuButton<String>(
                      itemBuilder: (context) {
                        TextStyle selectAllStyle = Theme.of(context).textTheme.headline2.copyWith(color: ThemeColors.COLOR_333333);
                        return <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: '语文',
                            child: Text('批量正常重置',
                              style: selectAllStyle,
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: '数学',
                            child: Text('批量强制重置',
                              style: selectAllStyle,),
                          ),
                          PopupMenuItem<String>(
                            value: '英语',
                            child: Text('批量重置设备标记',
                              style: selectAllStyle,),
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
            child: Image.asset("assets/images/list_add_icon.png",
              width: 35.w,
              height: 35.h,
            ),
          ),
        ],
      ),
    );
  }


}
