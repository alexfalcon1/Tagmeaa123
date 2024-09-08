import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/models/user.dart';
import '../../util/local_data.dart';
import '../../util/util.dart';
import 'auth/network_url_constants.dart';

class UserController extends GetxController {
  final Rx<User> _user = User().obs;

  User get user {
    return _user.value;
  }

  set user(User user) {
    _user.value = user;
    update();
  }

  saveUser(User user) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(user.toJson()));
    _user.value = user;
    update();
  }

  Future<User> getUser() async {
    var prefs = await SharedPreferences.getInstance();
    String? userStr = prefs.getString("user");
    return User.fromJson(jsonDecode(userStr!));
  }

  removeUser() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove("user");
    prefs.remove("remember");
    user = User();
  }

  setRememberMe(bool state) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool("rememberMe", state);
  }

  getRememberMe() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool("rememberMe");
  }

  Future<Response> updateBasicInfo(
    String name,
    String address,
    String phone,
  ) async {
    User user = await LocalData.getUser;

    Map<String, dynamic> data = {
      'id' : user.id,
      'name': name,
      'address': address,
      'phone': phone,
    };

    try {
      GetConnect connect = GetConnect(allowAutoSignedCert: true);

      Response response = await connect.post(
        "${NetworkURL.baseUrl}${NetworkURL.updateUserBasicInfo}",
        data,
        contentType: "json",
        headers: NetworkURL.mainHeader,
      );
      Response handle = Util.handleResponse(response);

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

  Future<Response> updateEmailAddress(
      String email,
      ) async {

    //get Current User
    User user = await LocalData.getUser;

    Map<String, dynamic> data = {
      'id' : user.id,
      'email': email,
    };

    try {
      GetConnect connect = GetConnect(allowAutoSignedCert: true);

      Response response = await connect.post(
        "${NetworkURL.baseUrl}${NetworkURL.updateUserEmail}",
        data,
        contentType: "json",
        headers: NetworkURL.mainHeader,
      );
      Response handle = Util.handleResponse(response);

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
}
