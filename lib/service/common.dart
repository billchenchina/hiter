import 'package:flutter/material.dart';
import 'package:hiter/model/CourseModel.dart';
import 'package:hiter/service/const.dart';
import 'package:rxdart/rxdart.dart';

String selectedColorFs = DEFAULT_THEME;

int currentWeekFs = 1;

int getRowCount() => 2 * 6;

final Map<String, String> timesFs = {};

final updateState$ = PublishSubject<dynamic>();

final List<CourseModel> coursesFs = [];

List<int> getWeeks() => List.generate(18, (idx) => idx + 1);

final Color GRID_COURSES_BG = Color.fromARGB(
    125, num.parse('0xF4'), num.parse('0xA7'), num.parse('0xB9'));