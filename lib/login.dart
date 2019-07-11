import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      // appBar: AppBar(title: Text('ใบลา')),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(),
                child: Image(
                  width: 140,
                  image: AssetImage('assets/images/moph_logo.png'),
                ),
              ),
              Text(
                'ระบบลาหยุดราชการ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'NKP LEAVE SYSTEM',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              Text(
                'เวอร์ชัน 1.0.0',
                style: TextStyle(color: Colors.white, fontSize: 16),
              )
            ],
          )
        ],
      ),
    );
  }
}
