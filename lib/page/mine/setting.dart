import 'package:flutter/material.dart';
import 'package:hiter/provider/AppProvider.dart';
import 'package:hiter/service/const.dart';
import 'package:provider/provider.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context);
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('主题设置'),
          trailing: PopupMenuButton(
            padding: EdgeInsets.zero,
          ),
        )
      ],
    );
  }
}
