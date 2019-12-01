import 'package:flutter/material.dart';
import '../service/common.dart';

class SchedulePageProvider with ChangeNotifier {
  final _today = DateTime.now();

  int _showWeek = currentWeekFs;
  DateTime _showDateStart =
      DateTime.now().add(Duration(days: 1 - DateTime.now().weekday));

  int getShowWeek() => _showWeek;

  void setShowWeek(int week) {
    _showWeek = week;
    _showDateStart = termStart.add(Duration(days: (week - 1) * 7));
    notifyListeners();
  }

  DateTime getShowDateStart() => _showDateStart;
}

class CourseSettingProvider with ChangeNotifier {
  String name = '';
  String room = '';
  String teacher = '';
  int start = 1;
  int step = 1;
  int weekday = 1;
  List<int> weeks = getWeeks();
  int groupWeekday = 1;

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setRoom(String room) {
    this.room = room;
    notifyListeners();
  }

  void setTeacher(String teacher) {
    this.teacher = teacher;
    notifyListeners();
  }

  void setGroupWeekday(int groupWeekday) {
    this.groupWeekday = groupWeekday;
    notifyListeners();
  }

  void setWeekday(int weekday) {
    this.weekday = weekday;
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }
}