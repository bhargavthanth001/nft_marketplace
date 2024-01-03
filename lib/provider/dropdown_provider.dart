import 'package:flutter/cupertino.dart';

List<String> categoryList = [
  "Art",
  "Photography",
  "Game",
  "Music",
  "Drawing",
  "Entertainment",
];

class DropDownProvider extends ChangeNotifier {
  String _selectedCategory = categoryList.first;

  String get selectedCategory => _selectedCategory;

  void onSaved(value) {
    _selectedCategory = value;
    notifyListeners();
  }
}
