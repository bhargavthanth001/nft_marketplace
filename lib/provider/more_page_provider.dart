import 'package:flutter/cupertino.dart';

import '../data manager/database_handler.dart';
import '../data_variables.dart';
import '../model/user_model.dart';

class MorePageProvider extends ChangeNotifier {
  UserModel _userModel = UserModel();

  UserModel get userModel => _userModel;

  Future getData() async {
    _userModel = await DataBase.getUser(user.uid);
    notifyListeners();
  }
}
