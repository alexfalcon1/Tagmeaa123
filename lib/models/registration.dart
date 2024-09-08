import 'package:get/get.dart';

class NewUser {
  String? name = '';
  String? email = '';
  String? password = '';
  String? avatar = '';
  String? registerPlan = '';
  String? address = '';
  String? phone = '';
  String? result = '';
  String? assetPath = '';
}

class Registration extends GetxController {
  Rx<NewUser> newUser = NewUser().obs;

  NewUser get user {
    return newUser.value;
  }

  set user(NewUser user) {
    newUser.value = user;
  }
}
