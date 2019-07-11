import 'package:flutter/material.dart';

class LeaveInfoPage extends StatefulWidget {
  final Map leave;
  LeaveInfoPage(this.leave);

  @override
  _LeaveInfoPageState createState() => _LeaveInfoPageState();
}

class _LeaveInfoPageState extends State<LeaveInfoPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            tabs: [
              Tab(
                icon: Icon(Icons.today),
                text: 'ลาครั้งนี้',
              ),
              Tab(icon: Icon(Icons.history), text: 'ประวัติ'),
              Tab(icon: Icon(Icons.account_balance_wallet), text: 'สรุป'),
            ],
          ),
          title: Text(
              '${widget.leave['first_name']} ${widget.leave['last_name']}'),
        ),
        body: TabBarView(
          children: [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(title: Text('ใบลา : ${widget.emloyeeName}')),
    //   body: Center(
    //     child: Text('ข้อมูลการลา'),
    //   ),
    // );
  }
}
