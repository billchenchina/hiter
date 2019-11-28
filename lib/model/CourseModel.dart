import 'package:flutter/material.dart';
import 'package:hiter/util/CourseUtil.dart';

class CourseModel {
  String name;
  String room;
  String teacher;
  int weekday;
  int start;
  int step;
  List<int> weeks;

  CourseModel(
      {this.name,
      this.room,
      this.teacher,
      this.weekday,
      this.start,
      this.step,
      this.weeks});

  Map<String, dynamic> toMap() => <String, dynamic>{
        'name': this.name,
        'classroom': this.room,
        'teacher': this.teacher,
        'start': this.start,
        'step': this.step,
        'weekday': this.weekday,
        'weeks': this.weeks,
      };

  factory CourseModel.fromMap(Map<String, dynamic> json) {
    List<int> weeksTmp = [];
    (json['weeks'] as List).forEach((v) => weeksTmp.add(v));

    return CourseModel(
      name: json['name'] as String,
      room: json['classroom'] as String,
      teacher: json['teacher'] as String,
      start: json['start'] as int,
      step: json['step'] as int,
      weekday: json['weekday'] as int,
      weeks: weeksTmp,
    );
  }

  bool invalidOverlaps({
    @required List<CourseModel> inCourses,
    @required int weekday,
    @required int start,
    @required int step,
  }) {
    List<CourseModel> list = getValidCourses(inCourses, weekdays: [weekday]);

    return list.any((course) {
      if ((start + step) > course.start &&
          (start < course.start + course.step)) {
        if (((start == course.start) && (step == course.step))) {
          return false;
        } else {
          return true;
        }
      }
      return false;
    });
  }
}

class EmptyModel {
  EmptyModel({
    @required this.minHeight,
    @required this.weekday,
    @required this.start,
    @required this.step,
  })  : assert(null != minHeight),
        assert(null != weekday),
        assert(null != start),
        assert(null != step);

  final double minHeight;
  final int weekday;
  final int start;
  final int step;
}
