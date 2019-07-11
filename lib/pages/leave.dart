import 'package:flutter/material.dart';
import 'package:nkp_leave/api.dart';
import 'dart:convert' as convert;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:nkp_leave/pages/leave-info.dart';

class LeavePage extends StatefulWidget {
  @override
  _LeavePageState createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> {
  final storage = new FlutterSecureStorage();

  Api api = Api();

  List items = [];

  Future getLeaveDraft() async {
    String token = await storage.read(key: 'token');

    try {
      var rs = await api.getLeaveDraft(token);

      print(rs.body);

      if (rs.statusCode == 200) {
        var decoded = convert.jsonDecode(rs.body);
        if (decoded['ok']) {
          setState(() {
            items = decoded['rows'];
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
            msg: "เกิดข้อผิดพลาด (SEVER)",
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
          msg: "เกิดข้อผิดพลาดในการเชื่อมต่อ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 18);
    }
  }

  @override
  void initState() {
    super.initState();
    getLeaveDraft();
  }

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
            child: Text('รายการใบลาที่ยังไม่อนุมัติ (${items.length} รายการ)'),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                var item = items[index];

                return Container(
                  padding: EdgeInsets.all(5),
                  margin:
                      EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
                  decoration: BoxDecoration(
                      color: Colors.purple[50],
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: ListTile(
                    onTap: () async {
                      var rs = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  LeaveInfoPage(item),
                              fullscreenDialog: false));

                      if (rs != null) {
                        getLeaveDraft();
                      }
                    },
                    title: Text(
                      '${item['first_name']} ${item['last_name']}',
                      style: TextStyle(fontSize: 22),
                    ),
                    subtitle: Text('${item['sub_department_name']}'),
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
              itemCount: items.length,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getLeaveDraft(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
