import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nkp_leave/api.dart';
import 'package:nkp_leave/login.dart';
import 'package:nkp_leave/pages/employee.dart';
import 'package:nkp_leave/pages/leave.dart';
import 'package:nkp_leave/pages/profile.dart';
import 'dart:convert' as convert;
import 'package:firebase_messaging/firebase_messaging.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final storage = new FlutterSecureStorage();

  Api api = Api();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future saveDeviceToken(String deviceToken) async {
    try {
      String token = await storage.read(key: 'token');

      var rs = await api.saveDeviceToken(token, deviceToken);

      print(rs.body);

      if (rs.statusCode == 200) {
        var decoded = convert.jsonDecode(rs.body);
        if (decoded['ok']) {
          print('save token success');
        } else {
          Fluttertoast.showToast(
              msg: "${decoded['error']}",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 18);
        }
      } else {
        Fluttertoast.showToast(
            msg: "เกิดข้อผิดพลาด (SEVER)",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 18);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      print("Push Messaging token: $token");
      saveDeviceToken(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ระบบวันลาหยุดราชการ'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await storage.deleteAll();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
              })
        ],
      ),
      body: _selectedIndex == 0
          ? LeavePage()
          : _selectedIndex == 1 ? EmployeePage() : ProfilePage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          _onItemTapped(index);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            title: Text('ใบลา'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_work),
            title: Text('เจ้าหน้าที่'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('ข้อมูลส่วนตัว'),
          ),
        ],
      ),
    );
  }
}
