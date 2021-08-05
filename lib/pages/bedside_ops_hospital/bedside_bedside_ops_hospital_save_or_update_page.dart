import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_ops_hospital_list_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_ops_hospital/bedside_bedside_ops_hospital_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideOpsHospitalSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsideopshospitalSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideBedsideOpsHospitalSaveOrUpadtePage({this.dto});

  final BedsideBedsideOpsHospitalViewModel _bedsideBedsideOpsHospitalViewModel = BedsideBedsideOpsHospitalViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController opsIdController = new TextEditingController(text: "");
  final TextEditingController hospitalIdController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");
  final TextEditingController autoPushController = new TextEditingController(text: "");
  final TextEditingController autoAssignController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("运维人员-医院记录表-${dto.titleStr}",
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

              PrefixiconTextField(prefixText: "运维人员ID",hintText: "请输入运维人员ID",textEditingController: opsIdController,),
              PrefixiconTextField(prefixText: "医院ID",hintText: "请输入医院ID",textEditingController: hospitalIdController,),
              PrefixiconTextField(prefixText: "",hintText: "请输入",textEditingController: createdAtController,),
              PrefixiconTextField(prefixText: "",hintText: "请输入",textEditingController: updatedAtController,),
              PrefixiconTextField(prefixText: "是否自动推送",hintText: "请输入是否自动推送",textEditingController: autoPushController,),
              PrefixiconTextField(prefixText: "自动派单",hintText: "请输入自动派单",textEditingController: autoAssignController,),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideOpsHospitalViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideOpsHospitalInfo(dto.id,success: (BedsideBedsideOpsHospitalListModelData info) {
                        opsIdController.text = info.opsId.toString();
                        hospitalIdController.text = info.hospitalId.toString();
                        createdAtController.text = info.createdAt;
                        updatedAtController.text = info.updatedAt;
                        autoPushController.text = info.autoPush.toString();
                        autoAssignController.text = info.autoAssign.toString();
                      });
                    }
                  },
                  viewModel: _bedsideBedsideOpsHospitalViewModel,
                  builder: (c,BedsideBedsideOpsHospitalViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                          if(model.loading) {
                            return;
                          }
                        if (opsIdController.text.isEmpty) {
                            EasyLoading.showToast("运维人员ID不能为空");
                            return;
                        }
                        if (hospitalIdController.text.isEmpty) {
                            EasyLoading.showToast("医院ID不能为空");
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
                        if (autoPushController.text.isEmpty) {
                            EasyLoading.showToast("是否自动推送不能为空");
                            return;
                        }
                        if (autoAssignController.text.isEmpty) {
                            EasyLoading.showToast("自动派单不能为空");
                            return;
                        }

                        String opsId = opsIdController.text;
                        String hospitalId = hospitalIdController.text;
                        String createdAt = createdAtController.text;
                        String updatedAt = updatedAtController.text;
                        String autoPush = autoPushController.text;
                        String autoAssign = autoAssignController.text;

                        BedsideBedsideOpsHospitalListModelData data = BedsideBedsideOpsHospitalListModelData(
                          id: dto.id,
                            opsId: opsId.isEmpty ? null : int.parse(opsId),
                            hospitalId: hospitalId.isEmpty ? null : int.parse(hospitalId),
                            createdAt: createdAt,
                            updatedAt: updatedAt,
                            autoPush: autoPush.isEmpty ? null : int.parse(autoPush),
                            autoAssign: autoAssign.isEmpty ? null : int.parse(autoAssign),
                        );
                        model.bedsideBedsideOpsHospitalSaveUpdate(data,success: (value) {
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
