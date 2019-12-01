import 'package:flutter/material.dart';
import 'package:hiter/page/mine/user.dart';

import 'setting.dart';

class Mine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        User(),
        Divider(),
        Setting(),
      ],
    );
  }
}
