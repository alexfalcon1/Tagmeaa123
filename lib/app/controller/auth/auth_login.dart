import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:tagmeea/app/controller/auth/network_url_constants.dart';

class LoginController {
  var client = http.Client();

  String _user = '';
  String _password = '';

  LoginController(String user, String password) {
    _user = user;
    _password = password;
  }

  Future<http.Response> attempt() async {
    Map<String, String> data = {
      'email': 'admin@hotmail.com',
      'password': "12345678",
      'APIKey': NetworkURL.apiKey,
    };

    var url = Uri.http("10.0.2.2:8000", "/testEmail");

    try {
      final http.Response response = await http.get(
        url,
        headers: data,
      );
      await Future.delayed(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        return response;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        //throw Exception('failed');
        return response;
      }
    } catch (ex) {
      throw Exception(ex.toString());
    }
  }

  Future<Response> dioAttempt() async {
    Map<String, String> data = {
      'email': _user,
      'password': _password,
      'APIKey': NetworkURL.apiKey,
    };

    Dio dio = Dio();
    final Response response = await dio.post(
        "https://${NetworkURL.baseUrl}${NetworkURL.checkUser}",
        data: data);
    return response;
  }
}
