import 'package:flutter/material.dart';
import 'package:nkp_leave/home.dart';

void main() => runApp(MainPage());

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.purple, accentColor: Color(0xff7200ca)),
      title: 'ระบบลาหยุดราชการ',
      home: HomePage(),
    );
  }
}
