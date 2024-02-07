import 'package:flutter/cupertino.dart';

class NFTPageProvider extends ChangeNotifier {
  bool _isVisible = false;
  double _turns = 0.0;

  bool get isVisible => _isVisible;

  double get turns => _turns;

  onStatusChange() async {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  onRotation() async {
    if (_turns == 0.0) {
      _turns += 1 / 2;
    } else {
      _turns = 0.0;
    }

    notifyListeners();
  }
}
