import 'package:coup/repos/firebase/auth.dart';
import 'package:flutter/material.dart';

class LogoutBtn extends StatelessWidget {
  const LogoutBtn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        onPressed: () => {
          AuthService().signOut(),
          Navigator.of(context, rootNavigator: true).pushReplacementNamed("/"),
        },
        child: Text("Signout"),
      ),
    );
  }
}
