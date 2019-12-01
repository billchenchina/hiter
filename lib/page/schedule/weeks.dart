import 'package:flutter/material.dart';
import 'package:hiter/provider/ScheduleProvider.dart';
import 'package:hiter/service/common.dart';
import 'package:hiter/service/const.dart';
import 'package:provider/provider.dart';

Column _buildWeekColumn({DateTime date, double width}) {
  return Column(
    children: <Widget>[
      SizedBox(
          width: width,
          child: Column(
            children: <Widget>[
              Text(
                Weekdays[date.weekday],
                textAlign: TextAlign.center,
              ),
              Text(
                date.day.toString(),
                textAlign: TextAlign.center,
              )
            ],
          ))
    ],
  );
}

class Week extends StatelessWidget {
  final _itemWidth = double.infinity;

  @override
  Widget build(BuildContext context) {
    var schedulePage = Provider.of<SchedulePageProvider>(context);
    print(schedulePage.getShowDateStart().weekday);
    return Row(
      children: <Widget>[
        Expanded(
          flex: 6,
          child: Column(
            children: <Widget>[
              SizedBox(
                width: _itemWidth,
                child: Text(
                  '${schedulePage.getShowDateStart().month}\n月',
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        )
      ]..addAll(
          [
            0,
            1,
            2,
            3,
            4,
            5,
            6,
          ].map(
            (week) {
              return Expanded(
                flex: 7,
                child: _buildWeekColumn(
                  date: schedulePage
                      .getShowDateStart()
                      .add(Duration(days: week)),
                  width: _itemWidth,
                ),
              );
            },
          ),
        ),
    );
  }
}
