import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_order_list_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_order/bedside_bedside_order_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideOrderSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsideorderSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideBedsideOrderSaveOrUpadtePage({this.dto});

  final BedsideBedsideOrderViewModel _bedsideBedsideOrderViewModel = BedsideBedsideOrderViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController orderSnController = new TextEditingController(text: "");
  final TextEditingController numberController = new TextEditingController(text: "");
  final TextEditingController openidController = new TextEditingController(text: "");
  final TextEditingController tableIdController = new TextEditingController(text: "");
  final TextEditingController statusController = new TextEditingController(text: "");
  final TextEditingController timeController = new TextEditingController(text: "");
  final TextEditingController moneyController = new TextEditingController(text: "");
  final TextEditingController numController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");
  final TextEditingController payAtController = new TextEditingController(text: "");
  final TextEditingController endAtController = new TextEditingController(text: "");
  final TextEditingController refundStatusController = new TextEditingController(text: "");
  final TextEditingController typeController = new TextEditingController(text: "");
  final TextEditingController payTypeController = new TextEditingController(text: "");
  final TextEditingController freeTrialTimeController = new TextEditingController(text: "");
  final TextEditingController hourMoneyController = new TextEditingController(text: "");
  final TextEditingController userIdController = new TextEditingController(text: "");
  final TextEditingController useEndAtController = new TextEditingController(text: "");
  final TextEditingController usetimeIdController = new TextEditingController(text: "");
  final TextEditingController tableStatusController = new TextEditingController(text: "");
  final TextEditingController hospitalNameController = new TextEditingController(text: "");
  final TextEditingController officeNameController = new TextEditingController(text: "");
  final TextEditingController roomNameController = new TextEditingController(text: "");
  final TextEditingController hospitalIdController = new TextEditingController(text: "");
  final TextEditingController officeIdController = new TextEditingController(text: "");
  final TextEditingController roomIdController = new TextEditingController(text: "");
  final TextEditingController phoneNumberController = new TextEditingController(text: "");
  final TextEditingController refundAtController = new TextEditingController(text: "");
  final TextEditingController payPlatformController = new TextEditingController(text: "");
  final TextEditingController bedIdController = new TextEditingController(text: "");
  final TextEditingController bedNameController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("订单记录表-${dto.titleStr}",
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

              PrefixiconTextField(prefixText: "订单号",hintText: "请输入订单号",textEditingController: orderSnController,),
              PrefixiconTextField(prefixText: "二维码编号",hintText: "请输入二维码编号",textEditingController: numberController,),
              PrefixiconTextField(prefixText: "用户唯一标识",hintText: "请输入用户唯一标识",textEditingController: openidController,),
              PrefixiconTextField(prefixText: "床头柜ID",hintText: "请输入床头柜ID",textEditingController: tableIdController,),
              PrefixiconTextField(prefixText: "状态 1-待付款 2-已付款",hintText: "请输入状态 1-待付款 2-已付款",textEditingController: statusController,),
              PrefixiconTextField(prefixText: "使用时长（秒）",hintText: "请输入使用时长（秒）",textEditingController: timeController,),
              PrefixiconTextField(prefixText: "消费金额",hintText: "请输入消费金额",textEditingController: moneyController,),
              PrefixiconTextField(prefixText: "开关锁次数",hintText: "请输入开关锁次数",textEditingController: numController,),
              PrefixiconTextField(prefixText: "",hintText: "请输入",textEditingController: createdAtController,),
              PrefixiconTextField(prefixText: "",hintText: "请输入",textEditingController: updatedAtController,),
              PrefixiconTextField(prefixText: "付款时间",hintText: "请输入付款时间",textEditingController: payAtController,),
              PrefixiconTextField(prefixText: "关锁时间",hintText: "请输入关锁时间",textEditingController: endAtController,),
              PrefixiconTextField(prefixText: "退款状态",hintText: "请输入退款状态",textEditingController: refundStatusController,),
              PrefixiconTextField(prefixText: "锁类型  默认1 感应锁  2蓝牙锁 ",hintText: "请输入锁类型  默认1 感应锁  2蓝牙锁 ",textEditingController: typeController,),
              PrefixiconTextField(prefixText: "付款方式  0 直接付费,按天付费  1押金,按押金付费",hintText: "请输入付款方式  0 直接付费,按天付费  1押金,按押金付费",textEditingController: payTypeController,),
              PrefixiconTextField(prefixText: "免费使用时间",hintText: "请输入免费使用时间",textEditingController: freeTrialTimeController,),
              PrefixiconTextField(prefixText: "消费金额",hintText: "请输入消费金额",textEditingController: hourMoneyController,),
              PrefixiconTextField(prefixText: "用户id",hintText: "请输入用户id",textEditingController: userIdController,),
              PrefixiconTextField(prefixText: "订单结束时间",hintText: "请输入订单结束时间",textEditingController: useEndAtController,),
              PrefixiconTextField(prefixText: "使用时间id",hintText: "请输入使用时间id",textEditingController: usetimeIdController,),
              PrefixiconTextField(prefixText: "状态 1-待命中 2-使用中 3-维修中 4-禁用中 5开锁故障",hintText: "请输入状态 1-待命中 2-使用中 3-维修中 4-禁用中 5开锁故障",textEditingController: tableStatusController,),
              PrefixiconTextField(prefixText: "医院名称",hintText: "请输入医院名称",textEditingController: hospitalNameController,),
              PrefixiconTextField(prefixText: "科室名称",hintText: "请输入科室名称",textEditingController: officeNameController,),
              PrefixiconTextField(prefixText: "房间号名称",hintText: "请输入房间号名称",textEditingController: roomNameController,),
              PrefixiconTextField(prefixText: "医院ID",hintText: "请输入医院ID",textEditingController: hospitalIdController,),
              PrefixiconTextField(prefixText: "科室ID",hintText: "请输入科室ID",textEditingController: officeIdController,),
              PrefixiconTextField(prefixText: "房间号ID",hintText: "请输入房间号ID",textEditingController: roomIdController,),
              PrefixiconTextField(prefixText: "用户绑定的手机号",hintText: "请输入用户绑定的手机号",textEditingController: phoneNumberController,),
              PrefixiconTextField(prefixText: "退款时间",hintText: "请输入退款时间",textEditingController: refundAtController,),
              PrefixiconTextField(prefixText: "支付平台",hintText: "请输入支付平台",textEditingController: payPlatformController,),
              PrefixiconTextField(prefixText: "床号id",hintText: "请输入床号id",textEditingController: bedIdController,),
              PrefixiconTextField(prefixText: "床号名称",hintText: "请输入床号名称",textEditingController: bedNameController,),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideOrderViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideOrderInfo(dto.id,success: (BedsideBedsideOrderListModelData info) {
                        orderSnController.text = info.orderSn;
                        numberController.text = info.number;
                        openidController.text = info.openid;
                        tableIdController.text = info.tableId.toString();
                        statusController.text = info.status.toString();
                        timeController.text = info.time.toString();
                        moneyController.text = info.money.toString();
                        numController.text = info.num.toString();
                        createdAtController.text = info.createdAt;
                        updatedAtController.text = info.updatedAt;
                        payAtController.text = info.payAt;
                        endAtController.text = info.endAt;
                        refundStatusController.text = info.refundStatus.toString();
                        typeController.text = info.type.toString();
                        payTypeController.text = info.payType.toString();
                        freeTrialTimeController.text = info.freeTrialTime.toString();
                        hourMoneyController.text = info.hourMoney.toString();
                        userIdController.text = info.userId.toString();
                        useEndAtController.text = info.useEndAt;
                        usetimeIdController.text = info.usetimeId.toString();
                        tableStatusController.text = info.tableStatus.toString();
                        hospitalNameController.text = info.hospitalName;
                        officeNameController.text = info.officeName;
                        roomNameController.text = info.roomName;
                        hospitalIdController.text = info.hospitalId.toString();
                        officeIdController.text = info.officeId.toString();
                        roomIdController.text = info.roomId.toString();
                        phoneNumberController.text = info.phoneNumber;
                        refundAtController.text = info.refundAt;
                        payPlatformController.text = info.payPlatform.toString();
                        bedIdController.text = info.bedId.toString();
                        bedNameController.text = info.bedName;
                      });
                    }
                  },
                  viewModel: _bedsideBedsideOrderViewModel,
                  builder: (c,BedsideBedsideOrderViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                          if(model.loading) {
                            return;
                          }
                        if (orderSnController.text.isEmpty) {
                            EasyLoading.showToast("订单号不能为空");
                            return;
                        }
                        if (numberController.text.isEmpty) {
                            EasyLoading.showToast("二维码编号不能为空");
                            return;
                        }
                        if (openidController.text.isEmpty) {
                            EasyLoading.showToast("用户唯一标识不能为空");
                            return;
                        }
                        if (tableIdController.text.isEmpty) {
                            EasyLoading.showToast("床头柜ID不能为空");
                            return;
                        }
                        if (statusController.text.isEmpty) {
                            EasyLoading.showToast("状态 1-待付款 2-已付款不能为空");
                            return;
                        }
                        if (timeController.text.isEmpty) {
                            EasyLoading.showToast("使用时长（秒）不能为空");
                            return;
                        }
                        if (moneyController.text.isEmpty) {
                            EasyLoading.showToast("消费金额不能为空");
                            return;
                        }
                        if (numController.text.isEmpty) {
                            EasyLoading.showToast("开关锁次数不能为空");
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
                        if (payAtController.text.isEmpty) {
                            EasyLoading.showToast("付款时间不能为空");
                            return;
                        }
                        if (endAtController.text.isEmpty) {
                            EasyLoading.showToast("关锁时间不能为空");
                            return;
                        }
                        if (refundStatusController.text.isEmpty) {
                            EasyLoading.showToast("退款状态不能为空");
                            return;
                        }
                        if (typeController.text.isEmpty) {
                            EasyLoading.showToast("锁类型  默认1 感应锁  2蓝牙锁 不能为空");
                            return;
                        }
                        if (payTypeController.text.isEmpty) {
                            EasyLoading.showToast("付款方式  0 直接付费,按天付费  1押金,按押金付费不能为空");
                            return;
                        }
                        if (freeTrialTimeController.text.isEmpty) {
                            EasyLoading.showToast("免费使用时间不能为空");
                            return;
                        }
                        if (hourMoneyController.text.isEmpty) {
                            EasyLoading.showToast("消费金额不能为空");
                            return;
                        }
                        if (userIdController.text.isEmpty) {
                            EasyLoading.showToast("用户id不能为空");
                            return;
                        }
                        if (useEndAtController.text.isEmpty) {
                            EasyLoading.showToast("订单结束时间不能为空");
                            return;
                        }
                        if (usetimeIdController.text.isEmpty) {
                            EasyLoading.showToast("使用时间id不能为空");
                            return;
                        }
                        if (tableStatusController.text.isEmpty) {
                            EasyLoading.showToast("状态 1-待命中 2-使用中 3-维修中 4-禁用中 5开锁故障不能为空");
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
                        if (phoneNumberController.text.isEmpty) {
                            EasyLoading.showToast("用户绑定的手机号不能为空");
                            return;
                        }
                        if (refundAtController.text.isEmpty) {
                            EasyLoading.showToast("退款时间不能为空");
                            return;
                        }
                        if (payPlatformController.text.isEmpty) {
                            EasyLoading.showToast("支付平台不能为空");
                            return;
                        }
                        if (bedIdController.text.isEmpty) {
                            EasyLoading.showToast("床号id不能为空");
                            return;
                        }
                        if (bedNameController.text.isEmpty) {
                            EasyLoading.showToast("床号名称不能为空");
                            return;
                        }

                        String orderSn = orderSnController.text;
                        String number = numberController.text;
                        String openid = openidController.text;
                        String tableId = tableIdController.text;
                        String status = statusController.text;
                        String time = timeController.text;
                        String money = moneyController.text;
                        String num = numController.text;
                        String createdAt = createdAtController.text;
                        String updatedAt = updatedAtController.text;
                        String payAt = payAtController.text;
                        String endAt = endAtController.text;
                        String refundStatus = refundStatusController.text;
                        String type = typeController.text;
                        String payType = payTypeController.text;
                        String freeTrialTime = freeTrialTimeController.text;
                        String hourMoney = hourMoneyController.text;
                        String userId = userIdController.text;
                        String useEndAt = useEndAtController.text;
                        String usetimeId = usetimeIdController.text;
                        String tableStatus = tableStatusController.text;
                        String hospitalName = hospitalNameController.text;
                        String officeName = officeNameController.text;
                        String roomName = roomNameController.text;
                        String hospitalId = hospitalIdController.text;
                        String officeId = officeIdController.text;
                        String roomId = roomIdController.text;
                        String phoneNumber = phoneNumberController.text;
                        String refundAt = refundAtController.text;
                        String payPlatform = payPlatformController.text;
                        String bedId = bedIdController.text;
                        String bedName = bedNameController.text;

                        BedsideBedsideOrderListModelData data = BedsideBedsideOrderListModelData(
                          id: dto.id,
                            orderSn: orderSn,
                            number: number,
                            openid: openid,
                            tableId: tableId.isEmpty ? null : int.parse(tableId),
                            status: status.isEmpty ? null : int.parse(status),
                            time: time.isEmpty ? null : int.parse(time),
                            money: money.isEmpty ? null : double.parse(money),
                            num: num.isEmpty ? null : int.parse(num),
                            createdAt: createdAt,
                            updatedAt: updatedAt,
                            payAt: payAt,
                            endAt: endAt,
                            refundStatus: refundStatus.isEmpty ? null : int.parse(refundStatus),
                            type: type.isEmpty ? null : int.parse(type),
                            payType: payType.isEmpty ? null : int.parse(payType),
                            freeTrialTime: freeTrialTime.isEmpty ? null : int.parse(freeTrialTime),
                            hourMoney: hourMoney.isEmpty ? null : double.parse(hourMoney),
                            userId: userId.isEmpty ? null : int.parse(userId),
                            useEndAt: useEndAt,
                            usetimeId: usetimeId.isEmpty ? null : int.parse(usetimeId),
                            tableStatus: tableStatus.isEmpty ? null : int.parse(tableStatus),
                            hospitalName: hospitalName,
                            officeName: officeName,
                            roomName: roomName,
                            hospitalId: hospitalId.isEmpty ? null : int.parse(hospitalId),
                            officeId: officeId.isEmpty ? null : int.parse(officeId),
                            roomId: roomId.isEmpty ? null : int.parse(roomId),
                            phoneNumber: phoneNumber,
                            refundAt: refundAt,
                            payPlatform: payPlatform.isEmpty ? null : int.parse(payPlatform),
                            bedId: bedId.isEmpty ? null : int.parse(bedId),
                            bedName: bedName,
                        );
                        model.bedsideBedsideOrderSaveUpdate(data,success: (value) {
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
