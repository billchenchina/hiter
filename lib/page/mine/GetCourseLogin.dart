import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hiter/service/common.dart';
import 'package:hiter/service/const.dart';
import 'package:hiter/service/store.dart';

class HitLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HitLoginState();
}

class _HitLoginState extends State<HitLogin> {
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();

  static const platform = const MethodChannel('hiter.logiase.top/getCourse');

  Future<Null> _doLogin() async {
    String _message;

    prefs.setString(PREFS_U_USRID, userNameController.text);
    prefs.setString(PREFS_U_USRPASSWORD, passwordController.text);

    try {
      final String result = await platform.invokeMethod('Login', {
        "usrId": userNameController.text,
        "password": passwordController.text,
        "xnxq": xnxq,
      });
      _message = result;
    } on PlatformException catch (e) {
      _message = e.code;
    }

    print("Message:$_message");
  }

  @override
  void initState() {
    userNameController.text = prefs.getString(PREFS_U_USRID) ?? '';
    passwordController.text = prefs.getString(PREFS_U_USRPASSWORD) ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('统一认证登录'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 10.0),
            child: new Image.asset('assets/HITLogo.jpg'),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 4.0),
            child: TextField(
              style: TextStyle(fontSize: 15.0, color: Colors.black26),
              controller: userNameController,
              decoration: InputDecoration(hintText: '统一认证登录'),
              obscureText: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 10.0),
            child: TextField(
              style: TextStyle(fontSize: 15.0, color: Colors.black26),
              controller: passwordController,
              decoration: InputDecoration(hintText: '统一认证密码'),
              obscureText: true,
            ),
          ),
          Container(
            width: 360.0,
            margin: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
            padding: EdgeInsets.fromLTRB(30.0, 4.0, 30.0, 4.0),
            child: RaisedButton(
              onPressed: () => _doLogin(),
              child: Text('登录'),
            ),
          )
        ],
      ),
    );
  }
}
