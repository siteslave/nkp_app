import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nkp_leave/home.dart';
import 'package:nkp_leave/login.dart';

void main() => runApp(MainPage());

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('th', 'TH'),
      ],
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
