import 'package:hiter/service/common.dart';
import 'package:hiter/service/const.dart';
import 'package:hiter/service/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  prefs = await SharedPreferences.getInstance();

  preload();
}

void preload() {
  _loadTheme();
  _loadCurrentWeek();
}

void _loadTheme() {
  selectedColorFs = prefs.getString(PREFS_SELECTED_THEME) ?? DEFAULT_THEME;
}

void _loadCurrentWeek() {
  currentWeekFs = prefs.getInt(PREFS_CURRENT_WEEK) ?? 1;
}
