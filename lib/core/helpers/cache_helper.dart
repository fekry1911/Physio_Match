import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static SharedPreferences? sharedPreferences;

  static init() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean({
    required String key,
    required bool value,
  }) async
  {
    return await sharedPreferences!.setBool(key, value);
  }

  static bool? getBoolean({
    required String key,
  })
  {
    return sharedPreferences!.getBool(key);
  }
  static Future<bool> putString({
    required String key,
    required String value,
  }) async
  {
    return await sharedPreferences!.setString(key, value);
  }

  static dynamic getString({required String key}) {
    return sharedPreferences!.get(key);
  }

  static  removeString({
    required String key,
  })
  {
    return sharedPreferences!.remove(key);
  }
}