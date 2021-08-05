import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_user_hospital_deposit_list_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_user_hospital_deposit/bedside_bedside_user_hospital_deposit_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideUserHospitalDepositSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsideuserhospitaldepositSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideBedsideUserHospitalDepositSaveOrUpadtePage({this.dto});

  final BedsideBedsideUserHospitalDepositViewModel _bedsideBedsideUserHospitalDepositViewModel = BedsideBedsideUserHospitalDepositViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController userIdController = new TextEditingController(text: "");
  final TextEditingController hospitalIdController = new TextEditingController(text: "");
  final TextEditingController depositController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");
  final TextEditingController deletedAtController = new TextEditingController(text: "");
  final TextEditingController refundingDepositController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("用户医院押金表-${dto.titleStr}",
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

              PrefixiconTextField(prefixText: "用户id",hintText: "请输入用户id",textEditingController: userIdController,),
              PrefixiconTextField(prefixText: "医院id",hintText: "请输入医院id",textEditingController: hospitalIdController,),
              PrefixiconTextField(prefixText: "保证金",hintText: "请输入保证金",textEditingController: depositController,),
              PrefixiconTextField(prefixText: "创建时间",hintText: "请输入创建时间",textEditingController: createdAtController,),
              PrefixiconTextField(prefixText: "修改时间",hintText: "请输入修改时间",textEditingController: updatedAtController,),
              PrefixiconTextField(prefixText: "删除时间",hintText: "请输入删除时间",textEditingController: deletedAtController,),
              PrefixiconTextField(prefixText: "退款中保证金",hintText: "请输入退款中保证金",textEditingController: refundingDepositController,),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideUserHospitalDepositViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideUserHospitalDepositInfo(dto.id,success: (BedsideBedsideUserHospitalDepositListModelData info) {
                        userIdController.text = info.userId.toString();
                        hospitalIdController.text = info.hospitalId.toString();
                        depositController.text = info.deposit.toString();
                        createdAtController.text = info.createdAt;
                        updatedAtController.text = info.updatedAt;
                        deletedAtController.text = info.deletedAt;
                        refundingDepositController.text = info.refundingDeposit.toString();
                      });
                    }
                  },
                  viewModel: _bedsideBedsideUserHospitalDepositViewModel,
                  builder: (c,BedsideBedsideUserHospitalDepositViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                          if(model.loading) {
                            return;
                          }
                        if (userIdController.text.isEmpty) {
                            EasyLoading.showToast("用户id不能为空");
                            return;
                        }
                        if (hospitalIdController.text.isEmpty) {
                            EasyLoading.showToast("医院id不能为空");
                            return;
                        }
                        if (depositController.text.isEmpty) {
                            EasyLoading.showToast("保证金不能为空");
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
                        if (refundingDepositController.text.isEmpty) {
                            EasyLoading.showToast("退款中保证金不能为空");
                            return;
                        }

                        String userId = userIdController.text;
                        String hospitalId = hospitalIdController.text;
                        String deposit = depositController.text;
                        String createdAt = createdAtController.text;
                        String updatedAt = updatedAtController.text;
                        String deletedAt = deletedAtController.text;
                        String refundingDeposit = refundingDepositController.text;

                        BedsideBedsideUserHospitalDepositListModelData data = BedsideBedsideUserHospitalDepositListModelData(
                          id: dto.id,
                            userId: userId.isEmpty ? null : int.parse(userId),
                            hospitalId: hospitalId.isEmpty ? null : int.parse(hospitalId),
                            deposit: deposit.isEmpty ? null : double.parse(deposit),
                            createdAt: createdAt,
                            updatedAt: updatedAt,
                            deletedAt: deletedAt,
                            refundingDeposit: refundingDeposit.isEmpty ? null : double.parse(refundingDeposit),
                        );
                        model.bedsideBedsideUserHospitalDepositSaveUpdate(data,success: (value) {
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
