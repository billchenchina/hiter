import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hiter/service/store.dart';
import 'package:hiter/service/const.dart';

class UserProvider with ChangeNotifier {
  Image _avatar;

  Image getAvatar() {
    return _avatar;
  }
}

class HITLoginProvider with ChangeNotifier {
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();

  static const platform = const MethodChannel('hiter/getCourse');

  void setController() {
    userNameController.text = prefs.getString(PREFS_U_USRID) ?? "";
    passwordController.text = prefs.getString(PREFS_U_USRPASSWORD) ?? "";
  }

  void notify() {
    prefs.setString(PREFS_U_USRID, userNameController.text);
    prefs.setString(PREFS_U_USRPASSWORD, passwordController.text);
    notifyListeners();
  }
}
