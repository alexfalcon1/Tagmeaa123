import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class LocalData {
  static Future<bool> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', json.encode(user.toJson()));
    return true;
  }

  static Future<User> get getUser async {
    final prefs = await SharedPreferences.getInstance();
    User user = User.fromJson(jsonDecode(prefs.getString('user')!));
    return user;
  }

  static Future<bool> get rememberMe async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('rememberMe') ?? false;
  }

  static setRememberMe(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberMe', value);
  }
}
