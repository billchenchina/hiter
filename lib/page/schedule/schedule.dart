import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiter/page/schedule/CourseSetting.dart';
import 'package:hiter/provider/ScheduleProvider.dart';
import 'package:hiter/service/common.dart';
import 'package:provider/provider.dart';

import 'Content.dart';
import 'weeks.dart';

class Schedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _schedulePage = Provider.of<SchedulePageProvider>(context);
    var selectItemValue;

    return Scaffold(
      appBar: AppBar(
        title: DropdownButton(
          icon: Icon(Icons.arrow_drop_down),
          items: getListData(),
          hint: Text(
            '第${_schedulePage.getShowWeek()}周',
            style: TextStyle(color: Colors.white),
          ),
          value: selectItemValue,
          onChanged: (T) {
            _schedulePage.setShowWeek(T);
          },
          iconEnabledColor: Colors.white,
          iconSize: 30.0,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  return CourseSettings(
                    title: 'setting',
                  );
                },
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          children: <Widget>[
            Week(),
            Expanded(
              child: Content(),
              //child: Center(child: Text('Test')),
            ),
          ],
        ),
      ),
    );
  }
}

List<DropdownMenuItem> getListData() {
  List<DropdownMenuItem> items = List();

  items = getWeeks()
      .map((week) => DropdownMenuItem(
            child: Text(
              '第$week周',
            ),
            value: week,
          ))
      .toList();

  return items;
}
