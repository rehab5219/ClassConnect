import 'package:shared_preferences/shared_preferences.dart';

class AppLocalStorage {
  static const String token = "token";
  static const String isOnboardingShown = "isOnboardingShown";
  static const String hasSeenWelcome = "hasSeenWelcome"; 
  static const String isLoggedIn = "isLoggedIn"; 
  static const String userType = 'userType';
  static const String uid = 'uid';
  static const String email = 'email'; 

  static late SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> cacheData({required String key, required dynamic value}) async {
    if (value is String) {
      await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    } else if (value is double) {
      await _sharedPreferences.setDouble(key, value);
    } else if (value is List<String>) {
      await _sharedPreferences.setStringList(key, value);
    }
  }

  static dynamic getData({required String key}) {
    return _sharedPreferences.get(key);
  }
}