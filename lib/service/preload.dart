import 'dart:convert';

import 'package:hiter/model/CourseModel.dart';
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
  loadCourses();
}

void _loadTheme() {
  selectedColorFs = prefs.getString(PREFS_SELECTED_THEME) ?? DEFAULT_THEME;
}

void _loadCurrentWeek() {
  currentWeekFs = DateTime
      .now()
      .difference(termStart)
      .inDays ~/ 7 + 1;
}

void loadCourses() {
  json
      .decode(prefs.getString(PREFS_P_COURSES) ?? '[]')
      .forEach((map) => coursesFs.add(CourseModel.fromMap(map)));

  json
      .decode(prefs.getString(PREFS_U_COURSES) ?? '[]')
      .forEach((map) {
    map['teacher'] = map['info'].toString().split('[')[0];
    coursesFs.add(CourseModel.fromMap(map));
  });
}
