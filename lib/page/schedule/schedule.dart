import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hiter/page/schedule/CourseSetting.dart';
import 'package:hiter/provider/ScheduleProvider.dart';
import 'package:hiter/service/common.dart';
import 'package:hiter/service/const.dart';
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
        title: Row(
          children: <Widget>[
            Text('第${_schedulePage.getShowWeek()}周'),
            IconButton(
              icon: Icon(Icons.arrow_drop_down),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ListView(
                      children: getWeeks().map((index) {
                        return InkWell(
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            child: Text('第$index周'),
                          ),
                          onTap: () {
                            _schedulePage.setShowWeek(index);
                          },
                        );
                      }).toList(),
                    );
                  },
                );
              },
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              EventChannel('hiter.logiase.top/sendCourse')
                  .receiveBroadcastStream()
                  .listen((event) {
                showDialog(
                  context: context,
                  builder: (BuildContext ctx) {
                    return Scaffold(
                      body: Text(
                        event.toString(),
                      ),
                    );
                  },
                );
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  return CourseSettingContainer(
                    title: 'setting',
                  );
                },
              );
            },
          )
        ],
      ),
      body: GestureDetector(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            children: <Widget>[
              Week(),
              Expanded(
                child: Content(),
              ),
            ],
          ),
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
