import 'package:flutter/material.dart';
import 'package:nkp_leave/home.dart';
import 'package:nkp_leave/login.dart';

void main() => runApp(MainPage());

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Sarabun',
          textTheme: TextTheme(
              body1: TextStyle(fontSize: 18),
              headline: TextStyle(fontSize: 25)),
          primaryColor: Colors.purple,
          accentColor: Color(0xff7200ca)),
      title: 'ระบบลาหยุดราชการ',
      home: LoginPage(),
    );
  }
}
