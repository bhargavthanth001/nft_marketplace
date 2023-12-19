import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';

class LocalDataManager {
  static Future<bool> checkSignInUser() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    return s.getBool("signed_in") ?? false;
  }

  static Future<void> setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("signed_in", true);
  }

  static Future<void> createSession(UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData = jsonEncode(userModel.toJson());
    debugPrint("this  is the data => $encodedData");
    await prefs.setString("data", encodedData);
  }

  static Future<UserModel> callSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = prefs.getString("data");
    UserModel decodedData = jsonDecode(result!);
    debugPrint("Data get => ${decodedData.toJson()}");
    return decodedData;
  }

  static Future<void> destroySession() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.clear();
  }
}
