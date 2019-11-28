import 'package:flutter/material.dart';
import 'package:hiter/page/schedule/Course.dart';
import 'package:hiter/service/common.dart';
import 'package:provider/provider.dart';

class Content extends StatelessWidget {
  Content({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _contentHeight = MediaQuery.of(context).size.height;

    var weekdays = [
      '周一',
      '周二',
      '周三',
      '周四',
      '周五',
      '周六',
      '周日',
    ];

    return SingleChildScrollView(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Times(
              timesHeight: _contentHeight,
            ),
          )
        ]..addAll(weekdays.map((weekday) {
            return Expanded(
              child: Courses(
                coursesHeight: _contentHeight,
                weekday: weekdays.indexOf(weekday) + 1,
              ),
              flex: 7,
            );
          })),
      ),
    );
  }
}

class Times extends StatelessWidget {
  Times({Key key, this.timesHeight}) : super(key: key);

  final double timesHeight;

  @override
  Widget build(BuildContext context) {
    double _itemHeight = timesHeight / getRowCount();

    return SizedBox(
      height: timesHeight,
      child: Column(
        children: List.generate(getRowCount(), (idx) {
          return GestureDetector(
            child: _buildTimeItem(n: idx + 1, height: _itemHeight),
          );
        }),
      ),
    );
  }
}

Container _buildTimeItem({@required int n, @required double height}) {
  return Container(
    height: height,
    child: Center(
      child: Text(
        '$n',
        textAlign: TextAlign.center,
      ),
    ),
  );
}
