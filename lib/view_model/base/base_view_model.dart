import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {

  bool loading = false;

  ValueNotifier<bool> valueNotifier = ValueNotifier<bool>(false);

  /// 开启加载
  void openLoading() {
    this.loading = true;
    valueNotifier.value = this.loading;
    this.notifyListeners();
  }

  /// 关闭加载
  void closeLoading() {
    this.loading = false;
    valueNotifier.value = this.loading;
    this.notifyListeners();
  }

  //通知
  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  //销毁
  @override
  void dispose() {
    print("BaseViewModel dispose ++++++++++");
    super.dispose();
  }

}