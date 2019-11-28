import 'package:flutter/material.dart';
import '../service/common.dart';

class SchedulePageProvider with ChangeNotifier {
  final _today = DateTime.now();

  int _showWeek = currentWeekFs;
  DateTime _showDateStart = DateTime.now();

  int getShowWeek() => _showWeek;

  void setShowWeek(int week) {
    _showWeek = week;
    _showDateStart = _today.add(Duration(days: week * 7 - 7));
    notifyListeners();
  }

  DateTime getShowDateStart() => _showDateStart;
}
