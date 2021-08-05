import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_agent_list_model.dart';
import 'package:binance_game_app/model/radio_list_title_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_agent/bedside_bedside_agent_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';
import 'package:binance_game_app/widget/radio_group_list.dart';


class BedsideBedsideAgentSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsideagentSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideBedsideAgentSaveOrUpadtePage({this.dto});

  final BedsideBedsideAgentViewModel _bedsideBedsideAgentViewModel = BedsideBedsideAgentViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController nameController = new TextEditingController(text: "");
  final TextEditingController typeController = new TextEditingController(text: "1");
  final TextEditingController contactController = new TextEditingController(text: "");
  final TextEditingController phoneController = new TextEditingController(text: "");
  final TextEditingController passwordController = new TextEditingController(text: "");
  final TextEditingController addressController = new TextEditingController(text: "");
  final TextEditingController moneyController = new TextEditingController(text: "");
  final TextEditingController rememberTokenController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");
  final TextEditingController deletedAtController = new TextEditingController(text: "");
  final TextEditingController sysUserIdController = new TextEditingController(text: "");
  final TextEditingController withdrawableMoneyController = new TextEditingController(text: "");
  final TextEditingController withdrawnMoneyController = new TextEditingController(text: "");
  final TextEditingController totalRevenueMoneyController = new TextEditingController(text: "");
  final TextEditingController tobeCreditedMoneyController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("代理商记录表-${dto.titleStr}",
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

              PrefixiconTextField(prefixText: "代理商名称",hintText: "请输入代理商名称",textEditingController: nameController,),
              PrefixiconTextField(prefixText: "类型",hintText: "",readOnly: true,suffixIcon: RadioGroupList(
                groupValue: 1,
                onChanged: (value) {
                  typeController.text = value.toString();
                },
                list: [
                  RadioListTitleModel(value: 1,title: "个人"),
                  RadioListTitleModel(value: 2,title: "企业"),
                ],
              ),
              ),


              PrefixiconTextField(prefixText: "联系人",hintText: "请输入联系人",textEditingController: contactController,),
              PrefixiconTextField(prefixText: "手机号",hintText: "请输入手机号",textEditingController: phoneController,),
              PrefixiconTextField(prefixText: "密码",hintText: "请输入密码",required: false,textEditingController: passwordController,),
              PrefixiconTextField(prefixText: "联系地址",hintText: "请输入联系地址",textEditingController: addressController,),
              PrefixiconTextField(prefixText: "保证金",hintText: "请输入保证金",textEditingController: moneyController,),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideAgentViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideAgentInfo(dto.id,success: (BedsideBedsideAgentListModelData info) {
                        nameController.text = info.name;
                        typeController.text = info.type.toString();
                        contactController.text = info.contact;
                        phoneController.text = info.phone;
                        passwordController.text = info.password;
                        addressController.text = info.address;
                        moneyController.text = info.money.toString();
                        rememberTokenController.text = info.rememberToken;
                        createdAtController.text = info.createdAt;
                        updatedAtController.text = info.updatedAt;
                        deletedAtController.text = info.deletedAt;
                        sysUserIdController.text = info.sysUserId.toString();
                        withdrawableMoneyController.text = info.withdrawableMoney.toString();
                        withdrawnMoneyController.text = info.withdrawnMoney.toString();
                        totalRevenueMoneyController.text = info.totalRevenueMoney.toString();
                        tobeCreditedMoneyController.text = info.tobeCreditedMoney.toString();
                      });
                    }
                  },
                  viewModel: _bedsideBedsideAgentViewModel,
                  builder: (c,BedsideBedsideAgentViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                          if(model.loading) {
                            return;
                          }
                        if (nameController.text.isEmpty) {
                            EasyLoading.showToast("代理商名称不能为空");
                            return;
                        }
                        if (typeController.text.isEmpty) {
                            EasyLoading.showToast("类型 1-个人 2-企业不能为空");
                            return;
                        }
                        if (contactController.text.isEmpty) {
                            EasyLoading.showToast("联系人不能为空");
                            return;
                        }
                        if (phoneController.text.isEmpty) {
                            EasyLoading.showToast("手机号不能为空");
                            return;
                        }
                        if (addressController.text.isEmpty) {
                            EasyLoading.showToast("联系地址不能为空");
                            return;
                        }
                        if (moneyController.text.isEmpty) {
                            EasyLoading.showToast("保证金不能为空");
                            return;
                        }

                        String name = nameController.text;
                        String type = typeController.text;
                        String contact = contactController.text;
                        String phone = phoneController.text;
                        String password = passwordController.text;
                        String address = addressController.text;
                        String money = moneyController.text;
                        String rememberToken = rememberTokenController.text;
                        String createdAt = createdAtController.text;
                        String updatedAt = updatedAtController.text;
                        String deletedAt = deletedAtController.text;
                        String sysUserId = sysUserIdController.text;
                        String withdrawableMoney = withdrawableMoneyController.text;
                        String withdrawnMoney = withdrawnMoneyController.text;
                        String totalRevenueMoney = totalRevenueMoneyController.text;
                        String tobeCreditedMoney = tobeCreditedMoneyController.text;

                        BedsideBedsideAgentListModelData data = BedsideBedsideAgentListModelData(
                          id: dto.id,
                            name: name,
                            type: type.isEmpty ? null : int.parse(type),
                            contact: contact,
                            phone: phone,
                            password: password,
                            address: address,
                            money: money.isEmpty ? null : int.parse(money),
                            rememberToken: rememberToken,
                            createdAt: createdAt,
                            updatedAt: updatedAt,
                            deletedAt: deletedAt,
                            sysUserId: sysUserId.isEmpty ? null : int.parse(sysUserId),
                            withdrawableMoney: withdrawableMoney.isEmpty ? null : double.parse(withdrawableMoney),
                            withdrawnMoney: withdrawnMoney.isEmpty ? null : double.parse(withdrawnMoney),
                            totalRevenueMoney: totalRevenueMoney.isEmpty ? null : double.parse(totalRevenueMoney),
                            tobeCreditedMoney: tobeCreditedMoney.isEmpty ? null : double.parse(tobeCreditedMoney),
                        );
                        model.bedsideBedsideAgentSaveUpdate(data,success: (value) {
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
