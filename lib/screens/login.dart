import 'package:coup/firebase/auth.dart';
import 'package:coup/firebase/presence.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
    _auth.getUser.then(
      (user) => {
        if (user != null)
          {
            IDManager.selfId = user.uid,
            UserPresence.rtdbAndLocalFsPresence(FirebaseApp.instance),
            Navigator.pushReplacementNamed(context, '/home-screen')
          }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/paintCardImg/base.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: LoginBtnHolder(auth: _auth),
      ),
    );
  }
}

class LoginBtnHolder extends StatelessWidget {
  const LoginBtnHolder({
    Key key,
    @required AuthService auth,
  })  : _auth = auth,
        super(key: key);

  final AuthService _auth;

  @override
  Widget build(BuildContext context) {
    return LoginHolder(auth: _auth);
  }
}

class LoginHolder extends StatelessWidget {
  const LoginHolder({
    Key key,
    @required AuthService auth,
  })  : _auth = auth,
        super(key: key);

  final AuthService _auth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          LoginButton(
            text: 'Login with Google',
            icon: FontAwesomeIcons.google,
            color: Colors.blueAccent.shade100,
            loginMethod: _auth.googleSignIn,
          ),
          LoginButton(
            text: 'Continue as Guest',
            color: Colors.blueGrey.shade300,
            icon: FontAwesomeIcons.personBooth,
            loginMethod: _auth.anonLogin,
          )
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
      {Key key, this.text, this.icon, this.color, this.loginMethod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: EdgeInsets.only(bottom: 20),
      child: FlatButton.icon(
        padding: EdgeInsets.all(15),
        icon: Icon(icon, color: Colors.white),
        color: color,
        onPressed: () async {
          try {
            await loginMethod();
            Navigator.pushReplacementNamed(context, '/home-screen');
            Fluttertoast.showToast(
              msg: "User Logged In",
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 12.0,
            );
          } catch (error) {
            Fluttertoast.showToast(
              msg: "Login Failed",
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 12.0,
            );
          }
        },
        label: Expanded(
          child: Text('$text', textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
