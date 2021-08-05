import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_order_commission_list_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_order_commission/bedside_bedside_order_commission_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideOrderCommissionSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsideordercommissionSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideBedsideOrderCommissionSaveOrUpadtePage({this.dto});

  final BedsideBedsideOrderCommissionViewModel _bedsideBedsideOrderCommissionViewModel = BedsideBedsideOrderCommissionViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController orderIdController = new TextEditingController(text: "");
  final TextEditingController orderSnController = new TextEditingController(text: "");
  final TextEditingController hospitalIdController = new TextEditingController(text: "");
  final TextEditingController hospitalNameController = new TextEditingController(text: "");
  final TextEditingController userMoneyController = new TextEditingController(text: "");
  final TextEditingController wechatMoneyController = new TextEditingController(text: "");
  final TextEditingController agentIdController = new TextEditingController(text: "");
  final TextEditingController agentNameController = new TextEditingController(text: "");
  final TextEditingController commissionRatioController = new TextEditingController(text: "");
  final TextEditingController agentMoneyController = new TextEditingController(text: "");
  final TextEditingController ourMoneyController = new TextEditingController(text: "");
  final TextEditingController orderCompletionTimeController = new TextEditingController(text: "");
  final TextEditingController isCompletionController = new TextEditingController(text: "");
  final TextEditingController toReviewTimeController = new TextEditingController(text: "");
  final TextEditingController reviewTimeController = new TextEditingController(text: "");
  final TextEditingController toWithdrawalTimeController = new TextEditingController(text: "");
  final TextEditingController statusController = new TextEditingController(text: "");
  final TextEditingController remarksController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("订单分佣-${dto.titleStr}",
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
              PrefixiconTextField(prefixText: "备注",hintText: "请输入备注",textEditingController: remarksController,),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideOrderCommissionViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideOrderCommissionInfo(dto.id,success: (BedsideBedsideOrderCommissionListModelData info) {
                        orderIdController.text = info.orderId.toString();
                        orderSnController.text = info.orderSn;
                        hospitalIdController.text = info.hospitalId.toString();
                        hospitalNameController.text = info.hospitalName;
                        userMoneyController.text = info.userMoney.toString();
                        wechatMoneyController.text = info.wechatMoney.toString();
                        agentIdController.text = info.agentId.toString();
                        agentNameController.text = info.agentName;
                        commissionRatioController.text = info.commissionRatio.toString();
                        agentMoneyController.text = info.agentMoney.toString();
                        ourMoneyController.text = info.ourMoney.toString();
                        orderCompletionTimeController.text = info.orderCompletionTime;
                        isCompletionController.text = info.isCompletion.toString();
                        toReviewTimeController.text = info.toReviewTime;
                        reviewTimeController.text = info.reviewTime;
                        toWithdrawalTimeController.text = info.toWithdrawalTime;
                        statusController.text = info.status.toString();
                        remarksController.text = info.remarks;
                        createdAtController.text = info.createdAt;
                        updatedAtController.text = info.updatedAt;
                      });
                    }
                  },
                  viewModel: _bedsideBedsideOrderCommissionViewModel,
                  builder: (c,BedsideBedsideOrderCommissionViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                          if(model.loading) {
                            return;
                          }
                        if (remarksController.text.isEmpty) {
                            EasyLoading.showToast("备注不能为空");
                            return;
                        }

                        String orderId = orderIdController.text;
                        String orderSn = orderSnController.text;
                        String hospitalId = hospitalIdController.text;
                        String hospitalName = hospitalNameController.text;
                        String userMoney = userMoneyController.text;
                        String wechatMoney = wechatMoneyController.text;
                        String agentId = agentIdController.text;
                        String agentName = agentNameController.text;
                        String commissionRatio = commissionRatioController.text;
                        String agentMoney = agentMoneyController.text;
                        String ourMoney = ourMoneyController.text;
                        String orderCompletionTime = orderCompletionTimeController.text;
                        String isCompletion = isCompletionController.text;
                        String toReviewTime = toReviewTimeController.text;
                        String reviewTime = reviewTimeController.text;
                        String toWithdrawalTime = toWithdrawalTimeController.text;
                        String status = statusController.text;
                        String remarks = remarksController.text;
                        String createdAt = createdAtController.text;
                        String updatedAt = updatedAtController.text;

                        BedsideBedsideOrderCommissionListModelData data = BedsideBedsideOrderCommissionListModelData(
                          id: dto.id,
                            remarks: remarks,
                        );
                        model.bedsideBedsideOrderCommissionSaveUpdate(data,success: (value) {
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
