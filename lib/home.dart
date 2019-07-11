import 'package:flutter/material.dart';
import 'package:nkp_leave/pages/employee.dart';
import 'package:nkp_leave/pages/leave.dart';
import 'package:nkp_leave/pages/profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ระบบวันลาหยุดราชการ'),
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
