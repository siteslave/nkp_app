import 'package:flutter/material.dart';
import 'package:nkp_leave/pages/leave-info.dart';

class LeavePage extends StatefulWidget {
  @override
  _LeavePageState createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('ใบลา')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
            child: Text('รายการใบลาที่ยังไม่อนุมัติ (10 รายการ)'),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.all(5),
                  margin:
                      EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
                  decoration: BoxDecoration(
                      color: Colors.purple[50],
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              LeaveInfoPage('1', 'สถิตย์ เรียนพิศ'),
                          fullscreenDialog: false));
                    },
                    title: Text(
                      'นายสถิตย์ เรียนพิศ',
                      style: TextStyle(fontSize: 22),
                    ),
                    subtitle: Text('ศูนย์คอมพิวเตอร์'),
                    leading: CircleAvatar(
                      backgroundColor: Colors.purple,
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.purple[800],
                    ),
                  ),
                );
              },
              itemCount: 5,
            ),
          )
        ],
      ),
    );
  }
}
