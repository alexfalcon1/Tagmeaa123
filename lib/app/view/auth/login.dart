import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tagmeea/app/controller/auth/auth.dart';
import 'package:tagmeea/app/controller/button_type_enum.dart';
import 'package:tagmeea/app/view/page_template_overlay.dart';
import 'package:tagmeea/theme/font_constants.dart';
import 'package:tagmeea/theme/theme_manager.dart';
import 'package:tagmeea/util/local_data.dart';
import 'package:tagmeea/widget/app_buttons.dart';
import 'package:tagmeea/widget/ar_text.dart';
import 'package:tagmeea/widget/helper_widgets.dart';

import '../../../models/user.dart';
import '../../../widget/ar_text_form_field.dart';
import '../../../widget/dialogs.dart';
import '../../controller/user_controller.dart';
import '../page_navigation_template.dart';

bool rememberMe = false;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeManager themeManager = Get.find();
    UserController current = Get.find<UserController>();

    ColorScheme theme = themeManager.colorScheme.value;

    TextEditingController inputUserLogin = TextEditingController();
    TextEditingController inputUserPassword = TextEditingController();

    return LoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Colors.white.withOpacity(0.8),
      overlayWholeScreen: true,
      overlayWidgetBuilder: (_) {return const Center(
        child: CircularProgressIndicator(),
      );},
      child: PageTemplateOverlay(
        content: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              spaceH(50),
              Image.asset('assets/img/login-screen.png', height: 0.28.sh),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceH_2X(),
                    ArText(
                      text: 'sign_in_header'.tr,
                      fontSize: kHeader3,
                      fontBold: true,
                    ),
                    spaceH_1X(),
                    ArTextFormField(
                      controller: inputUserLogin,
                      hintText: 'user_email'.tr,
                      icon: Icons.person,
                    ),
                    spaceH_1X(),
                    ArTextFormField(
                      secured: true,
                      controller: inputUserPassword,
                      hintText: 'password'.tr,
                      icon: Icons.lock,
                    ),
                    spaceH_1X(),
                    RememberMe(
                      onChanged: (e) {
                        rememberMe = e;
                      },
                    ),
                    spaceH_1X(),
                    ElevationButtonEx(
                      size: Size(100.sw, 50.h),
                      text: 'sign_in'.tr,
                      foreColor: themeManager.colorScheme().onPrimary,
                      backColor: themeManager.colorScheme().primary,
                      onPressed: () async {
                        if (inputUserPassword.text.length < 3 ||
                            inputUserLogin.text.length < 3) {
                          Dialogs.showErrorMessage('invalid_login'.tr);
                        } else if (!EmailValidator.validate(
                            inputUserLogin.text)) {
                          Dialogs.showErrorMessage('invalid_user'.tr);
                        } else {
                          await loginAttempt(context, inputUserLogin.text,
                                  inputUserPassword.text)
                              .then((code) async {
                            if (code == 200) {
                              current.user = await UserController().getUser();
                              //Get.offAll(() => MainPage(user: current.user));
                              Get.offAll(() => PageNavigationTemplate());
                            }
                          });
                        }
                      },
                      icon: const Icon(Icons.login),
                    ),

                    // Stack(
                    //   alignment: Alignment.center,
                    //   children: [
                    //     Divider(
                    //       height: 40,
                    //       thickness: 1,
                    //       indent: 0,
                    //       endIndent: 0,
                    //       color: theme.surfaceVariant,
                    //     ),
                    //     Container(
                    //       padding: EdgeInsets.symmetric(
                    //           horizontal: 20.w, vertical: 8.h),
                    //       color: theme.background,
                    //       child: ArText(text: 'or'.tr),
                    //     )
                    //   ],
                    // ),

                    // ElevationButtonEx(
                    //     imageFile: 'assets/img/google.png',
                    //     size: Size(getSi().screenWidth, getSi().setHeight(50)),
                    //     text: 'forget_password'.tr,
                    //     foreColor: themeManager.colorScheme().onPrimaryContainer,
                    //     backColor: themeManager.colorScheme().primaryContainer,
                    //     icon: const Icon(Icons.sign_language),
                    //     onPressed: () {}),

                    // Center(
                    //   child: ArText(
                    //     text: 'no_account_press_here'.tr,
                    //     fontBold: false,
                    //     islink: true,
                    //     onPressed: () => {},
                    //     fontSize: kHeader6,
                    //     color: theme.error,
                    //   ),
                    // ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<int> loginAttempt(BuildContext context, String inputUserLogin,
      String inputUserPassword) async {
    context.loaderOverlay.show();

    var result = await Auth().login(inputUserLogin, inputUserPassword);

    int code = result['response'].statusCode;

    switch (code) {
      case 200:
        User user = User.fromJson(result['response'].body);
        await UserController().saveUser(user);
        LocalData.setRememberMe(rememberMe);
        //NotificationService.initializeNotification();
        //initializeService();
        //FlutterBackgroundService().invoke('setAsBackground');
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
    if (context.mounted)
      {
        context.loaderOverlay.hide();
      }

    return code;
  }
}
