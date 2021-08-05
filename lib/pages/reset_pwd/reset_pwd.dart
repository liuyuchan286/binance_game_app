import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:binance_game_app/dto/sys_login/sys_password_dto.dart';
import 'package:binance_game_app/pages/login/login_page.dart';
import 'package:binance_game_app/utils/cache_util.dart';
import 'package:binance_game_app/view_model/sys_login/sys_login_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';

class ResetPwd extends StatelessWidget {

  static const routeName = '/resetPwd';

  final TextEditingController textEditingController = new TextEditingController(text: "");


  final TextEditingController passwordEditingController = new TextEditingController(text: "");

  final TextEditingController newPasswordEditingController = new TextEditingController(text: "");

  final TextEditingController reNewPasswordEditingController = new TextEditingController(text: "");

  final String username;


  ResetPwd({this.username});

  @override
  Widget build(BuildContext context) {
    textEditingController.text = this.username;
    return Scaffold(
      appBar: AppBar(
        title: Text("修改密码",
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
              PrefixiconTextField(prefixText: "账号",hintText:   "请输入原密码",textEditingController: textEditingController,readOnly: true,required: false,),
              PrefixiconTextField(prefixText: "原密码",hintText: "请输入原密码",textEditingController: passwordEditingController,obscureText: true,),
              PrefixiconTextField(prefixText: "新密码",hintText: "请输入新密码",textEditingController: newPasswordEditingController,obscureText: true,),
              PrefixiconTextField(prefixText: "确认密码",hintText: "请再次输入密码",textEditingController: reNewPasswordEditingController,obscureText: true,),
              SizedBox(height: 345.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (SysLoginViewModel model){

                  },
                  viewModel: SysLoginViewModel(),
                  builder: (_,SysLoginViewModel model,___){
                    return TextButton(
                      onPressed: (){
                        if(model.loading)return;
                        if (passwordEditingController.text.isEmpty) {
                          EasyLoading.showToast("原密码不能为空");
                          return;
                        }

                        if (newPasswordEditingController.text.isEmpty) {
                          EasyLoading.showToast("新密码不能为空");
                          return;
                        }

                        if (reNewPasswordEditingController.text.isEmpty) {
                          EasyLoading.showToast("确认新密码不能为空");
                          return;
                        }

                        if (reNewPasswordEditingController.text != newPasswordEditingController.text) {
                          EasyLoading.showToast("两次新密码输入的不一致");
                          return;
                        }

                        SysPasswordDto dto = SysPasswordDto();
                        dto.password = passwordEditingController.text;
                        dto.newPassword = newPasswordEditingController.text;

                        model.sysPassword(dto,success: (value){
                          CacheUtil.removeData<String>('token');
                          EasyLoading.showToast("修改成功");
                          Navigator.pushNamedAndRemoveUntil(context, LoginPage.routeName,(Route<dynamic> route) => false);
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
