import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/sys_login/sys_login_dto.dart';
import 'package:binance_game_app/pages/index/index_page.dart';
import 'package:binance_game_app/utils/cache_util.dart';
import 'package:binance_game_app/view_model/sys_login/sys_login_view_model.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';

class LoginPage extends StatelessWidget {

  static const routeName = '/loginPage';

  SysLoginViewModel _sysLoginViewModel = SysLoginViewModel();

  TextEditingController _username = TextEditingController(text: "");
  TextEditingController _password = TextEditingController(text: "");
  TextEditingController _captcha = TextEditingController();


  @override
  Widget build(BuildContext context) {
    print("LoginPage build");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          //关闭键盘
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                children: [
                  SizedBox(height: 84.h,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("登录",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  SizedBox(height: 41.h,),
                  TextFormField(
                    controller: _username,
                    decoration: InputDecoration(
                        hintText: "请输入账号",
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "请输入密码",
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  TextField(
                    controller: _captcha,
                    decoration: InputDecoration(
                      suffixIcon: Container(
                        margin: EdgeInsets.symmetric(vertical: 8.5.h),
                        width: 102.w,
                        height: 25.h,
                        color: Colors.black45,
                        child: ProviderWidget(
                          viewModel: _sysLoginViewModel,
                          init: (SysLoginViewModel model) {
                            _sysLoginViewModel = model;
                            model.updateCaptchaJpg();
                          },
                          builder: (c,SysLoginViewModel model,_) {
                            _sysLoginViewModel = model;
                            return InkWell(
                              onTap: () {
                                model.updateCaptchaJpg();
                              },
                              child: Image.network(model.captchaJpgUrl,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress,) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return CupertinoActivityIndicator();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      hintText: "请输入验证码",
                    ),
                  ),
                  SizedBox(height: 100.h,),
                  Container(
                    width: double.infinity,
                    child: ValueListenableBuilder(
                      valueListenable: _sysLoginViewModel.valueNotifier,
                      builder: (BuildContext context, value, Widget child) {
                        return TextButton(
                          onPressed: (){
                            print(_sysLoginViewModel);
                            if(_sysLoginViewModel.loading) return;
                            if(_username.text.isEmpty) {
                              EasyLoading.showToast('请输入账号');
                              return;
                            }
                            if(_password.text.isEmpty) {
                              EasyLoading.showToast('请输入密码');
                              return;
                            }
                            if(_captcha.text.isEmpty) {
                              EasyLoading.showToast('请输入验证码');
                              return;
                            }

                            SysLoginDto sysLoginDto = SysLoginDto(
                                username: _username.text,
                                password: _password.text,
                                captcha: _captcha.text,
                                uuid: _sysLoginViewModel.uuid
                            );

                            _sysLoginViewModel.sysLogin(sysLoginDto,success: (data) {
                              CacheUtil.saveData<String>("token", data);
                              Navigator.pushNamedAndRemoveUntil(context, IndexPage.routeName,(Route<dynamic> route) => false);
                            });
                          },
                          child: _sysLoginViewModel.loading ? CupertinoActivityIndicator() : Text(
                              "登录"
                          ),
                        );
                      },

                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
