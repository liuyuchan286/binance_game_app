import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:binance_game_app/vest_bag.dart';
import 'package:binance_game_app/model/base/ret_model.dart';
import 'package:binance_game_app/pages/login/login_page.dart';

import '../cache_util.dart';


class TokenInterceptor extends Interceptor {


  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String token = await CacheUtil.getData<String>("token");
    print("${options.uri}");
    Map<String, dynamic> headers = {
      "token": token
    };
    options.headers = headers;
    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    //如果服务器挂掉了
    if (err.error.runtimeType == SocketException) {
      EasyLoading.showToast("您的设备没有联网,请检查您的设备网络");
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    //如果请求成功判断状态码
    if (response.statusCode == 200) {
      RetModel retModel =  RetModel.fromJson(response.data);
      if(retModel.code == 0) {
        handler.next(response);
        return;
      }else if(retModel.code == 500) {
        EasyLoading.showToast(retModel.msg);
        handler.reject(DioError(error: retModel.msg));
        return;
      }else if(retModel.code == 401){
        CacheUtil.removeData<String>("token").then((value){
          EasyLoading.showToast(retModel.msg);
          globalKey.currentState.pushNamedAndRemoveUntil(  LoginPage.routeName , (Route<dynamic> route) => false);
        });
        return;
      }
      handler.reject(DioError(error: retModel.msg));
      //表示服务器开小差了
    }else {
      handler.reject(DioError());
    }
  }
}