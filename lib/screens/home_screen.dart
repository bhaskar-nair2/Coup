import 'package:coup/components/table/logoutBtn.dart';
import 'package:coup/firebase/auth.dart';
import 'package:coup/firebase/callers.dart';
import 'package:coup/router/router.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coup/firebase/firedb.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  final db = FirestoreService();
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<FirebaseUser>.value(value: _authService.user),
      ],
      child: Scaffold(
        body: Stack(children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/paintCardImg/base.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          OptionButtons()
        ]),
      ),
    );
  }
}

class OptionButtons extends StatefulWidget {
  OptionButtons({Key key}) : super(key: key);

  @override
  _OptionButtonsState createState() => _OptionButtonsState();
}

class _OptionButtonsState extends State<OptionButtons> {
  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    String tableId = 'ymAmWOuxrNYwXxWDg1Mo';

    return Positioned.directional(
      textDirection: TextDirection.ltr,
      bottom: 20,
      start: 10,
      child: SizedBox(
        height: 200,
        width: 200,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green.withOpacity(0.3),
              ),
              child: FlatButton(
                onPressed: () async {
                  await FirebaseCallers.joinTable(user.uid, tableId);
                },
                child: Text("Join a Table"),
              ),
            ),
            FlatButton(
              onPressed: () => {},
              child: Text("Create new Table"),
            ),
            LogoutBtn(),
          ],
        ),
      ),
    );
  }
}
