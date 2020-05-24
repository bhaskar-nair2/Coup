import 'package:auto_route/auto_route.dart';
import 'package:coup/router/guards.dart';
import 'package:coup/router/router.gr.dart';
import 'package:coup/screens/game_screen.dart';
import 'package:coup/style.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coup',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: GameScreen(),
      builder: ExtendedNavigator<Router>(
          router: Router(), guards: [AuthGuard()], initialRoute: '/'),
    );
  }
}
