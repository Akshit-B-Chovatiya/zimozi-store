import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<SharedPreferences> _getPreference() async {
    return await SharedPreferences.getInstance();
  }

  static Future<bool> setString({required String key, required String value}) async {
    SharedPreferences sharedPreferences = await _getPreference();
    return sharedPreferences.setString(key, value);
  }

  static Future<String?> getString({required String key}) async {
    SharedPreferences sharedPreferences = await _getPreference();
    return sharedPreferences.getString(key);
  }

  static Future<bool> setBool({required String key, required bool value}) async {
    SharedPreferences sharedPreferences = await _getPreference();
    return sharedPreferences.setBool(key, value);
  }

  static Future<bool?> getBool({required String key}) async {
    SharedPreferences sharedPreferences = await _getPreference();
    return sharedPreferences.getBool(key);
  }

  static Future<bool> setDouble({required String key, required double value}) async {
    SharedPreferences sharedPreferences = await _getPreference();
    return sharedPreferences.setDouble(key, value);
  }

  static Future<double?> getDouble({required String key}) async {
    SharedPreferences sharedPreferences = await _getPreference();
    return sharedPreferences.getDouble(key);
  }

  static Future<int?> getInteger({required String key}) async {
    SharedPreferences sharedPreferences = await _getPreference();
    return sharedPreferences.getInt(key);
  }

  static Future<bool> setInteger({required String key, required int value}) async {
    SharedPreferences sharedPreferences = await _getPreference();
    return sharedPreferences.setInt(key, value);
  }

  static Future<bool> removeKey({required String key}) async {
    SharedPreferences sharedPreferences = await _getPreference();
    return await sharedPreferences.remove(key);
  }

  static Future<bool> clearStorage() async {
    SharedPreferences sharedPreferences = await _getPreference();
    return await sharedPreferences.clear();
  }
}
