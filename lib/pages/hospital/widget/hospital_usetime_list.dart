import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/constant/theme_colors.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_usetime_list_model.dart';
import 'package:binance_game_app/model/hospital_usetime_list_model.dart';
import 'package:binance_game_app/model/radio_list_title_model.dart';
import 'package:binance_game_app/widget/only_data_noborder_text_field.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/radio_group_list.dart';
import 'package:binance_game_app/widget/radio_list_title.dart';


class HospitalUsetimeList extends StatefulWidget {

  List<BedsideBedsideHospitalUsetimeListModelData> usetimeVOS = [];

  final String suffixText;
  final bool offstage;
  final String defaultTimeStr;
  final bool onTab;

  HospitalUsetimeList({
    this.usetimeVOS,
    this.suffixText,
    this.offstage = true,
    this.defaultTimeStr,
    this.onTab = true
  });

  @override
  _HospitalUsetimeListState createState() => _HospitalUsetimeListState();
}

class _HospitalUsetimeListState extends State<HospitalUsetimeList> {
  // List<HospitalUsetimeListModel> list = [
  //   HospitalUsetimeListModel(startTime: "19:00:00",endTime: "19:00:00",useDay: 1,money: 10),
  //   HospitalUsetimeListModel(startTime: "19:00:00",endTime: "19:00:00",useDay: 1,money: 10),
  //   HospitalUsetimeListModel(startTime: "19:00:00",endTime: "19:00:00",useDay: 1,money: 10),
  // ];

  String _currentUsetime = "00:00:00";

  @override
  Widget build(BuildContext context) {
    print(widget.usetimeVOS);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          for (int i = 0; i < widget.usetimeVOS.length; i++)
          Row(
            children: [
              Image.asset("assets/images/time_icon.png",
                width: 16.w,
                height: 16.h,
              ),
              SizedBox(width: 8.w,),
              OnlyDataNoborderTextField(
                width: 56.w,
                hintText: "开始时间",
                controller: widget.usetimeVOS[i].startTimeController,
                readOnly: true,
                onTap: () {
                  if(!widget.onTab)return;
                  showTimeUsetimes(context, i,onTap: () {
                    widget.usetimeVOS[i].startTimeController.text = _currentUsetime;
                  });
                },
              ),
              Container(
                width: 45.w,
                child: Divider(
                  thickness: 1.w,
                  color: ThemeColors.COLOR_333333,
                  indent: 15.w,
                  endIndent: 15.w,
                ),
              ),
              OnlyDataNoborderTextField(
                width: 56.w,
                hintText: "结束时间",
                controller: widget.usetimeVOS[i].endTimeController,
                readOnly: true,
                onTap: () {
                  if(!widget.onTab)return;
                  showTimeUsetimes(context, i,onTap: () {
                    widget.usetimeVOS[i].endTimeController.text = _currentUsetime;
                  });
                },
              ),
              SizedBox(width: 40.w,),
              Image.asset("assets/images/money_icon.png",
                width: 16.w,
                height: 16.h,
              ),
              SizedBox(width: 8.w,),
              OnlyDataNoborderTextField(
                hintText: "单价",
                onTap: () {

                },
                controller: widget.usetimeVOS[i].moneyController,
              ),
              Offstage(
                offstage: widget.offstage,
                child: OnlyDataNoborderTextField(
                  width: 30.w,
                  hintText: "天",
                  onTap: () {

                  },
                  suffixText: widget.suffixText,
                  controller: widget.usetimeVOS[i].useDayController,
                ),
              ),
              SizedBox(width: 10.w,),
              InkWell(
                onTap: () {
                  if(i == 0) {
                    for (var value in widget.usetimeVOS) {
                      print(value.toJson());
                    }
                    setState(() {
                      widget.usetimeVOS.add(
                          BedsideBedsideHospitalUsetimeListModelData(
                            useDay: 1,
                            startTime: widget.defaultTimeStr ?? "",
                            endTime: widget.defaultTimeStr ?? "",
                            money: 0.00,
                          )
                      );
                    });
                  }else {
                    setState(() {
                      widget.usetimeVOS.removeAt(i);
                    });
                  }
                },
                child: Image.asset(i == 0 ? "assets/images/list_add_icon.png" : "assets/images/list_del_icon.png",
                  width: 20.w,
                  height: 20.h,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showTimeUsetimes(BuildContext context, int i,{GestureTapCallback onTap}) {
    _currentUsetime = "00:00:00";
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      elevation: 10,
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 15.w,),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text("取消",style: Theme.of(context).textTheme.headline2.copyWith(height: 2),),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    if(onTap != null) {
                      onTap();
                    }
                    Navigator.pop(context);
                  },
                  child: Text("确认",style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.green,height: 2),),
                ),
                SizedBox(width: 15.w,),
              ],
            ),
            Divider(),
            Expanded(
              child: CupertinoTimerPicker(
                onTimerDurationChanged: (Duration duration){
                  if(duration.inHours < 10) {
                    _currentUsetime = "0${duration.toString().split(("."))[0]}";
                  }else {
                    _currentUsetime = "${duration.toString().split(("."))[0]}";
                  }
                },
              ),
            )
          ],
        );
      },
    );
  }



}
