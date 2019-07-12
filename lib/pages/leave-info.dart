import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nkp_leave/api.dart';
import 'package:nkp_leave/helper.dart';

import 'dart:convert' as convert;

class LeaveInfoPage extends StatefulWidget {
  final Map leave;
  LeaveInfoPage(this.leave);

  @override
  _LeaveInfoPageState createState() => _LeaveInfoPageState();
}

class _LeaveInfoPageState extends State<LeaveInfoPage> {
  Helper helper = Helper();
  final storage = new FlutterSecureStorage();

  Api api = Api();

  List histories = [];
  List summaries = [];

  String profileImage = '';

  String token = '';

  Future getToken() async {
    String _token = await storage.read(key: 'token');
    setState(() {
      token = _token;
    });
  }

  @override
  void initState() {
    super.initState();
    getToken();
    getLeave(widget.leave['employee_id'].toString());
  }

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
                    color: Colors.purple[50],
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
                    color: Colors.purple[50],
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
                    color: Colors.purple[50],
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
                    color: Colors.purple[50],
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
                onPressed: () => changeStatus(
                    widget.leave['leave_id'].toString(), 'APPROVED'),
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
                onPressed: () =>
                    changeStatus(widget.leave['leave_id'].toString(), 'DENIED'),
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

    Widget _historyWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 10),
          child: Text('ประวัติการลา (${histories.length} ครั้ง)',
              style: TextStyle(
                  color: Colors.purple[700],
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            var item = histories[index];

            DateTime _startDate = DateTime.parse(item['start_date'].toString());
            DateTime _endDate = DateTime.parse(item['end_date'].toString());

            String startDate = helper.toShortThaiDate(_startDate);
            String endDate = helper.toShortThaiDate(_endDate);

            return Container(
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.purple[50],
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  '${item['leave_type_name']}',
                  style: TextStyle(
                      color: Colors.purple[700],
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text('$startDate - $endDate',
                    style: TextStyle(color: Colors.purple[400], fontSize: 18)),
                trailing: Text('${item['leave_days']} วัน',
                    style: TextStyle(
                        color: Colors.purple[700],
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            );
          },
          itemCount: histories.length,
        ))
      ],
    );

    Widget _summaryWidget = ListView.builder(
        itemBuilder: (BuildContext contex, int index) {
          var item = summaries[index];
          String lastDay = '-';

          if (item['last_leave_day'] != null) {
            DateTime _lastDay =
                DateTime.parse(item['last_leave_day'].toString());
            String day = helper.toShortThaiDate(_lastDay);
            lastDay = day;
          }

          String remainDay = 'ไม่จำกัด';
          String totalDay = 'ไม่จำกัด';

          if (item['leave_days_num'] != 0) {
            totalDay = item['leave_days_num'].toString();
          }

          if (item['leave_days_num'] != 0) {
            int _remain = item['leave_days_num'] - item['current_leave'];

            remainDay = _remain.toString();
          }

          return Container(
            margin: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: Colors.purple[50],
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${item['leave_type_name']}',
                    style: TextStyle(
                        color: Colors.purple[900],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // Divider(),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('สิทธิ์ที่ได้'),
                          Text('$totalDay วัน')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('ใช้ไปแล้ว'),
                          Text('${item['current_leave']} วัน')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('คงเหลือ'),
                          Text('$remainDay วัน')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('วันลาล่าสุด'),
                          Text('$lastDay')
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        itemCount: summaries.length);

    String imageUrl =
        '${api.apiUrl}/services/manager/employee/${widget.leave['employee_id']}/image?token=$token';
    Widget _profileWidget = ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.purple,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: profileImage == null
                            ? AssetImage('assets/images/female-placeholder.jpg')
                            : NetworkImage(imageUrl),
                        fit: BoxFit.cover)),
              ),
              Text('${widget.leave['first_name']} ${widget.leave['last_name']}',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple)),
              SizedBox(
                height: 10,
              ),
              Text('ตำแหน่ง${widget.leave['position_name']}'),
              // Text('${widget.leave['department_name']}'),
              Text('${widget.leave['sub_department_name']}')
            ],
          ),
        )
      ],
    );

    return DefaultTabController(
      length: 4,
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
              Tab(icon: Icon(Icons.person_pin), text: 'ข้อมูล'),
            ],
          ),
          title: Text(
              '${widget.leave['first_name']} ${widget.leave['last_name']}'),
        ),
        body: TabBarView(
          children: [
            _infoWidget,
            _historyWidget,
            _summaryWidget,
            _profileWidget,
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

  Future changeStatus(String leaveId, String status) async {
    try {
      String token = await storage.read(key: 'token');
      var rs = await api.changeStatus(token, leaveId, status);
      if (rs.statusCode == 200) {
        var decoded = convert.jsonDecode(rs.body);

        if (decoded['ok']) {
          Fluttertoast.showToast(
              msg: "บันทึกข้อมูลเสร็จแล้ว",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 18);

          Navigator.of(context).pop(true);
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
            msg: "เกิดข้อผิดพลา���ในการเชื่อมต่อ",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 18);
      }
    } catch (error) {
      print(error);
      Fluttertoast.showToast(
          msg: "เกิดข้อผิดพลาด",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 18);
    }
  }

  Future getLeave(String employeeId) async {
    try {
      String token = await storage.read(key: 'token');
      var rs = await api.getLeave(token, employeeId);
      if (rs.statusCode == 200) {
        var decoded = convert.jsonDecode(rs.body);

        if (decoded['ok']) {
          setState(() {
            profileImage = decoded['info']['image_path'];
            histories = decoded['rows'];
            summaries = decoded['summary'];
          });
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
            msg: "เกิดข้อผิดพลาดในการเชื่อมต่อ",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 18);
      }
    } catch (error) {
      print(error);
      Fluttertoast.showToast(
          msg: "เกิดข้อผิดพลาด",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 18);
    }
  }
}
