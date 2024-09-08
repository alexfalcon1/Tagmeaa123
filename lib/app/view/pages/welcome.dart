import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tagmeea/theme/font_constants.dart';
import 'package:tagmeea/theme/theme_manager.dart';
import 'package:tagmeea/widget/helper_widgets.dart';

import '../../../widget/ar_text.dart';
import '../../controller/user_controller.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    ThemeManager themeManager = Get.put(ThemeManager());
    ColorScheme theme = themeManager.colorScheme.value;
    UserController userController = Get.find();
    String subscriptionType = userController.user.subscription!;

    return Stack(
      children: [
        Container(
          width: 100.sw,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/img/fullbg.png'),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              spaceH(150.h),
              Image.asset('assets/img/cartoon_businessman.png',
                  height: 0.28.sh),
              Center(
                child: Column(
                  children: [
                    spaceH_2X(),
                    ArText(
                      text: 'line_1'.tr,
                      fontBold: true,
                      islink: true,
                      onPressed: () => {},
                      fontSize: 24.sp,
                      color: theme.primary,
                    ),
                    ArText(
                      text: 'line_2'.tr,
                      fontBold: true,
                      islink: true,
                      onPressed: () => {},
                      fontSize: 24.sp,
                      color: theme.error,
                    ),
                  ],
                ),
              ),
              spaceH_1X(),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.r))),
                color: theme.primaryContainer,
                splashColor: theme.primaryContainer,
                elevation: 15.h,
                padding: EdgeInsetsDirectional.all(10.r),
                child: SizedBox(
                  width: 0.5.sw,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'start_here'.tr,
                        style: h5Style,
                      ),
                      spaceW_1X(),
                      Image.asset(
                        'assets/img/money_bag.png',
                        height: 48.h,
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  Get.toNamed('/catalog_browser');
                },
              ),
              spaceH_1X(),
              subscriptionType == 'driverCap'
                  ? MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.r))),
                      color: theme.inversePrimary,
                      splashColor: theme.primaryContainer,
                      elevation: 15.h,
                      padding: EdgeInsetsDirectional.all(10.r),
                      child: SizedBox(
                        width: 0.5.sw,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'iam_driver'.tr,
                              style: h5Style,
                            ),
                            spaceW_1X(),
                            Image.asset(
                              'assets/img/truck.png',
                              height: 48.h,
                            ),
                          ],
                        ),
                      ),
                      onPressed: () async {
                        Get.toNamed('/tasks_view');
                      },
                    )
                  : Container(),
            ],
          ),
        )
      ],
    );
  }
}
