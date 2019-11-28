import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hiter/model/CourseModel.dart';
import 'package:hiter/provider/ScheduleProvider.dart';
import 'package:hiter/service/common.dart';
import 'package:hiter/service/const.dart';
import 'package:hiter/util/CourseUtil.dart';

import 'CourseSetting.dart';
import 'EmptyBox.dart';

class Courses extends StatefulWidget {
  Courses({
    Key key,
    this.coursesHeight,
    this.weekday,
  }) : super(key: key);

  final double coursesHeight;
  final int weekday;

  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  double _minHeight;

  @override
  Widget build(BuildContext context) {
    _minHeight = widget.coursesHeight / getRowCount();

    return SizedBox(
      height: widget.coursesHeight,
      child: CourseColumn(
        weekday: widget.weekday,
        minItemHeight: _minHeight,
      ),
    );
  }
}

class CourseColumn extends StatefulWidget {
  final double minItemHeight;
  final int weekday;

  CourseColumn({Key key, this.minItemHeight, this.weekday});

  @override
  _CourseColumnState createState() => _CourseColumnState();
}

class _CourseColumnState extends State<CourseColumn> {
  @override
  void initState() {
    updateState$.listen((_) => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List c = getProcessedCourses(
      courses: coursesFs,
      weekday: widget.weekday,
      minHeight: widget.minItemHeight,
    );

    return Column(
      children: c.map((item) {
        if (item is CourseModel) {
          return CourseItem(
            courseInfoList: [item],
            minHeight: widget.minItemHeight,
          );
        } else if (item is EmptyModel) {
          return EmptyBox(
            weekday: item.weekday,
            start: item.start,
            step: item.step,
            minHeight: item.minHeight,
          );
        } else {
          return CourseItem(
            courseInfoList: item.cast<CourseModel>(),
            minHeight: widget.minItemHeight,
          );
        }
      }).toList(),
    );
  }
}

class CourseItem extends StatefulWidget {
  CourseItem({
    Key key,
    @required this.courseInfoList,
    @required this.minHeight,
  })  : assert(courseInfoList != null),
        assert(minHeight != null),
        super(key: key);

  final List<CourseModel> courseInfoList;
  final double minHeight;

  @override
  _CourseItemState createState() => _CourseItemState();
}

class _CourseItemState extends State<CourseItem> {
  @override
  Widget build(BuildContext context) {
    int maxStart = 0;
    int maxStep = 0;
    final courses = widget.courseInfoList.reversed;

    courses.forEach((info) {
      if (info.start > maxStart) maxStart = info.start;
      if (info.step > maxStep) maxStep = info.step;
    });

    return SizedBox(
      height: widget.minHeight * maxStep,
      child: GestureDetector(
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: <Widget>[]
            ..addAll(

                /// Reverse to make the first at top
                courses.map((courseInfo) {
              return CourseItemChild(
                courseInfo: courseInfo,
              );
            }))
            ..addAll(courses.length > 1
                ? [
                    DecoratedBox(
                      decoration: BoxDecoration(color: Colors.green),
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          '${courses.length}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ]
                : []),
        ),
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext ctx0) {
              if (courses.length == 1) {
                return CourseSettings(
                  title: '修改课程',
                  course: courses.first,
                  modifying: true,
                );
              } else {
                return Material(
                  color: Colors.white54,
                  child: GridView(
                    padding: EdgeInsets.all(10.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    children: courses.map((course) {
                      bool isCurWeek = course.weeks.contains(currentWeekFs);
                      return GridTile(
                        child: GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              color: GRID_COURSES_BG,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: EdgeInsets.all(10.0),
                            child: Text(
                              '${isCurWeek ? '' : '[非本周]'}${course.name}@${course.room}\n${course.teacher}',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          onTap: () {
                            showDialog(
                              context: ctx0,
                              builder: (BuildContext _) {
                                return CourseSettings(
                                  title: '修改课程',
                                  course: course,
                                  modifying: true,
                                );
                              },
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}

class CourseItemChild extends StatefulWidget {
  CourseItemChild({
    @required this.courseInfo,
  }) : assert(courseInfo != null);

  final CourseModel courseInfo;

  @override
  _CourseItemChildState createState() => _CourseItemChildState();
}

class _CourseItemChildState extends State<CourseItemChild> {
  @override
  Widget build(BuildContext context) {
    bool isCurWeek = widget.courseInfo.weeks.contains(currentWeekFs);

    return Container(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        minHeight: double.infinity,
      ),
      margin: EdgeInsets.all(0.5),
      decoration: BoxDecoration(
        color: isCurWeek ? COURSE_MD_COLORS[Random().nextInt(10)] : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: AutoSizeText(
        '${isCurWeek ? '' : '[非本周]'}${widget.courseInfo.name}${'@' + widget.courseInfo.room} ${widget.courseInfo.teacher}',
        minFontSize: 12 *
            MediaQuery.of(context).size.height /
            MediaQuery.of(context).size.width /
            1.5,
        softWrap: true,
        style: TextStyle(
          color: isCurWeek ? Colors.white : Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
