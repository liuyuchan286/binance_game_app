import 'package:dio/dio.dart';
import 'package:binance_game_app/constant/constant.dart';
import 'package:binance_game_app/model/base/ret_model.dart';

import 'interceptor/token_interceptor.dart';

class Http {

  /// 单例对象
  static Http _instance;
  final Dio dio;
  /// 内部构造方法，可避免外部暴露构造函数，进行实例化
  Http._internal(this.dio);

  /// 工厂构造方法，这里使用命名构造函数方式进行声明
  factory Http.getInstance() => _getInstance();

  /// 获取单例内部方法
  static _getInstance() {
    // 只能有一个实例
    if (_instance == null) {
      var options = BaseOptions(
        baseUrl: '${Constant.baseUrl}',
        connectTimeout: 20000,
        receiveTimeout: 20000,
      );
      Dio dio = Dio(options);
      _instance = Http._internal(dio);
      _instance.dio.interceptors.add(new TokenInterceptor());
    }
    return _instance;
  }



  //get方法
  Future<RetModel> get<T>(Map<String, dynamic> queryParameters,{String path = "",Options options}) async{
    queryParameters['t'] = DateTime.now().millisecondsSinceEpoch;
    Response response = await dio.get(path,queryParameters: queryParameters,options: options);
    print(response.data);
    RetModel retModel =  RetModel.fromJson(response.data);
    return retModel;
  }

  //get方法直接返回json数据
  Future<dynamic> getDyJson<T>(Map<String, dynamic> queryParameters,{String path = "",Options options}) async{
    queryParameters['t'] = DateTime.now().millisecondsSinceEpoch;
    Response response = await dio.get(path,queryParameters: queryParameters,options: options);
    print(response.data);
    return response.data;
  }

  //post方法
  Future<RetModel> post(dynamic data,{Options options,String path = "",}) async{
    Response response = await dio.post(path,data: data,options: options);
    print(response.data);
    RetModel retModel =  RetModel.fromJson(response.data);
    return retModel;
  }

  //post方法
  Future<RetModel> postFormData(var formData,{Options options,String path = "",}) async{
    Response response = await dio.post(path,data: formData,options: options);
    print(response.data);
    RetModel retModel =  RetModel.fromJson(response.data);
    return retModel;
  }


}