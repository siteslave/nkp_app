import 'package:flutter/material.dart';

class EmployeePage extends StatefulWidget {
  @override
  _EmployeePageState createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('ใบลา')),
      body: Center(
        child: Text('รายชื่อเจ้าหน้าที่'),
      ),
    );
  }
}
