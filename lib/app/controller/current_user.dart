import 'package:get/get.dart';

import '/models/user.dart';

class CurrentUser extends GetxController {
  final Rx<User> _user = User().obs;

  User get user {
    return _user.value;
  }

  set user(User user) {
    _user.value = user;
  }
}
