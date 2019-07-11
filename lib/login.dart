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
                'โรงพยาบาลนครพิงค์',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              Text(
                'เวอร์ชัน 1.0.0',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(20),
                height: 280,
                width: 400,
                decoration: BoxDecoration(
                    color: Colors.purple[100],
                    borderRadius: BorderRadius.circular(10)),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        style: TextStyle(fontSize: 22),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'ชื่อผู้ใช้งาน',
                            labelStyle: TextStyle(fontSize: 20)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        style: TextStyle(fontSize: 22),
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'รหัสผ่าน',
                            labelStyle: TextStyle(fontSize: 20)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                                padding: EdgeInsets.all(15),
                                onPressed: () {},
                                child: Text('เข้าสู่ระบบ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                color: Colors.purple,
                                textColor: Colors.white,
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0))),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
