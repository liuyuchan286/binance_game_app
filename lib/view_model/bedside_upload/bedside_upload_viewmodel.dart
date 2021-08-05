

import 'package:dio/dio.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideUploadViewModel extends BaseViewModel{
  
  
  
  
  Future<void> upload(String file,{success,error}) async {
    super.valueNotifier.value = true;
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file),
    });
    Http.getInstance().postFormData(formData,path: "/app/file/upload").then((value){
      success(value.data);
      super.valueNotifier.value = false;
    }).catchError((onError){
      error(onError);
      super.valueNotifier.value = false;
    });
  }
  
  
}