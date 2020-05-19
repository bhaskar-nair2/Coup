import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: Color(0xff092147),
    primaryColorLight: Color(0xff2196F3),
    primaryColorDark: Color(0xff1A488E),
    secondaryHeaderColor: Color(0xffE5E5E5),
    accentColor: Color(0xff1A488E),
    hintColor: Color(0xffE28D00),
    dividerColor: Colors.black45,
    scaffoldBackgroundColor: Color(0xffffffff),
    canvasColor: Color(0xffE5E5E5),
    unselectedWidgetColor: Color(0xff5f6368),
    fontFamily: 'QuickSand',
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w200,
      ),
      headline4: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
      headline3: TextStyle(
        letterSpacing: 1,
        fontWeight: FontWeight.w600,
      ),
      headline2: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      headline1: TextStyle(
        fontSize: 82,
        fontWeight: FontWeight.w600,
      ),
      bodyText1: TextStyle(
        fontSize: 12,
        color: Colors.white,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.7,
      ),
      bodyText2: TextStyle(
        fontSize: 12,
        color: Colors.white,
        letterSpacing: 0.7,
      ),
      caption: TextStyle(
        fontSize: 12,
      ),
      subtitle2: TextStyle(
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

class CoupColors {
  CoupColors._(); // this basically makes it so you can instantiate this class

  static const global = Color(0xff424243);
  static const contessa = Color(0xff68396e);
  static const duke = Color(0xffdd9911);
  static const captain = Color(0xff234274);
  static const assassin = Color(0xffaf403b);
  static const ambassador = Color(0xff4a8b62);
}
