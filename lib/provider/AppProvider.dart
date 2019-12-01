import 'package:flutter/material.dart';
import 'package:hiter/service/common.dart';
import 'package:hiter/service/const.dart';
import 'package:hiter/service/store.dart';

class AppProvider with ChangeNotifier {
  var _selectedTheme = selectedColorFs;

  int _currentIndex = 0;

  int getCurrentIndex() => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  String getTheme() => _selectedTheme;

  void setTheme(String theme) {
    _selectedTheme = theme;
    selectedColorFs = _selectedTheme;
    prefs.setString(PREFS_SELECTED_THEME, theme);
    notifyListeners();
  }
}
