import 'package:flutter/cupertino.dart';

List<String> categoryList = [
  "Art",
  "Photography",
  "Game",
  "Music",
  "Drawing",
  "Entertainment",
];

List<String> chain = [
  "Ethereum",
  "Bitcoin",
];

class DropDownProvider extends ChangeNotifier {
  String _selectedCategory = categoryList.first;
  String _selectedChain = chain.first;

  String get selectedCategory => _selectedCategory;

  String get selectedChain => _selectedChain;

  void selectCatagory(value) async {
    _selectedCategory = value;
    debugPrint("CategorySelection => $_selectedCategory");
    notifyListeners();
  }

  void selectChain(value) {
    _selectedChain = value;
    notifyListeners();
  }
}
