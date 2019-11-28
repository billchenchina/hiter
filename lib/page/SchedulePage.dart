import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiter/page/schedule/schedule.dart';
import 'package:hiter/provider/ScheduleProvider.dart';
import 'package:provider/provider.dart';

class SchedulePage extends StatelessWidget {
  final schedulePageProvider = SchedulePageProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: schedulePageProvider,
      child: Schedule(),
    );
  }
}
