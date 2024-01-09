import 'package:flutter/cupertino.dart';

class RefreshScreenProvider extends ChangeNotifier {
  Future onRefresh() async {
    Future.delayed(Duration(seconds: 3));
    notifyListeners();
  }
}
