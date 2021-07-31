import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:openinstall_flutter_plugin/openinstall_flutter_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String wakeUpLog = "";
  String installLog = "";
  late OpeninstallFlutterPlugin _openinstallFlutterPlugin;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    _openinstallFlutterPlugin = new OpeninstallFlutterPlugin();
    // for ad track
    // _openinstallFlutterPlugin.config(true, "oaid", null);
    // _openinstallFlutterPlugin.init(wakeupHandler, true);
    _openinstallFlutterPlugin.init(wakeupHandler);


    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('openinstall plugin demo'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(installLog, style: TextStyle(fontSize: 20)),
              Text(wakeUpLog, style: TextStyle(fontSize: 20)),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  _openinstallFlutterPlugin.install(installHandler);
                },
                child: Text('getInstall', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  _openinstallFlutterPlugin.reportRegister();
                },
                child: const Text('reportRegister',
                    style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  _openinstallFlutterPlugin.reportEffectPoint("effect_test", 1);
                },
                child: const Text('reportEffectPoint',
                    style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future installHandler(Map<String, dynamic> data) async {
    getHttp();
    setState(() {
      installLog += "install result : channel=" +
          data['channelCode'] +
          ", data=" +
          data['bindData'].toString() +
          "\n";
    });
  }

  void getHttp() async {
    try {
      //xinzengbeizhu
      var response = await Dio().get('http://127.0.0.1:37000/npc.conf');
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  Future wakeupHandler(Map<String, dynamic> data) async {
    setState(() {
      wakeUpLog += "wakeup result : channel=" +
          data['channelCode'] +
          ", data=" +
          data['bindData'].toString() +
          "\n";
    });
  }
}