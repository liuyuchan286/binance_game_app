
import 'package:shared_preferences/shared_preferences.dart';

class CacheUtil {

  /// 保存数据
  static saveData<T>(String key, T value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (T) {
      case String:
        prefs.setString(key, value as String);
        break;
      case int:
        prefs.setInt(key, value as int);
        break;
      case bool:
        prefs.setBool(key, value as bool);
        break;
      case double:
        prefs.setDouble(key, value as double);
        break;
    }
  }


  /// 读取数据
  static Future<T> getData<T>(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    T res;
    switch (T) {
      case String:
        res = prefs.getString(key) as T;
        break;
      case int:
        res = prefs.getInt(key) as T;
        break;
      case bool:
        res = prefs.getBool(key) as T;
        break;
      case double:
        res = prefs.getDouble(key) as T;
        break;
    }
    return res;
  }

  /// 读取数据
  static Future<bool> removeData<T>(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool res;
    switch (T) {
      case String:
        res = await prefs.remove(key);
        break;
      case int:
        res = await prefs.remove(key);
        break;
      case bool:
        res = await prefs.remove(key);
        break;
      case double:
        res = await prefs.remove(key);
        break;
    }
    return res;
  }

}