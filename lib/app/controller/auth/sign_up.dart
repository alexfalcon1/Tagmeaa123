import 'dart:convert';

import 'package:get/get.dart';
import 'package:tagmeea/app/controller/auth/network_url_constants.dart';

class SignUp {
  final _connect = GetConnect(allowAutoSignedCert: true);

  Future<Response> create(
    String name,
    String password,
    String email,
    String registerPlan,
    String address,
    String phone,
  ) async {
    try {
      final Response response =
          await _connect.post(NetworkURL.baseUrl + NetworkURL.createUser, {
        'name': name,
        'password': password,
        'email': email,
        'registerPlan': registerPlan,
        'address': address,
        'phone': phone,
        'APIKey': NetworkURL.apiKey,
      });

      if (response.statusCode == 200) {
        return const Response(statusCode: 200, statusText: "success");
      } else {
        return const Response(
            statusCode: 201, statusText: 'خطأ في الاتصال بالخادم');
      }
    } catch (e) {
      return Response(statusCode: 202, statusText: e.toString());
    }
  }

  Future<Response> emailIsExist(String email) async {
    try {
      final Response response =
          await _connect.post(NetworkURL.baseUrl + NetworkURL.testEmail, {
        'email': email,
        'APIKey': NetworkURL.apiKey,
      }, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      });

      Map<String, dynamic> data = jsonDecode(response.bodyString!);
      if (response.statusCode == 200) {
        if (data['exist'] == true) {
          return const Response(statusCode: 1, statusText: 'البريد غير متاح');
        } else {
          return const Response(statusCode: 0, statusText: 'البريد متاح');
        }
      } else {
        return const Response(
            statusCode: 201, statusText: 'خطأ في الاتصال بالخادم');
      }
    } catch (e) {
      return Response(statusCode: 202, statusText: e.toString());
    }
  }
}
