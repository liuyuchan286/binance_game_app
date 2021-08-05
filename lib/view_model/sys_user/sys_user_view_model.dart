
import 'package:binance_game_app/model/sys_user_info_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class SysUserViewModel extends BaseViewModel{

  SysUserInfoModel sysUserInfoModel;

  void initUserInfo() {
    this.sysUserInfo(success: (data) {
      print(data);
      sysUserInfoModel = SysUserInfoModel.fromJson(data);
    });
  }

  void sysUserInfo({success}) {
    super.openLoading();
    Map<String, dynamic> queryParameters = {
    };
    Http.getInstance().getDyJson(queryParameters,path: "/sys/user/info").then((value){
      success(value['user']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

}