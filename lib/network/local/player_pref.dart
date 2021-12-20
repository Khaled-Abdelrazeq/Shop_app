import 'package:shared_preferences/shared_preferences.dart';

class PlayerPref {
  static late SharedPreferences preferences;

  static init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData(
      {required String key, required dynamic value}) async {
    if (value is int) return await preferences.setInt(key, value);
    if (value is String) return await preferences.setString(key, value);
    if (value is double) return await preferences.setDouble(key, value);
    return await preferences.setBool(key, value);
  }

  static dynamic getData({required String key}) {
    return preferences.get(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await preferences.remove(key);
  }
}
