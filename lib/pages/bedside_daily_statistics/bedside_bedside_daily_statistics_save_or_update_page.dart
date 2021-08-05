import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_daily_statistics_list_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_daily_statistics/bedside_bedside_daily_statistics_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideDailyStatisticsSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsidedailystatisticsSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideBedsideDailyStatisticsSaveOrUpadtePage({this.dto});

  final BedsideBedsideDailyStatisticsViewModel _bedsideBedsideDailyStatisticsViewModel = BedsideBedsideDailyStatisticsViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController dateController = new TextEditingController(text: "");
  final TextEditingController ordersCountController = new TextEditingController(text: "");
  final TextEditingController money0Controller = new TextEditingController(text: "");
  final TextEditingController money1Controller = new TextEditingController(text: "");
  final TextEditingController money2Controller = new TextEditingController(text: "");
  final TextEditingController money3Controller = new TextEditingController(text: "");
  final TextEditingController refundMontyController = new TextEditingController(text: "");
  final TextEditingController useCountController = new TextEditingController(text: "");
  final TextEditingController countInUseController = new TextEditingController(text: "");
  final TextEditingController unlocksCountController = new TextEditingController(text: "");
  final TextEditingController tableTotalCountController = new TextEditingController(text: "");
  final TextEditingController hospitalNameController = new TextEditingController(text: "");
  final TextEditingController officeNameController = new TextEditingController(text: "");
  final TextEditingController roomNameController = new TextEditingController(text: "");
  final TextEditingController hospitalIdController = new TextEditingController(text: "");
  final TextEditingController officeIdController = new TextEditingController(text: "");
  final TextEditingController roomIdController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");
  final TextEditingController deletedAtController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("每日统计表-${dto.titleStr}",
        ),
      ),
      body: GestureDetector(
        onTap: () {
          //关闭键盘
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [

              PrefixiconTextField(prefixText: "日期",hintText: "请输入日期",textEditingController: dateController,),
              PrefixiconTextField(prefixText: "订单数量",hintText: "请输入订单数量",textEditingController: ordersCountController,),
              PrefixiconTextField(prefixText: "按天",hintText: "请输入按天",textEditingController: money0Controller,),
              PrefixiconTextField(prefixText: "押金按时",hintText: "请输入押金按时",textEditingController: money1Controller,),
              PrefixiconTextField(prefixText: "时间包段收费",hintText: "请输入时间包段收费",textEditingController: money2Controller,),
              PrefixiconTextField(prefixText: "押金按天",hintText: "请输入押金按天",textEditingController: money3Controller,),
              PrefixiconTextField(prefixText: "退款",hintText: "请输入退款",textEditingController: refundMontyController,),
              PrefixiconTextField(prefixText: "使用数量",hintText: "请输入使用数量",textEditingController: useCountController,),
              PrefixiconTextField(prefixText: "使用中数量",hintText: "请输入使用中数量",textEditingController: countInUseController,),
              PrefixiconTextField(prefixText: "开锁次数",hintText: "请输入开锁次数",textEditingController: unlocksCountController,),
              PrefixiconTextField(prefixText: "设备总数量",hintText: "请输入设备总数量",textEditingController: tableTotalCountController,),
              PrefixiconTextField(prefixText: "医院名称",hintText: "请输入医院名称",textEditingController: hospitalNameController,),
              PrefixiconTextField(prefixText: "科室名称",hintText: "请输入科室名称",textEditingController: officeNameController,),
              PrefixiconTextField(prefixText: "房间号名称",hintText: "请输入房间号名称",textEditingController: roomNameController,),
              PrefixiconTextField(prefixText: "医院ID",hintText: "请输入医院ID",textEditingController: hospitalIdController,),
              PrefixiconTextField(prefixText: "科室ID",hintText: "请输入科室ID",textEditingController: officeIdController,),
              PrefixiconTextField(prefixText: "房间号ID",hintText: "请输入房间号ID",textEditingController: roomIdController,),
              PrefixiconTextField(prefixText: "创建时间",hintText: "请输入创建时间",textEditingController: createdAtController,),
              PrefixiconTextField(prefixText: "修改时间",hintText: "请输入修改时间",textEditingController: updatedAtController,),
              PrefixiconTextField(prefixText: "删除时间",hintText: "请输入删除时间",textEditingController: deletedAtController,),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideDailyStatisticsViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideDailyStatisticsInfo(dto.id,success: (BedsideBedsideDailyStatisticsListModelData info) {
                        dateController.text = info.date;
                        ordersCountController.text = info.ordersCount.toString();
                        money0Controller.text = info.money0.toString();
                        money1Controller.text = info.money1.toString();
                        money2Controller.text = info.money2.toString();
                        money3Controller.text = info.money3.toString();
                        refundMontyController.text = info.refundMonty.toString();
                        useCountController.text = info.useCount.toString();
                        countInUseController.text = info.countInUse.toString();
                        unlocksCountController.text = info.unlocksCount.toString();
                        tableTotalCountController.text = info.tableTotalCount.toString();
                        hospitalNameController.text = info.hospitalName;
                        officeNameController.text = info.officeName;
                        roomNameController.text = info.roomName;
                        hospitalIdController.text = info.hospitalId.toString();
                        officeIdController.text = info.officeId.toString();
                        roomIdController.text = info.roomId.toString();
                        createdAtController.text = info.createdAt;
                        updatedAtController.text = info.updatedAt;
                        deletedAtController.text = info.deletedAt;
                      });
                    }
                  },
                  viewModel: _bedsideBedsideDailyStatisticsViewModel,
                  builder: (c,BedsideBedsideDailyStatisticsViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                          if(model.loading) {
                            return;
                          }
                        if (dateController.text.isEmpty) {
                            EasyLoading.showToast("日期不能为空");
                            return;
                        }
                        if (ordersCountController.text.isEmpty) {
                            EasyLoading.showToast("订单数量不能为空");
                            return;
                        }
                        if (money0Controller.text.isEmpty) {
                            EasyLoading.showToast("按天不能为空");
                            return;
                        }
                        if (money1Controller.text.isEmpty) {
                            EasyLoading.showToast("押金按时不能为空");
                            return;
                        }
                        if (money2Controller.text.isEmpty) {
                            EasyLoading.showToast("时间包段收费不能为空");
                            return;
                        }
                        if (money3Controller.text.isEmpty) {
                            EasyLoading.showToast("押金按天不能为空");
                            return;
                        }
                        if (refundMontyController.text.isEmpty) {
                            EasyLoading.showToast("退款不能为空");
                            return;
                        }
                        if (useCountController.text.isEmpty) {
                            EasyLoading.showToast("使用数量不能为空");
                            return;
                        }
                        if (countInUseController.text.isEmpty) {
                            EasyLoading.showToast("使用中数量不能为空");
                            return;
                        }
                        if (unlocksCountController.text.isEmpty) {
                            EasyLoading.showToast("开锁次数不能为空");
                            return;
                        }
                        if (tableTotalCountController.text.isEmpty) {
                            EasyLoading.showToast("设备总数量不能为空");
                            return;
                        }
                        if (hospitalNameController.text.isEmpty) {
                            EasyLoading.showToast("医院名称不能为空");
                            return;
                        }
                        if (officeNameController.text.isEmpty) {
                            EasyLoading.showToast("科室名称不能为空");
                            return;
                        }
                        if (roomNameController.text.isEmpty) {
                            EasyLoading.showToast("房间号名称不能为空");
                            return;
                        }
                        if (hospitalIdController.text.isEmpty) {
                            EasyLoading.showToast("医院ID不能为空");
                            return;
                        }
                        if (officeIdController.text.isEmpty) {
                            EasyLoading.showToast("科室ID不能为空");
                            return;
                        }
                        if (roomIdController.text.isEmpty) {
                            EasyLoading.showToast("房间号ID不能为空");
                            return;
                        }
                        if (createdAtController.text.isEmpty) {
                            EasyLoading.showToast("创建时间不能为空");
                            return;
                        }
                        if (updatedAtController.text.isEmpty) {
                            EasyLoading.showToast("修改时间不能为空");
                            return;
                        }
                        if (deletedAtController.text.isEmpty) {
                            EasyLoading.showToast("删除时间不能为空");
                            return;
                        }

                        String date = dateController.text;
                        String ordersCount = ordersCountController.text;
                        String money0 = money0Controller.text;
                        String money1 = money1Controller.text;
                        String money2 = money2Controller.text;
                        String money3 = money3Controller.text;
                        String refundMonty = refundMontyController.text;
                        String useCount = useCountController.text;
                        String countInUse = countInUseController.text;
                        String unlocksCount = unlocksCountController.text;
                        String tableTotalCount = tableTotalCountController.text;
                        String hospitalName = hospitalNameController.text;
                        String officeName = officeNameController.text;
                        String roomName = roomNameController.text;
                        String hospitalId = hospitalIdController.text;
                        String officeId = officeIdController.text;
                        String roomId = roomIdController.text;
                        String createdAt = createdAtController.text;
                        String updatedAt = updatedAtController.text;
                        String deletedAt = deletedAtController.text;

                        BedsideBedsideDailyStatisticsListModelData data = BedsideBedsideDailyStatisticsListModelData(
                          id: dto.id,
                            date: date,
                            ordersCount: ordersCount.isEmpty ? null : int.parse(ordersCount),
                            money0: money0.isEmpty ? null : double.parse(money0),
                            money1: money1.isEmpty ? null : double.parse(money1),
                            money2: money2.isEmpty ? null : double.parse(money2),
                            money3: money3.isEmpty ? null : double.parse(money3),
                            refundMonty: refundMonty.isEmpty ? null : double.parse(refundMonty),
                            useCount: useCount.isEmpty ? null : int.parse(useCount),
                            countInUse: countInUse.isEmpty ? null : int.parse(countInUse),
                            unlocksCount: unlocksCount.isEmpty ? null : int.parse(unlocksCount),
                            tableTotalCount: tableTotalCount.isEmpty ? null : int.parse(tableTotalCount),
                            hospitalName: hospitalName,
                            officeName: officeName,
                            roomName: roomName,
                            hospitalId: hospitalId.isEmpty ? null : int.parse(hospitalId),
                            officeId: officeId.isEmpty ? null : int.parse(officeId),
                            roomId: roomId.isEmpty ? null : int.parse(roomId),
                            createdAt: createdAt,
                            updatedAt: updatedAt,
                            deletedAt: deletedAt,
                        );
                        model.bedsideBedsideDailyStatisticsSaveUpdate(data,success: (value) {
                          EasyLoading.showToast("${dto.titleStr}成功");
                          dto.callback(data);
                          Navigator.pop<String>(context);
                        });
                      },
                      child: model.loading ? CupertinoActivityIndicator() : Text(
                          "确定"
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
