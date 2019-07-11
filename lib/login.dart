import 'package:flutter/material.dart';
import 'package:nkp_leave/api.dart';
import 'dart:convert' as convert;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:nkp_leave/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();

  Api api = Api();

  TextEditingController ctrlUsername = TextEditingController();
  TextEditingController ctrlPassword = TextEditingController();

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
                padding: EdgeInsets.all(10),
                // height: 280,
                width: 400,
                decoration: BoxDecoration(
                    color: Colors.purple[100],
                    borderRadius: BorderRadius.circular(10)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: ctrlUsername,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'กรุณาระบุชื่อผู้ใช้งาน';
                          }

                          return null;
                        },
                        style: TextStyle(fontSize: 22),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'ชื่อผู้ใช้งาน',
                            labelStyle: TextStyle(fontSize: 20),
                            errorStyle: TextStyle(fontSize: 18)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: ctrlPassword,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'กรุณาระบุรหัสผ่าน';
                          }

                          return null;
                        },
                        style: TextStyle(fontSize: 22),
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'รหัสผ่าน',
                            labelStyle: TextStyle(fontSize: 20),
                            errorStyle: TextStyle(fontSize: 18)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                                padding: EdgeInsets.all(15),
                                onPressed: () => doLogin(),
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

  Future doLogin() async {
    if (_formKey.currentState.validate()) {
      // valid
      String username = ctrlUsername.text;
      String password = ctrlPassword.text;

      try {
        var rs = await api.login(username, password);
        print(rs.body);

        if (rs.statusCode == 200) {
          var decoded = convert.jsonDecode(rs.body);
          if (decoded['ok']) {
            await storage.write(key: 'token', value: decoded['token']);
            // redirect to home
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => HomePage()));
          } else {
            Fluttertoast.showToast(
                msg: "${decoded['error']}",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 18);
          }
        } else {
          Fluttertoast.showToast(
              msg: "เกิดข้อผิดพลาด (SEVER)",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 18);
        }
      } catch (error) {
        print(error);
        Fluttertoast.showToast(
            msg: "เกิดข้อผิดพลาดในการเชื่อมต่อ",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 18);
      }
    } else {}
  }
}
