import 'package:flutter/material.dart';
import 'package:nkp_leave/helper.dart';

class LeaveInfoPage extends StatefulWidget {
  final Map leave;
  LeaveInfoPage(this.leave);

  @override
  _LeaveInfoPageState createState() => _LeaveInfoPageState();
}

class _LeaveInfoPageState extends State<LeaveInfoPage> {
  Helper helper = Helper();

  @override
  Widget build(BuildContext context) {
    DateTime _startDate = DateTime.parse(widget.leave['start_date'].toString());
    DateTime _endDate = DateTime.parse(widget.leave['end_date'].toString());

    String startDate = helper.toShortThaiDate(_startDate);
    String endDate = helper.toShortThaiDate(_endDate);

    Widget _infoWidget = Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.purple[100],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('ประเภท'),
                    Text(
                      '${widget.leave['leave_type_name']}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                height: 60,
                margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.purple[100],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('ช่วงเวลา'),
                    Text(
                      '$startDate - $endDate',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                height: 60,
                margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.purple[100],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('จำนวนวันลา'),
                    Text(
                      '${widget.leave['leave_days']} วัน',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                height: 60,
                margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.purple[100],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('เหตุผล'),
                    Text(
                      '${widget.leave['remark']}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                padding: EdgeInsets.all(20),
                onPressed: () {},
                child: Text(
                  'อนุมัติ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                color: Colors.green,
              ),
            ),
            Expanded(
              child: RaisedButton(
                padding: EdgeInsets.all(20),
                color: Colors.red,
                onPressed: () {},
                child: Text('ไม่อนุมัติ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
          ],
        )
      ],
    );

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
            _infoWidget,
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
