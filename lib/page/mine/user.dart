import 'package:flutter/material.dart';

class User extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 3.0,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.png'),
              backgroundColor: Colors.white,
              radius: MediaQuery.of(context).size.width <
                      MediaQuery.of(context).size.height
                  ? MediaQuery.of(context).size.width / 5.0
                  : MediaQuery.of(context).size.height / 8.0,
            ),
            Text(
              'username',
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
