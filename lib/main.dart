import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './page/Bottom.dart';
import './provider/AppProvider.dart';
import './service/common.dart';
import './service/const.dart';
import './service/preload.dart';

void main() {
  init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final app = AppProvider();

  @override
  Widget build(BuildContext context) {
    print('根部重建：$context');

    return ChangeNotifierProvider<AppProvider>.value(
      value: app,
      child: MaterialApp(
        title: 'Demo',
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
          primarySwatch: MD_COLORS[selectedColorFs],
        ),
        home: Bottom(),
      ),
    );
  }
}
