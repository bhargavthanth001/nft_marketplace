import 'package:flutter/material.dart';

import '../data manager/database_handler.dart';

class SearchProvider extends ChangeNotifier {
  List<String> searchList = [];
  TextEditingController searchController = TextEditingController();

  SearchProvider() {
    _getList();
  }

  _getList() async {
    searchList = await DataBase.getSearchList();
    notifyListeners();
  }

  List<String> filteredList() {
    String query = searchController.text.toLowerCase();
    return searchList
        .where((item) => item.toLowerCase().contains(query))
        .toList();
  }

  void clearSearch() {
    searchController.clear();
    notifyListeners();
  }

  void onChange() {
    notifyListeners();
  }
}
