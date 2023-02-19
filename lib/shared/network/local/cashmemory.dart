import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class CashHelper {
  static late final SharedPreferences prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setbooldata(
      {required String key, required bool value}) async {
    return await prefs.setBool(key, value);
  }

  static bool? getbooldata({required String key}) {
    return prefs.getBool(key);
  }

  static Future<bool> setdata(
      {required String key, required dynamic value}) async {
    if (value is bool) {
      return await prefs.setBool(key, value);
    } else if (value is int) {
      return await prefs.setInt(key, value);
    } else if (value is String) {
      return await prefs.setString(key, value);
    }

    return await prefs.setDouble(key, value);
  }

  static dynamic? getdata({required String key}) async {
    
    return await prefs.get(key);
  }

  static Future<bool> removedata({required String key}) async {
    return prefs.remove(key);
  }
}
