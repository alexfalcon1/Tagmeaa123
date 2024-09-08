import 'dart:async';

import 'package:event/event.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Internet extends GetxController {
  final RxBool _hasConnection = false.obs;
  final valueChangedEvent = Event<ValueEventArgs>();
  late StreamSubscription internetSubscription;

  @override
  void onInit() {
    super.onInit();
    initService();
  }

  initService() {
    internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      hasConnection = hasInternet;
      valueChangedEvent.broadcast(ValueEventArgs(hasConnection));
    });
  }

  bool get hasConnection => _hasConnection.value;

  set hasConnection(bool value) {
    _hasConnection.value = value;
    update();
  }

  Future<bool> get isAvailable async {
    hasConnection = await InternetConnectionChecker().hasConnection;
    return hasConnection;
  }
}

class ValueEventArgs extends EventArgs {
  bool changedValue;

  ValueEventArgs(this.changedValue);
}
