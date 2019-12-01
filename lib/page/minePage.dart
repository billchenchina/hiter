import 'package:flutter/material.dart';

import 'mine/mine.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mine'),
      ),
      body: Mine(),
    );
  }
}
