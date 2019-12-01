import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiter/page/mine/GetCourseLogin.dart';
import 'package:hiter/provider/MinePage.dart';
import 'package:hiter/service/common.dart';
import 'package:hiter/service/const.dart';
import 'package:provider/provider.dart';

import 'SchedulePage.dart';
import 'minePage.dart';
import 'BBSPage.dart';
import '../provider/AppProvider.dart';

class Bottom extends StatelessWidget {
  final _currentTab = [SchedulePage(), BBSPage(), MinePage()];
  final hitLoginProvider = HITLoginProvider();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    print('first page rebuild');
    return MaterialApp(
      title: 'Demo',
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: MD_COLORS[selectedColorFs],
      ),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: _currentTab[provider.getCurrentIndex()],
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: MD_COLORS[provider.getTheme()],
          fixedColor: MD_COLORS[provider.getTheme()],
          type: BottomNavigationBarType.shifting,
          currentIndex: provider.getCurrentIndex(),
          onTap: (index) {
            provider.setCurrentIndex(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              title: Text('Schedule'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.toc),
              title: Text('BBS'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Mine'),
            ),
          ],
        ),
      ),
    );
  }
}
