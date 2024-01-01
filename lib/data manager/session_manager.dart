import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';

class SessionManager {
  static SharedPreferences? sharedPreferences;
  static String key = "sign_in";

  static Future<void> setSession() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setBool(key, true);
  }

  static Future<bool> getSession() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences!.getBool(key) ?? false;
  }

  static Future<void> logOutSession() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setBool(key, false);
  }
}
