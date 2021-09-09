import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static String loggedInKey = 'loggedIn';
  static String usernameKey = 'username';
  static String emailKey = 'email';
  static String profileKey = 'profile';

  static Future<bool> saveLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(loggedInKey, value);
  }

  static Future<bool> saveUsername(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(usernameKey, value);
  }

  static Future<bool> saveEmail(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(emailKey, value);
  }

  static Future<bool> saveProfile(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(profileKey, name);
  }

  static Future<bool?> getLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(loggedInKey);
  }

  static Future<String?> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(usernameKey);
  }

  static Future<String?> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(profileKey);
  }

  static Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(emailKey);
  }

}
