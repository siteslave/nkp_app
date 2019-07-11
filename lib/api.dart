import 'package:http/http.dart' as http;

class Api {
  Api();

  String apiUrl = 'http://localhost:3000';

  Future login(String username, String password) async {
    String url = '$apiUrl/login';
    Map body = {
      "username": username.toString(),
      "password": password.toString(),
      "userType": "ADMIN"
    };

    return await http.post(url, body: body);
  }
}
