import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_order_unlock_list_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_order_unlock/bedside_bedside_order_unlock_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideOrderUnlockSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsideorderunlockSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideBedsideOrderUnlockSaveOrUpadtePage({this.dto});

  final BedsideBedsideOrderUnlockViewModel _bedsideBedsideOrderUnlockViewModel = BedsideBedsideOrderUnlockViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController orderSnController = new TextEditingController(text: "");
  final TextEditingController tableIdController = new TextEditingController(text: "");
  final TextEditingController numberController = new TextEditingController(text: "");
  final TextEditingController commandIdController = new TextEditingController(text: "");
  final TextEditingController openidController = new TextEditingController(text: "");
  final TextEditingController statusController = new TextEditingController(text: "");
  final TextEditingController typeController = new TextEditingController(text: "");
  final TextEditingController timeController = new TextEditingController(text: "");
  final TextEditingController moneyController = new TextEditingController(text: "");
  final TextEditingController contentController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");
  final TextEditingController sendAtController = new TextEditingController(text: "");
  final TextEditingController sentAtController = new TextEditingController(text: "");
  final TextEditingController startAtController = new TextEditingController(text: "");
  final TextEditingController endAtController = new TextEditingController(text: "");
  final TextEditingController tableTypeController = new TextEditingController(text: "");
  final TextEditingController usertimEndAtController = new TextEditingController(text: "");

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

              PrefixiconTextField(prefixText: "订单号",hintText: "请输入订单号",textEditingController: orderSnController,),
              PrefixiconTextField(prefixText: "床头柜ID",hintText: "请输入床头柜ID",textEditingController: tableIdController,),
              PrefixiconTextField(prefixText: "二维码编号",hintText: "请输入二维码编号",textEditingController: numberController,),
              PrefixiconTextField(prefixText: "命令ID",hintText: "请输入命令ID",textEditingController: commandIdController,),
              PrefixiconTextField(prefixText: "用户唯一标识",hintText: "请输入用户唯一标识",textEditingController: openidController,),
              PrefixiconTextField(prefixText: "开锁状态 1-未下发 2-已下发 3-已发送 4-已送达，已开锁 5-已关锁 6-下发失败",hintText: "请输入开锁状态 1-未下发 2-已下发 3-已发送 4-已送达，已开锁 5-已关锁 6-下发失败",textEditingController: statusController,),
              PrefixiconTextField(prefixText: "开锁方式 1-付费开锁 2-钥匙开锁",hintText: "请输入开锁方式 1-付费开锁 2-钥匙开锁",textEditingController: typeController,),
              PrefixiconTextField(prefixText: "使用时长（秒）",hintText: "请输入使用时长（秒）",textEditingController: timeController,),
              PrefixiconTextField(prefixText: "消费金额",hintText: "请输入消费金额",textEditingController: moneyController,),
              PrefixiconTextField(prefixText: "",hintText: "请输入",textEditingController: contentController,),
              PrefixiconTextField(prefixText: "发起开锁时间",hintText: "请输入发起开锁时间",textEditingController: createdAtController,),
              PrefixiconTextField(prefixText: "",hintText: "请输入",textEditingController: updatedAtController,),
              PrefixiconTextField(prefixText: "命令下发时间",hintText: "请输入命令下发时间",textEditingController: sendAtController,),
              PrefixiconTextField(prefixText: "命令发送时间",hintText: "请输入命令发送时间",textEditingController: sentAtController,),
              PrefixiconTextField(prefixText: "实际开锁时间",hintText: "请输入实际开锁时间",textEditingController: startAtController,),
              PrefixiconTextField(prefixText: "关锁时间",hintText: "请输入关锁时间",textEditingController: endAtController,),
              PrefixiconTextField(prefixText: "锁类型  1nb锁   2蓝牙锁",hintText: "请输入锁类型  1nb锁   2蓝牙锁",textEditingController: tableTypeController,),
              PrefixiconTextField(prefixText: "医院规定关锁时间",hintText: "请输入医院规定关锁时间",textEditingController: usertimEndAtController,),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideOrderUnlockViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideOrderUnlockInfo(dto.id,success: (BedsideBedsideOrderUnlockListModelData info) {
                        orderSnController.text = info.orderSn;
                        tableIdController.text = info.tableId.toString();
                        numberController.text = info.number;
                        commandIdController.text = info.commandId;
                        openidController.text = info.openid;
                        statusController.text = info.status.toString();
                        typeController.text = info.type.toString();
                        timeController.text = info.time.toString();
                        moneyController.text = info.money.toString();
                        contentController.text = info.content;
                        createdAtController.text = info.createdAt;
                        updatedAtController.text = info.updatedAt;
                        sendAtController.text = info.sendAt;
                        sentAtController.text = info.sentAt;
                        startAtController.text = info.startAt;
                        endAtController.text = info.endAt;
                        tableTypeController.text = info.tableType.toString();
                        usertimEndAtController.text = info.usertimEndAt;
                      });
                    }
                  },
                  viewModel: _bedsideBedsideOrderUnlockViewModel,
                  builder: (c,BedsideBedsideOrderUnlockViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                          if(model.loading) {
                            return;
                          }
                        if (orderSnController.text.isEmpty) {
                            EasyLoading.showToast("订单号不能为空");
                            return;
                        }
                        if (tableIdController.text.isEmpty) {
                            EasyLoading.showToast("床头柜ID不能为空");
                            return;
                        }
                        if (numberController.text.isEmpty) {
                            EasyLoading.showToast("二维码编号不能为空");
                            return;
                        }
                        if (commandIdController.text.isEmpty) {
                            EasyLoading.showToast("命令ID不能为空");
                            return;
                        }
                        if (openidController.text.isEmpty) {
                            EasyLoading.showToast("用户唯一标识不能为空");
                            return;
                        }
                        if (statusController.text.isEmpty) {
                            EasyLoading.showToast("开锁状态 1-未下发 2-已下发 3-已发送 4-已送达，已开锁 5-已关锁 6-下发失败不能为空");
                            return;
                        }
                        if (typeController.text.isEmpty) {
                            EasyLoading.showToast("开锁方式 1-付费开锁 2-钥匙开锁不能为空");
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
                        if (contentController.text.isEmpty) {
                            EasyLoading.showToast("不能为空");
                            return;
                        }
                        if (createdAtController.text.isEmpty) {
                            EasyLoading.showToast("发起开锁时间不能为空");
                            return;
                        }
                        if (updatedAtController.text.isEmpty) {
                            EasyLoading.showToast("不能为空");
                            return;
                        }
                        if (sendAtController.text.isEmpty) {
                            EasyLoading.showToast("命令下发时间不能为空");
                            return;
                        }
                        if (sentAtController.text.isEmpty) {
                            EasyLoading.showToast("命令发送时间不能为空");
                            return;
                        }
                        if (startAtController.text.isEmpty) {
                            EasyLoading.showToast("实际开锁时间不能为空");
                            return;
                        }
                        if (endAtController.text.isEmpty) {
                            EasyLoading.showToast("关锁时间不能为空");
                            return;
                        }
                        if (tableTypeController.text.isEmpty) {
                            EasyLoading.showToast("锁类型  1nb锁   2蓝牙锁不能为空");
                            return;
                        }
                        if (usertimEndAtController.text.isEmpty) {
                            EasyLoading.showToast("医院规定关锁时间不能为空");
                            return;
                        }

                        String orderSn = orderSnController.text;
                        String tableId = tableIdController.text;
                        String number = numberController.text;
                        String commandId = commandIdController.text;
                        String openid = openidController.text;
                        String status = statusController.text;
                        String type = typeController.text;
                        String time = timeController.text;
                        String money = moneyController.text;
                        String content = contentController.text;
                        String createdAt = createdAtController.text;
                        String updatedAt = updatedAtController.text;
                        String sendAt = sendAtController.text;
                        String sentAt = sentAtController.text;
                        String startAt = startAtController.text;
                        String endAt = endAtController.text;
                        String tableType = tableTypeController.text;
                        String usertimEndAt = usertimEndAtController.text;

                        BedsideBedsideOrderUnlockListModelData data = BedsideBedsideOrderUnlockListModelData(
                          id: dto.id,
                            orderSn: orderSn,
                            tableId: tableId.isEmpty ? null : int.parse(tableId),
                            number: number,
                            commandId: commandId,
                            openid: openid,
                            status: status.isEmpty ? null : int.parse(status),
                            type: type.isEmpty ? null : int.parse(type),
                            time: time.isEmpty ? null : int.parse(time),
                            money: money.isEmpty ? null : double.parse(money),
                            content: content,
                            createdAt: createdAt,
                            updatedAt: updatedAt,
                            sendAt: sendAt,
                            sentAt: sentAt,
                            startAt: startAt,
                            endAt: endAt,
                            tableType: tableType.isEmpty ? null : int.parse(tableType),
                            usertimEndAt: usertimEndAt,
                        );
                        model.bedsideBedsideOrderUnlockSaveUpdate(data,success: (value) {
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
