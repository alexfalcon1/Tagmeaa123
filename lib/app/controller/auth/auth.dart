import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tagmeea/app/controller/user_controller.dart';

import '../../../models/user.dart';
import '../../../util/local_data.dart';
import '../../../util/util.dart';
import 'network_url_constants.dart';

class Auth extends GetConnect {
  late Map<String, String> _mainHeader;

  @override
  void onInit() {
    // TODO: implement onInit
    super.allowAutoSignedCert = true;
    super.onInit();
  }

  Auth() {
    _mainHeader = {
      "Content-type": "application/json; charset=utf8",
      "Authorization": NetworkURL.apiKey
    };
  }

  Future<Response> create(
    String name,
    String password,
    String email,
    String registerPlan,
    String address,
    String phone,
  ) async {
    Map<String, dynamic> data = {
      'name': name,
      'password': password,
      'email': email,
      'registerPlan': registerPlan,
      'address': address,
      'phone': phone,
      'APIKey': NetworkURL.apiKey,
    };

    try {
      final Response response = await post(
        NetworkURL.baseUrl + NetworkURL.createUser,
        data,
        contentType: "json",
        headers: _mainHeader,
      );
      print(response.bodyString);

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

  testEmail(String email) async {
    allowAutoSignedCert = true;
    Response response = await get(NetworkURL.baseUrl + NetworkURL.testEmail,
        query: {"email": email}, headers: _mainHeader);
    if (kDebugMode) {
      print(response.statusCode);
    }
    //return {};
  }

  Future<Map<String, dynamic>> verify(String email) async {
    allowAutoSignedCert = true;

    try {
      Response response = await get(
        NetworkURL.baseUrl + NetworkURL.verify,
        query: {"email": email},
        headers: _mainHeader,
      );

      var handle = handleResponse(response);

      return ({
        "found": handle.body['found'],
        "response": handle,
      });
    } catch (ex) {
      return ({
        "response": Response(statusCode: 500, statusText: ex.toString())
      });
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    allowAutoSignedCert = true;

    Map<String, String> data = {
      'email': email,
      'password': password,
      'APIKey': NetworkURL.apiKey,
    };

    try {
      Response response = await post(
        NetworkURL.baseUrl + NetworkURL.login,
        data,
        query: data,
        contentType: "application/json",
        headers: _mainHeader,
      );

      debugPrint('Login: ${response.bodyString!}');

      var handle = handleResponse(response);

      return ({
        "body": handle.body,
        "response": handle,
      });
    } catch (ex) {
      return ({
        "response": Response(statusCode: 500, statusText: ex.toString())
      });
    }
  }

  Future<Response> tryToken(String token) async {
    User user = await LocalData.getUser;

    Map<String, dynamic> data = {
      'token': token,
    };

    try {
      GetConnect connect = GetConnect(allowAutoSignedCert: true);

      Response response = await connect.post(
        "${NetworkURL.baseUrl}${NetworkURL.tryToken}",
        data,
        contentType: "json",
        headers: NetworkURL.mainHeader,
      );
      Response handle = Util.handleResponse(response);
      debugPrint('Token :${response.bodyString!}');

      if (handle.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(handle.bodyString!)['data'];
        return Response(statusCode: 200, body: json);
      } else {
        return const Response(statusCode: 201, body: null);
      }
    } catch (ex) {
      return Response(statusCode: 500, statusText: ex.toString());
    }
  }

  Future<Response> guestLogin() async {
    allowAutoSignedCert = true;

    Map<String, String> data = {
      'email': 'qtharwatt@fahmy.net',
      'password': '123456',
      'APIKey': NetworkURL.apiKey,
    };

    try {
      Response response = await post(
        NetworkURL.baseUrl + NetworkURL.login,
        data,
        query: data,
        contentType: "application/json",
        headers: _mainHeader,
      );

      //debugPrint('Login: ${response.bodyString!}');
      Response handle = Util.handleResponse(response);
      //debugPrint('User :${response.bodyString!}');

      if (handle.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(handle.bodyString!);

        return Response(statusCode: 200, body: json);
      } else {
        return const Response(statusCode: 201, body: null);
      }
    } catch (ex) {
      return Response(statusCode: 500, statusText: ex.toString());
    }

  }

  signOut() {
    UserController().removeUser();
  }
}

Response handleResponse(Response response) {
  switch (response.statusCode) {
    case 200:
      return Response(
          statusCode: 200,
          body: jsonDecode(response.bodyString!),
          statusText: "ok");
    case 401:
      return const Response(
          statusCode: 401,
          body: {"result": "error"},
          statusText: "Unauthorized");
    default:
      return const Response(
          statusCode: 201,
          body: {"result": "server error"},
          statusText: 'خطأ في الاتصال بالخادم');
  }
}
