
import 'package:binance_game_app/model/enum/enum_all_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class EnumViewModel extends BaseViewModel{

  EnumAllModel enumAllModel;

  void appEnumsAll() {
    super.openLoading();
    Http.getInstance().getDyJson({},path: "/app/enums/all").then((value){
      enumAllModel = EnumAllModel.fromJson(value);
      super.closeLoading();
    }).catchError((onError) {
      super.closeLoading();
    });
  }


}