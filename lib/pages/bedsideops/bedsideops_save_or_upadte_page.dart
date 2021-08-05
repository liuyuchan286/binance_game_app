import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedsideops_list_model.dart';
import 'package:binance_game_app/view_model/bedside_bedsideops/bedside_bedsideops_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideopsSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsideopsSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideopsSaveOrUpadtePage({this.dto});

  final BedsideBedsideopsViewModel _bedsideBedsideopsViewModel = BedsideBedsideopsViewModel();

  final TextEditingController nameController = new TextEditingController(text: "");
  final TextEditingController phoneController = new TextEditingController(text: "");
  final TextEditingController passwordController = new TextEditingController(text: "");
  final TextEditingController addressController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("运维-${dto.titleStr}",
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
              PrefixiconTextField(prefixText: "运维人员名称",hintText: "请输入运维人员名称",textEditingController: nameController,),
              PrefixiconTextField(prefixText: "手机号",hintText: "请输入手机号",textEditingController: phoneController,),
              PrefixiconTextField(prefixText: "密码",hintText: "请输入密码",textEditingController: passwordController,),
              PrefixiconTextField(prefixText: "联系地址",hintText: "请输入联系地址",textEditingController: addressController,),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideopsViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideopsInfo(dto.id,success: (BedsideBedsideopsListModelData info) {
                        nameController.text = info.name;
                        phoneController.text = info.phone;
                        passwordController.text = info.password;
                        addressController.text = info.address;
                      });
                    }
                  },
                  viewModel: _bedsideBedsideopsViewModel,
                  builder: (c,BedsideBedsideopsViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                        if (nameController.text.isEmpty) {
                          EasyLoading.showToast("运维人员名称不能为空");
                          return;
                        }

                        if (phoneController.text.isEmpty) {
                          EasyLoading.showToast("手机号不能为空");
                          return;
                        }

                        if (passwordController.text.isEmpty) {
                          EasyLoading.showToast("密码不能为空");
                          return;
                        }

                        if (addressController.text.isEmpty) {
                          EasyLoading.showToast("联系地址不能为空");
                          return;
                        }

                        String name = nameController.text;
                        String phone = phoneController.text;
                        String password = passwordController.text;
                        String address = addressController.text;

                        BedsideBedsideopsListModelData data = BedsideBedsideopsListModelData(
                          id: dto.id,
                          name: name,
                          phone: phone,
                          password: password,
                          address: address
                        );
                        model.bedsideBedsideopsSaveUpdate(data,success: (value) {
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
