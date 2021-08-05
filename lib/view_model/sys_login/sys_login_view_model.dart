
import 'package:flutter/material.dart';
import 'package:binance_game_app/constant/constant.dart';
import 'package:binance_game_app/dto/sys_login/sys_login_dto.dart';
import 'package:binance_game_app/dto/sys_login/sys_password_dto.dart';
import 'package:binance_game_app/pages/index/index_page.dart';
import 'package:binance_game_app/pages/login/login_page.dart';
import 'package:binance_game_app/utils/cache_util.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class SysLoginViewModel extends BaseViewModel {


  //uuid
  String uuid;
  /// 图片路径
  String captchaJpgUrl;


  void updateCaptchaJpg() {
    this.uuid = DateTime.now().millisecondsSinceEpoch.toString();
    this.captchaJpgUrl = "${Constant.baseUrl}/captcha.jpg?uuid=${uuid}";
    print(this.captchaJpgUrl);
    print(this.uuid);
    super.notifyListeners();
  }
  
  void sysLogin(SysLoginDto dto,{success}) {
    super.openLoading();
    //2s之后关闭
    Future.delayed(Duration(milliseconds: 1500), () {
      if(super.loading) {
        super.closeLoading();
      }
    });
    print("sysLogin start");
    print(dto.toJson());
    Http.getInstance().post(dto.toJson(),path: "/sys/login").then((value){
      super.closeLoading();
      success(value.token);
    }).catchError((err){
      super.closeLoading();
      this.updateCaptchaJpg();
    });
  }

  void sysPassword(SysPasswordDto dto,{success}) {
    //2s之后关闭
    Future.delayed(Duration(milliseconds: 1500), () {
      if(super.loading) {
        super.closeLoading();
      }
    });
    super.openLoading();
    Http.getInstance().postFormData(dto.toJson(),path: "/sys/user/password").then((value){
      success(value);
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
    });

  }

  @override
  String toString() {
    return 'SysLoginViewModel{uuid: $uuid, captchaJpgUrl: $captchaJpgUrl}';
  }

  @override
  void dispose() {
    super.dispose();
  }

}