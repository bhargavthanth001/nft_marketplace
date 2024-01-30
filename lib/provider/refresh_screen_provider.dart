import 'package:flutter/cupertino.dart';

class RefreshProvider extends ChangeNotifier {
  refresh() async {
    notifyListeners();
  }
}
