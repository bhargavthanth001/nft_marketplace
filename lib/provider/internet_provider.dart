import 'package:flutter/cupertino.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetProvider extends ChangeNotifier {
  bool _isInternet = false;

  bool get isInternet => _isInternet;

  InternetProvider() {
    checkInternetConnection();
  }

  Future checkInternetConnection() async {
    final result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
      _isInternet = false;
    } else {
      _isInternet = true;
    }
    notifyListeners();
  }
}
