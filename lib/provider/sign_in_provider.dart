import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInProvider extends ChangeNotifier {
  bool _isSignedIn = false;

  bool get isSignIn => _isSignedIn;

  SignInProvider() {
    checkSignInUser();
  }

  Future checkSignInUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    _isSignedIn = sharedPreferences.getBool("signed_in") ?? false;
    notifyListeners();
  }
}
