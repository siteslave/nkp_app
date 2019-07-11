import 'dart:io';

import 'package:http/http.dart' as http;

class Api {
  Api();

  String apiUrl = 'http://172.168.17.182:3000';

  Future login(String username, String password) async {
    String url = '$apiUrl/login';
    Map body = {
      "username": username.toString(),
      "password": password.toString(),
      "userType": "ADMIN"
    };

    return await http.post(url, body: body);
  }

  Future changeStatus(String token, String leaveId, String status) async {
    String url = '$apiUrl/services/manager/leaves/status';
    Map body = {"leaveId": leaveId.toString(), "status": status.toString()};

    return await http.post(url,
        body: body,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
  }

  Future getLeaveDraft(String token) async {
    String url =
        '$apiUrl/services/manager/leaves?limit=20&offset=0&status=DRAFT';
    return await http
        .get(url, headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
  }
}
