import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:get/get.dart';
import 'package:tagmeea/app/controller/task_controller.dart';
import 'notification_service.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
      iosConfiguration: IosConfiguration(
          autoStart: true,
          onForeground: onStart,
          onBackground: oniOSBackgroundService),

      androidConfiguration: AndroidConfiguration(
          onStart: onStart,
          isForegroundMode: true,
          // notificationChannelId: '888',
          // initialNotificationTitle: 'AWESOME SERVICE',
          // initialNotificationContent: 'Initializing',
          // foregroundServiceNotificationId: 888,
      ));
}

@pragma('vm:entry_point')
Future<bool> oniOSBackgroundService(ServiceInstance serviceInstance) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry_point')
onStart(ServiceInstance serviceInstance) async {
  DartPluginRegistrant.ensureInitialized();

  if (serviceInstance is AndroidServiceInstance) {
    serviceInstance.on("setAsForeground").listen((event) {
      serviceInstance.setAsForegroundService();
    });

    serviceInstance.on("setAsBackground").listen((event) {
      serviceInstance.setAsBackgroundService();
    });
  }

  serviceInstance.on("stopService").listen((event) {
    debugPrint('Service Stopped');
    serviceInstance.stopSelf();
  });

  serviceInstance.on("update").listen((event) {
    debugPrint('Service update');
  });


  int max = 30;
  int count = 0;

  Timer.periodic(const Duration(seconds: 1), (timer) async {

    count ++;
    debugPrint('Background service : $count');

    if (count >= 30) {

      if (serviceInstance is AndroidServiceInstance) {
        if (await serviceInstance.isForegroundService()) {
          serviceInstance.setForegroundNotificationInfo(
              title: "تجميع",
              content: "جاري فحص الاشعارات والتنبيهات");
        }
      }
      serviceInstance.invoke("stopService");
      Response response = await TaskController().getUnreadTasksCount();
      debugPrint(response.body.toString());

      if (response.statusCode == 200) {
        var unreadCount = int.parse(response.body['data']);

        if (unreadCount > 0) {
          NotificationService.showNormalNotification(
              'مهام تجميع', 'لديك $unreadCount مهمة جديدة');
        }
      }
      //
      // response = await CatalogController().getNewAcceptedItems();
      // if (response.statusCode == 200) {
      //   int unreadCount = response.body['data'];
      //   debugPrint(response.body['data']);
      //   if (unreadCount > 0) {
      //     NotificationService.showNormalNotification(
      //         'تجميع', 'لقد تم استلام شحنتك');
      //   }
      // }

      count = 0;
    }
    //print('background service running : $count');
    serviceInstance.invoke('update');
  });
}
