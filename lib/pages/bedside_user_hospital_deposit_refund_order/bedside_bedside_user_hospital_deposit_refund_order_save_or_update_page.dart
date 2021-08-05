import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_user_hospital_deposit_refund_order_list_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_user_hospital_deposit_refund_order/bedside_bedside_user_hospital_deposit_refund_order_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideUserHospitalDepositRefundOrderSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsideuserhospitaldepositrefundorderSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideBedsideUserHospitalDepositRefundOrderSaveOrUpadtePage({this.dto});

  final BedsideBedsideUserHospitalDepositRefundOrderViewModel _bedsideBedsideUserHospitalDepositRefundOrderViewModel = BedsideBedsideUserHospitalDepositRefundOrderViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController userIdController = new TextEditingController(text: "");
  final TextEditingController hospitalIdController = new TextEditingController(text: "");
  final TextEditingController orderSnController = new TextEditingController(text: "");
  final TextEditingController userDepositController = new TextEditingController(text: "");
  final TextEditingController refundDepositController = new TextEditingController(text: "");
  final TextEditingController refundStatusController = new TextEditingController(text: "");
  final TextEditingController refundSourceController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");
  final TextEditingController deletedAtController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("用户医院押金退款订单-${dto.titleStr}",
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
              PrefixiconTextField(prefixText: "订单号",hintText: "请输入订单号",textEditingController: orderSnController,),
              PrefixiconTextField(prefixText: "用户押金",hintText: "请输入用户押金",textEditingController: userDepositController,),
              PrefixiconTextField(prefixText: "退款押金",hintText: "请输入退款押金",textEditingController: refundDepositController,),
              PrefixiconTextField(prefixText: "退款状态",hintText: "请输入退款状态",textEditingController: refundStatusController,),
              PrefixiconTextField(prefixText: "退款来源",hintText: "请输入退款来源",textEditingController: refundSourceController,),
              PrefixiconTextField(prefixText: "创建时间",hintText: "请输入创建时间",textEditingController: createdAtController,),
              PrefixiconTextField(prefixText: "修改时间",hintText: "请输入修改时间",textEditingController: updatedAtController,),
              PrefixiconTextField(prefixText: "删除时间",hintText: "请输入删除时间",textEditingController: deletedAtController,),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideUserHospitalDepositRefundOrderViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideUserHospitalDepositRefundOrderInfo(dto.id,success: (BedsideBedsideUserHospitalDepositRefundOrderListModelData info) {
                        userIdController.text = info.userId.toString();
                        hospitalIdController.text = info.hospitalId.toString();
                        orderSnController.text = info.orderSn;
                        userDepositController.text = info.userDeposit.toString();
                        refundDepositController.text = info.refundDeposit.toString();
                        refundStatusController.text = info.refundStatus.toString();
                        refundSourceController.text = info.refundSource.toString();
                        createdAtController.text = info.createdAt;
                        updatedAtController.text = info.updatedAt;
                        deletedAtController.text = info.deletedAt;
                      });
                    }
                  },
                  viewModel: _bedsideBedsideUserHospitalDepositRefundOrderViewModel,
                  builder: (c,BedsideBedsideUserHospitalDepositRefundOrderViewModel model,_) {
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
                        if (orderSnController.text.isEmpty) {
                            EasyLoading.showToast("订单号不能为空");
                            return;
                        }
                        if (userDepositController.text.isEmpty) {
                            EasyLoading.showToast("用户押金不能为空");
                            return;
                        }
                        if (refundDepositController.text.isEmpty) {
                            EasyLoading.showToast("退款押金不能为空");
                            return;
                        }
                        if (refundStatusController.text.isEmpty) {
                            EasyLoading.showToast("退款状态不能为空");
                            return;
                        }
                        if (refundSourceController.text.isEmpty) {
                            EasyLoading.showToast("退款来源不能为空");
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

                        String userId = userIdController.text;
                        String hospitalId = hospitalIdController.text;
                        String orderSn = orderSnController.text;
                        String userDeposit = userDepositController.text;
                        String refundDeposit = refundDepositController.text;
                        String refundStatus = refundStatusController.text;
                        String refundSource = refundSourceController.text;
                        String createdAt = createdAtController.text;
                        String updatedAt = updatedAtController.text;
                        String deletedAt = deletedAtController.text;

                        BedsideBedsideUserHospitalDepositRefundOrderListModelData data = BedsideBedsideUserHospitalDepositRefundOrderListModelData(
                          id: dto.id,
                            userId: userId.isEmpty ? null : int.parse(userId),
                            hospitalId: hospitalId.isEmpty ? null : int.parse(hospitalId),
                            orderSn: orderSn,
                            userDeposit: userDeposit.isEmpty ? null : double.parse(userDeposit),
                            refundDeposit: refundDeposit.isEmpty ? null : double.parse(refundDeposit),
                            refundStatus: refundStatus.isEmpty ? null : int.parse(refundStatus),
                            refundSource: refundSource.isEmpty ? null : int.parse(refundSource),
                            createdAt: createdAt,
                            updatedAt: updatedAt,
                            deletedAt: deletedAt,
                        );
                        model.bedsideBedsideUserHospitalDepositRefundOrderSaveUpdate(data,success: (value) {
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
