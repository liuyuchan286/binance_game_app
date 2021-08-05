import 'package:binance_game_app/model/sys_menu_nav_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';


class SysMenuViewModel extends BaseViewModel {

  List<SysMenuNavModel> list;

  void initSysMenuNav() {
    this.sysMenuNav(success: (data){
      list = (data as List).map((e) => SysMenuNavModel.fromJson(e)).where((e) => !e.hidden()).toList();
      print(list);
    });
  }

  void sysMenuNav({success}) {
    super.openLoading();
    Map<String, dynamic> queryParameters = {
    };
    Http.getInstance().getDyJson(queryParameters,path: "/sys/menu/nav").then((value){
      success(value['menuList']);
      super.closeLoading();
    }).catchError((onError) => super.closeLoading());
  }

}