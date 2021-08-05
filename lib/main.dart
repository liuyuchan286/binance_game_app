import 'dart:async';
import 'dart:convert';

import 'package:binance_game_app/actual_bag.dart';
import 'package:binance_game_app/constant/constant.dart';
import 'package:binance_game_app/utils/cache_util.dart';
import 'package:flutter/material.dart';
import 'package:openinstall_flutter_plugin/openinstall_flutter_plugin.dart';

import 'vest_bag.dart';

void main() => runApp(ShowTagApp());


class ShowTagApp extends StatefulWidget {
  const ShowTagApp({Key key}) : super(key: key);

  @override
  _ShowTagAppState createState() => _ShowTagAppState();
}

class _ShowTagAppState extends State<ShowTagApp> {
    //下载插件
   OpeninstallFlutterPlugin _openinstallFlutterPlugin;
   //显示的控制参数
   String bindData_falg = "";
   //下载的参数
   String installLog = "";

   @override
   void initState() {
     //初始化,判断是否已经有了参数
     CacheUtil.getData<bool>(Constant.APP_FLAG_FUTURE).then((value){
       if (value != null && value) {
         setState(() {
           bindData_falg = Constant.Y;
         });
       }else if (value != null && !value) {
         setState(() {
           bindData_falg = Constant.N;
         });
       }else{
         initPlatformState();
       }
     });
     super.initState();
   }
  @override
  Widget build(BuildContext context) {
     print("bindData_falg = ${bindData_falg}");
     if(bindData_falg == Constant.Y) {
       return ActualBagPage();
     }else if(bindData_falg == Constant.N){
       return MyApp();
     }
     return MaterialApp(
       home: Scaffold(
         body: Center(
           child: Container(
             color: Colors.white,
           ),
         ),
       ),
     );
  }


   Future<void> initPlatformState() async {
     if (!mounted) return null;
     //初始化
     _openinstallFlutterPlugin = new OpeninstallFlutterPlugin();
     //init
     _openinstallFlutterPlugin.init(wakeupHandler);
     //获取下载参数
     _openinstallFlutterPlugin.install(installHandler);
   }

   Future installHandler(Map<String, dynamic> data) async {

     dynamic channelCode = data['channelCode'];
     dynamic bindData = data['bindData'];

     if(bindData != null && bindData != '') {
       //显示 binance app
       bindData_falg = Constant.Y;
       //存下邀请人数据
       CacheUtil.saveData<bool>(Constant.APP_FLAG_FUTURE, true);
       CacheUtil.saveData<String>(Constant.CHANNEL_CODE,channelCode);
       if(bindData is String) {
         Map<String,dynamic> bindDataMap = json.decode(bindData);
         CacheUtil.saveData<String>(Constant.BINDDATA_KEY1, bindDataMap['key1']);
       }
     }else {
       bindData_falg = Constant.N;
       CacheUtil.saveData<bool>(Constant.APP_FLAG_FUTURE, false);
     }
     setState(() {});
     return data;
   }

   Future wakeupHandler(Map<String, dynamic> data) async {
     installLog += "wakeupHandler result : channel=" +
         data['channelCode'] +
         ", data=" +
         data['bindData'].toString() +
         "\n";
     print("wakeupHandler data = ${data}");
     return data;
   }

}