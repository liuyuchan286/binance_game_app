import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_refund_order_list_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_refund_order/bedside_bedside_refund_order_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideRefundOrderSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsiderefundorderSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideBedsideRefundOrderSaveOrUpadtePage({this.dto});

  final BedsideBedsideRefundOrderViewModel _bedsideBedsideRefundOrderViewModel = BedsideBedsideRefundOrderViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController orderIdController = new TextEditingController(text: "");
  final TextEditingController refundMoneyController = new TextEditingController(text: "");
  final TextEditingController orderSnController = new TextEditingController(text: "");
  final TextEditingController statusController = new TextEditingController(text: "");
  final TextEditingController transactionIdController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController adminIdController = new TextEditingController(text: "");
  final TextEditingController disposeTimeController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("-${dto.titleStr}",
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

              PrefixiconTextField(prefixText: "订单号",hintText: "请输入订单号",textEditingController: orderIdController,),
              PrefixiconTextField(prefixText: "退款金额",hintText: "请输入退款金额",textEditingController: refundMoneyController,),
              PrefixiconTextField(prefixText: "退款单号",hintText: "请输入退款单号",textEditingController: orderSnController,),
              PrefixiconTextField(prefixText: "退款状态  默认0 申请中   1审核通过  2审核失败",hintText: "请输入退款状态  默认0 申请中   1审核通过  2审核失败",textEditingController: statusController,),
              PrefixiconTextField(prefixText: "退款编码",hintText: "请输入退款编码",textEditingController: transactionIdController,),
              PrefixiconTextField(prefixText: "创建时间",hintText: "请输入创建时间",textEditingController: createdAtController,),
              PrefixiconTextField(prefixText: "操作人",hintText: "请输入操作人",textEditingController: adminIdController,),
              PrefixiconTextField(prefixText: "",hintText: "请输入",textEditingController: disposeTimeController,),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideRefundOrderViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideRefundOrderInfo(dto.id,success: (BedsideBedsideRefundOrderListModelData info) {
                        orderIdController.text = info.orderId.toString();
                        refundMoneyController.text = info.refundMoney.toString();
                        orderSnController.text = info.orderSn.toString();
                        statusController.text = info.status.toString();
                        transactionIdController.text = info.transactionId;
                        createdAtController.text = info.createdAt;
                        adminIdController.text = info.adminId.toString();
                        disposeTimeController.text = info.disposeTime;
                      });
                    }
                  },
                  viewModel: _bedsideBedsideRefundOrderViewModel,
                  builder: (c,BedsideBedsideRefundOrderViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                          if(model.loading) {
                            return;
                          }
                        if (orderIdController.text.isEmpty) {
                            EasyLoading.showToast("订单号不能为空");
                            return;
                        }
                        if (refundMoneyController.text.isEmpty) {
                            EasyLoading.showToast("退款金额不能为空");
                            return;
                        }
                        if (orderSnController.text.isEmpty) {
                            EasyLoading.showToast("退款单号不能为空");
                            return;
                        }
                        if (statusController.text.isEmpty) {
                            EasyLoading.showToast("退款状态  默认0 申请中   1审核通过  2审核失败不能为空");
                            return;
                        }
                        if (transactionIdController.text.isEmpty) {
                            EasyLoading.showToast("退款编码不能为空");
                            return;
                        }
                        if (createdAtController.text.isEmpty) {
                            EasyLoading.showToast("创建时间不能为空");
                            return;
                        }
                        if (adminIdController.text.isEmpty) {
                            EasyLoading.showToast("操作人不能为空");
                            return;
                        }
                        if (disposeTimeController.text.isEmpty) {
                            EasyLoading.showToast("不能为空");
                            return;
                        }

                        String orderId = orderIdController.text;
                        String refundMoney = refundMoneyController.text;
                        String orderSn = orderSnController.text;
                        String status = statusController.text;
                        String transactionId = transactionIdController.text;
                        String createdAt = createdAtController.text;
                        String adminId = adminIdController.text;
                        String disposeTime = disposeTimeController.text;

                        BedsideBedsideRefundOrderListModelData data = BedsideBedsideRefundOrderListModelData(
                          id: dto.id,
                            orderId: orderId.isEmpty ? null : int.parse(orderId),
                            refundMoney: refundMoney.isEmpty ? null : double.parse(refundMoney),
                            orderSn: orderSn.isEmpty ? null : int.parse(orderSn),
                            status: status.isEmpty ? null : int.parse(status),
                            transactionId: transactionId,
                            createdAt: createdAt,
                            adminId: adminId.isEmpty ? null : int.parse(adminId),
                            disposeTime: disposeTime,
                        );
                        model.bedsideBedsideRefundOrderSaveUpdate(data,success: (value) {
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
