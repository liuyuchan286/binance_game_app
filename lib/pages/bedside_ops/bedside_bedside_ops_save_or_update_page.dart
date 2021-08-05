import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_ops_list_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_ops/bedside_bedside_ops_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideOpsSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsideopsSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideBedsideOpsSaveOrUpadtePage({this.dto});

  final BedsideBedsideOpsViewModel _bedsideBedsideOpsViewModel = BedsideBedsideOpsViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController nameController = new TextEditingController(text: "");
  final TextEditingController phoneController = new TextEditingController(text: "");
  final TextEditingController passwordController = new TextEditingController(text: "");
  final TextEditingController addressController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");
  final TextEditingController deletedAtController = new TextEditingController(text: "");
  final TextEditingController isManageController = new TextEditingController(text: "");

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
              PrefixiconTextField(prefixText: "密码",required: false,hintText: "请输入密码",textEditingController: passwordController,),
              PrefixiconTextField(prefixText: "联系地址",hintText: "请输入联系地址",textEditingController: addressController,),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideOpsViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideOpsInfo(dto.id,success: (BedsideBedsideOpsListModelData info) {
                        nameController.text = info.name;
                        phoneController.text = info.phone;
                        passwordController.text = info.password;
                        addressController.text = info.address;
                        createdAtController.text = info.createdAt;
                        updatedAtController.text = info.updatedAt;
                        deletedAtController.text = info.deletedAt;
                        isManageController.text = (info.isManage ?? "").toString();
                      });
                    }
                  },
                  viewModel: _bedsideBedsideOpsViewModel,
                  builder: (c,BedsideBedsideOpsViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                        if(model.loading) {
                          return;
                        }
                        if (nameController.text.isEmpty) {
                            EasyLoading.showToast("运维人员名称不能为空");
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

                        String name = nameController.text;
                        String phone = phoneController.text;
                        String password = passwordController.text;
                        String address = addressController.text;
                        String createdAt = createdAtController.text;
                        String updatedAt = updatedAtController.text;
                        String deletedAt = deletedAtController.text;
                        String isManage = isManageController.text;

                        BedsideBedsideOpsListModelData data = BedsideBedsideOpsListModelData(
                          id: dto.id,
                            name: name,
                            phone: phone,
                            password: password,
                            address: address,
                            createdAt: createdAt,
                            updatedAt: updatedAt,
                            deletedAt: deletedAt,
                            isManage: isManage.isEmpty ? null : int.parse(isManage),
                        );
                        model.bedsideBedsideOpsSaveUpdate(data,success: (value) {
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
