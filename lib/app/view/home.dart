import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tagmeea/app/view/auth/login.dart';
import 'package:tagmeea/app/view/page_navigation_template.dart';
import 'package:tagmeea/theme/theme_manager.dart';
import 'package:tagmeea/util/local_data.dart';

import '../../models/user.dart';
import '../../theme/color_constants.dart';
import '../../theme/font_constants.dart';
import '../../util/media_query.dart';
import '../services/notification_service.dart';
import '../../widget/app_buttons.dart';
import '../../widget/ar_text.dart';
import '../../widget/dialogs.dart';
import '../../widget/footer_shape.dart';
import '../../widget/header_shape.dart';
import '../../widget/helper_widgets.dart';
import '../controller/auth/auth.dart';
import '../controller/button_type_enum.dart';
import '../controller/user_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AfterLayoutMixin<Home> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    final ThemeManager themeManager = Get.find();

    ScreenInfo si = ScreenInfo();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Stack(children: [
              const HeaderShape(),
              Positioned(
                right: 105.w,
                top: 70.h,
                child: Image.asset('assets/img/logo-dark.png'),
              )
            ]),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'collect_points'.tr,
                    style: const TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: kHeader2,
                        color: kBaseColor),
                  ),
                  RichText(
                    textDirection: TextDirection.rtl,
                    text: TextSpan(
                        text: '${'win'.tr} ',
                        style: const TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: kHeader3,
                            color: kError),
                        children: [
                          TextSpan(
                            text: 'money'.tr,
                            style: const TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: kHeader3,
                                color: kBaseColor),
                          ),
                        ]),
                  ),
                  spaceH(10),
                  Image.asset(
                    'assets/img/startup_image.png',
                    width: 250.w,
                  ),
                  spaceH(20),
                  RichText(
                    textDirection: TextDirection.rtl,
                    text: TextSpan(
                      text: 'welcome'.tr,
                      style: const TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: kHeader3,
                          color: kBaseColor),
                    ),
                  ),
                  spaceH(10),
                  ElevationButtonEx(
                    text: 'i_have_account',
                    foreColor: themeManager.colorScheme().onPrimary,
                    backColor: themeManager.colorScheme().primary,
                    size: Size(si.setWidth(250), si.setHeight(50)),
                    onPressed: () {
                      Get.toNamed('/login');
                    },
                    icon: const Icon(Icons.login),
                  ),
                  spaceH(10),
                  ElevationButtonEx(
                    text: 'create_account'.tr,
                    foreColor: themeManager.colorScheme().onSecondary,
                    backColor: themeManager.colorScheme().secondary,
                    size: Size(si.setWidth(250), si.setHeight(50)),
                    onPressed: () {
                      Get.toNamed('/register');
                    },
                    icon: const Icon(Icons.app_registration),
                  ),
                ],
              ),
            ),
            Stack(alignment: Alignment.center, children: [
              const FooterShape(),
              Padding(
                padding: EdgeInsets.only(top: 3.h),
                child: Column(
                  children: [
                    ArText(
                      text: 'call_support'.tr,
                      fontSize: kHeader5,
                    ),
                    const Text(
                      '+968 123 764 7888',
                      textDirection: TextDirection.ltr,
                    ),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    //context.loaderOverlay.show();

    Future.delayed(const Duration(seconds: 1), () async {
      bool rememberMe = await LocalData.rememberMe;
      if (rememberMe == true) {
        //User user = await LocalData.getUser;
        User user = await UserController().getUser();
        UserController userState = Get.find();
        var result = await Auth().tryToken(user.token!);
        int code = result.statusCode!;
        switch (code) {
          case 200:
            User user = User.fromJson(result.body);
            await UserController().saveUser(user);
            userState.saveUser(user);
            userState.user = user;
            //LocalData.setRememberMe(rememberMe);
            //NotificationService.initializeNotification();
            //initializeService();
            //FlutterBackgroundService().invoke('setAsBackground');

            debugPrint('Avatar : ${user.avatar!}');
            Get.offAll(() => PageNavigationTemplate());
            break;
          case 201:
            Dialogs.showErrorMessage('${'connection_error'.tr} -201');
            debugPrint('Database Server Error');
            break;
          case 401:
            Dialogs.showErrorMessage('${'connection_error'.tr} -401');
            debugPrint('Unauthorized');
            break;
          case 500:
            Dialogs.showErrorMessage('${'connection_error'.tr} -500');
            debugPrint('Internal Error');
        }
        // if (result.statusCode == 200) {
        //   User me = User.fromJson(result.body);
        //   await UserController().saveUser(me);
        //   Get.offAll(() => PageNavigationTemplate());
        // }
      }
    }); //throw UnimplementedError();
  }

  //Guest test user
  @override
  FutureOr<void> afterFirstLayout1(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () async {

      UserController userState = Get.find();

      Response result = await Auth().guestLogin();

      int code = result.statusCode!;
      switch (code) {
        case 200:
          User user = User.fromJson(result.body);
          await UserController().saveUser(user);
          userState.saveUser(user);
          userState.user = user;

          debugPrint('Avatar : ${user.avatar!}');
          Get.offAll(() => PageNavigationTemplate());
          break;
        case 201:
          Dialogs.showErrorMessage('201 - خطأ في الاتصال بالبيانات');
          debugPrint('Database Server Error');
          break;
        case 401:
          Dialogs.showErrorMessage('401 - بيانات الدخول غير متاحة');
          debugPrint('Unauthorized');
          break;
        case 500:
          Dialogs.showErrorMessage('خطأ في الاتصال 500');
          debugPrint('Internal Error');
      }


    });
  }

}
