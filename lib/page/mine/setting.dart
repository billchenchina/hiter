import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hiter/page/mine/GetCourseLogin.dart';
import 'package:hiter/provider/AppProvider.dart';
import 'package:hiter/provider/MinePage.dart';
import 'package:hiter/service/const.dart';
import 'package:hiter/service/preload.dart';
import 'package:hiter/service/store.dart';
import 'package:provider/provider.dart';

class Setting extends StatelessWidget {
  final hitLoginProvider = HITLoginProvider();

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context);

    return Card(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.color_lens),
            title: const Text('主题设置'),
            trailing: IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: Text('选择主题'),
                        children: MD_COLORS.keys.map((color) {
                          return SimpleDialogOption(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.invert_colors,
                                  color: MD_COLORS[color],
                                ),
                                Text(color),
                              ],
                            ),
                            onPressed: () {
                              appProvider.setTheme(color);
                            },
                          );
                        }).toList(),
                      );
                    });
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: const Text('添加课程表'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HitLogin(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.refresh),
            title: const Text('刷新课表'),
            onTap: () {
              EventChannel('hiter.logiase.top/sendCourse')
                  .receiveBroadcastStream()
                  .listen(
                (event) {
                  prefs.setString(PREFS_U_COURSES, event);
                  loadCourses();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
