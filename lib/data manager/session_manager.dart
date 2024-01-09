import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static SharedPreferences? sharedPreferences;
  static String key = "sign_in";
  static String walletKey = "wallet_key";

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

  static Future<void> setWalletSession() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setBool(walletKey, true);
  }

  static Future<bool> getWalletSession() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences!.getBool(walletKey) ?? false;
  }
}
