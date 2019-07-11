import 'package:flutter/material.dart';

class LeaveInfoPage extends StatefulWidget {
  final String leaveId;
  final String emloyeeName;

  LeaveInfoPage(this.leaveId, this.emloyeeName);

  @override
  _LeaveInfoPageState createState() => _LeaveInfoPageState();
}

class _LeaveInfoPageState extends State<LeaveInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ใบลา : ${widget.emloyeeName}')),
      body: Center(
        child: Text('ข้อมูลการลา'),
      ),
    );
  }
}
