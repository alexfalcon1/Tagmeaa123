import 'package:get/get.dart';

import '../../models/user.dart';

class AppController extends GetxController {
  final Rx<User> _currentUser = User(id: '1').obs;

  User currentUser() {
    return _currentUser.value;
  }

  void setUser(User user) {
    _currentUser.value = user;
  }
}
