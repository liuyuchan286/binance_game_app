import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_usetime_list_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_hospital_usetime/bedside_bedside_hospital_usetime_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideHospitalUsetimeSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsidehospitalusetimeSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideBedsideHospitalUsetimeSaveOrUpadtePage({this.dto});

  final BedsideBedsideHospitalUsetimeViewModel _bedsideBedsideHospitalUsetimeViewModel = BedsideBedsideHospitalUsetimeViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController hospitalIdController = new TextEditingController(text: "");
  final TextEditingController startTimeController = new TextEditingController(text: "");
  final TextEditingController endTimeController = new TextEditingController(text: "");
  final TextEditingController payTypeController = new TextEditingController(text: "");
  final TextEditingController moneyController = new TextEditingController(text: "");
  final TextEditingController useDayController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");
  final TextEditingController deletedAtController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("医院设备使用时间表-${dto.titleStr}",
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

              PrefixiconTextField(prefixText: "",hintText: "请输入",textEditingController: hospitalIdController,),
              PrefixiconTextField(prefixText: "使用开始时间",hintText: "请输入使用开始时间",textEditingController: startTimeController,),
              PrefixiconTextField(prefixText: "使用结束时间",hintText: "请输入使用结束时间",textEditingController: endTimeController,),
              PrefixiconTextField(prefixText: "付款方式  0 直接付费,按天付费  1押金,按押金付费",hintText: "请输入付款方式  0 直接付费,按天付费  1押金,按押金付费",textEditingController: payTypeController,),
              PrefixiconTextField(prefixText: "单价",hintText: "请输入单价",textEditingController: moneyController,),
              PrefixiconTextField(prefixText: "天数",hintText: "请输入天数",textEditingController: useDayController,),
              PrefixiconTextField(prefixText: "",hintText: "请输入",textEditingController: createdAtController,),
              PrefixiconTextField(prefixText: "",hintText: "请输入",textEditingController: updatedAtController,),
              PrefixiconTextField(prefixText: "",hintText: "请输入",textEditingController: deletedAtController,),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideHospitalUsetimeViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideHospitalUsetimeInfo(dto.id,success: (BedsideBedsideHospitalUsetimeListModelData info) {
                        hospitalIdController.text = info.hospitalId.toString();
                        payTypeController.text = info.payType.toString();
                        moneyController.text = info.money.toString();
                        useDayController.text = info.useDay.toString();
                        createdAtController.text = info.createdAt;
                        updatedAtController.text = info.updatedAt;
                        deletedAtController.text = info.deletedAt;
                      });
                    }
                  },
                  viewModel: _bedsideBedsideHospitalUsetimeViewModel,
                  builder: (c,BedsideBedsideHospitalUsetimeViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                          if(model.loading) {
                            return;
                          }
                        if (hospitalIdController.text.isEmpty) {
                            EasyLoading.showToast("不能为空");
                            return;
                        }
                        if (startTimeController.text.isEmpty) {
                            EasyLoading.showToast("使用开始时间不能为空");
                            return;
                        }
                        if (endTimeController.text.isEmpty) {
                            EasyLoading.showToast("使用结束时间不能为空");
                            return;
                        }
                        if (payTypeController.text.isEmpty) {
                            EasyLoading.showToast("付款方式  0 直接付费,按天付费  1押金,按押金付费不能为空");
                            return;
                        }
                        if (moneyController.text.isEmpty) {
                            EasyLoading.showToast("单价不能为空");
                            return;
                        }
                        if (useDayController.text.isEmpty) {
                            EasyLoading.showToast("天数不能为空");
                            return;
                        }
                        if (createdAtController.text.isEmpty) {
                            EasyLoading.showToast("不能为空");
                            return;
                        }
                        if (updatedAtController.text.isEmpty) {
                            EasyLoading.showToast("不能为空");
                            return;
                        }
                        if (deletedAtController.text.isEmpty) {
                            EasyLoading.showToast("不能为空");
                            return;
                        }

                        String hospitalId = hospitalIdController.text;
                        String startTime = startTimeController.text;
                        String endTime = endTimeController.text;
                        String payType = payTypeController.text;
                        String money = moneyController.text;
                        String useDay = useDayController.text;
                        String createdAt = createdAtController.text;
                        String updatedAt = updatedAtController.text;
                        String deletedAt = deletedAtController.text;

                        BedsideBedsideHospitalUsetimeListModelData data = BedsideBedsideHospitalUsetimeListModelData(
                          id: dto.id,
                            hospitalId: hospitalId.isEmpty ? null : int.parse(hospitalId),
                            payType: payType.isEmpty ? null : int.parse(payType),
                            money: money.isEmpty ? null : double.parse(money),
                            useDay: useDay.isEmpty ? null : int.parse(useDay),
                            createdAt: createdAt,
                            updatedAt: updatedAt,
                            deletedAt: deletedAt,
                        );
                        model.bedsideBedsideHospitalUsetimeSaveUpdate(data,success: (value) {
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
