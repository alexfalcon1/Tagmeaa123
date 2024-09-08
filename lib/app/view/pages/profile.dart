import 'package:enhanced_future_builder/enhanced_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tagmeea/app/controller/user_controller.dart';
import 'package:tagmeea/app/view/pages/settings_template_page.dart';
import 'package:tagmeea/app/view/user/user_account.dart';
import 'package:tagmeea/app/view/user/user_email.dart';
import 'package:tagmeea/app/view/user/user_avatar.dart';
import 'package:tagmeea/localization/language_controller.dart';
import 'package:tagmeea/widget/helper_widgets.dart';

import '../../../models/user.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/theme_manager.dart';
import '../../../widget/ar_text.dart';
import '../../../widget/cached_network_image_Ex.dart';
import '../../controller/auth/network_url_constants.dart';
import '../../controller/pickup_q_report.dart';
import '../user/user_basic_info.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  // String name = '';
  // String email = '';
  // String phone = '';
  // String address = '';

  late ColorScheme theme;
  String? language = LanguageController.getLanguage();
  late String totalMoney = '0';
  late String totalPoints = '0';

  Future calculateTotal() async {
    var data = await RecycleController().getUserHistoryTotals();
    if (data.statusCode == 200) {
      Map<String, dynamic> item = data.body;
      var f = NumberFormat('0.0#');
      f.format(item['total_money']).toString();
      totalMoney = f.format(item['total_money']);
      totalPoints = item['total_points'].toString();
    }

    // Future.delayed(const Duration(seconds: 1), () async {
    // });
  }

  UserController userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    initData();
    calculateTotal();
  }

  initData() async {
    User user = await UserController().getUser();
    userController.user = user;
  }

  @override
  Widget build(BuildContext context) {
    ThemeManager themeManager = Get.put(ThemeManager());
    theme = themeManager.colorScheme.value;
    final String avatarUrl = NetworkURL.baseUrl+NetworkURL.avatarUrl;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 0.3.sh,
                decoration: BoxDecoration(
                  color: theme.outlineVariant.withOpacity(0.3),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/img/bg.jpg',
                      )),
                ),
              ),
              Container(
                height: 0.6.sh,
                decoration: BoxDecoration(
                  color: theme.background,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 1.h),
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  title: Center(child: Text("profile_settings".tr)),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 84.w,
                          height: 84.h,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: theme.secondaryContainer,
                            borderRadius: BorderRadius.circular(0.5.sw),
                          ),
                          child: GetBuilder<UserController>(builder: (logic) {
                            if (userController.user.avatar != null) {
                              return CachedNetworkImageEx(
                                imageUrl: avatarUrl + userController.user.avatar!,
                                width: 50,
                                height: 50,
                              );
                            } else {
                              return Container();
                            }
                          }),
                        ),
                        onTap: () {Get.to(()=>const UserAvatar());},
                      ),
                      Text(userController.user.name.toString())
                    ],
                  ),
                ),
                EnhancedFutureBuilder(
                  future: calculateTotal(),
                  rememberFutureResult: false,
                  whenDone: (dynamic data) {
                    return Card(
                      child: SizedBox(
                        height: 100.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 140.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('profile_total_shipment'.tr),
                                  Text(
                                    totalPoints,
                                    style: TextStyle(
                                        fontFamily: "Anton",
                                        fontSize: 30.sp,
                                        color: AppColors.danger),
                                  ),
                                ],
                              ),
                            ),
                            VerticalDivider(
                              width: 1,
                              thickness: 1,
                              indent: 15.h,
                              endIndent: 15.h,
                              color: theme.surfaceVariant,
                            ),
                            SizedBox(
                              width: 140.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('profile_total_money'.tr),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    textBaseline: TextBaseline.alphabetic,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    children: [
                                      Text(
                                        totalMoney,
                                        style: TextStyle(
                                            fontFamily: "Anton",
                                            fontSize: 30.sp,
                                            color: AppColors.danger),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 3.w, right: 3.w),
                                        child: Text(
                                          'currency_rs'.tr,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: AppColors.primary),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  whenNotDone: const Center(child: CircularProgressIndicator()),
                ),
                spaceH_1X(),
                Expanded(
                  child: SettingsList(
                    lightTheme: SettingsThemeData(
                        settingsListBackground: theme.background),
                    sections: [
                      SettingsSection(
                        title: ArText(text: 'User Account'.tr),
                        tiles: <SettingsTile>[
                          SettingsTile.navigation(
                            leading: const Icon(Icons.person),
                            trailing: LanguageController.isRTL
                                ? Icon(
                                    Icons.chevron_right,
                                    color: theme.outlineVariant,
                                  )
                                : Icon(
                                    Icons.chevron_left,
                                    color: theme.outlineVariant,
                                  ),
                            title: ArText(text: 'basic_info'.tr),
                            description: Text('settings_description_1'.tr),
                            onPressed: (context) {
                              Get.to(() => SettingsTemplatePage(
                                    contents: const UpdateBasicUserInfo(),
                                    title: "basic_info".tr,
                                  ));
                            },
                          ),
                          SettingsTile.navigation(
                            leading: const Icon(Icons.account_box),
                            trailing: LanguageController.isRTL
                                ? Icon(
                                    Icons.chevron_right,
                                    color: theme.outlineVariant,
                                  )
                                : Icon(
                                    Icons.chevron_left,
                                    color: theme.outlineVariant,
                                  ),
                            title: ArText(text: 'Account & Security'.tr),
                            description: Text('settings_description_2'.tr),
                            onPressed: (context) {
                              Get.to(() => SettingsTemplatePage(
                                    contents: const UserAccountSettings(),
                                    title: "my_account".tr,
                                  ));
                            },
                          ),
                          SettingsTile.navigation(
                            onPressed: (context){
                              Get.to(()=> SettingsTemplatePage(contents: const UserEmailSettings(), title: "email_account".tr));
                            },
                            leading: const Icon(Icons.email),
                            trailing: LanguageController.isRTL
                                ? Icon(
                                    Icons.chevron_right,
                                    color: theme.outlineVariant,
                                  )
                                : Icon(
                                    Icons.chevron_left,
                                    color: theme.outlineVariant,
                                  ),
                            title: ArText(text: 'email_account'.tr),
                            description: Text('settings_description_3'.tr),
                          ),
                        ],
                      ),
                      // SettingsSection(
                      //     title: ArText(text: 'User Interface'.tr),
                      //     tiles: [
                      //       SettingsTile.switchTile(
                      //         onToggle: (value) {
                      //           Get.changeTheme(
                      //             Get.isDarkMode ? ThemeData.light() : ThemeData.dark(),
                      //           );
                      //         },
                      //         initialValue: true,
                      //         leading: const Icon(Icons.format_paint),
                      //         title: ArText(text: 'Dark Theme'.tr),
                      //         description: Text('Toggle Theme Light / Dark'.tr),
                      //       ),
                      //     ]),
                      SettingsSection(
                          title: ArText(
                            text: 'Interface Language'.tr,
                          ),
                          tiles: [
                            SettingsTile.navigation(
                              title: Row(
                                children: [
                                  Radio(
                                      value: 'ar',
                                      groupValue: language,
                                      onChanged: (value) {
                                        setState(() {
                                          language = value;
                                          LanguageController.setLanguage(value);
                                        });
                                      }),
                                  const ArText(text: 'عربي')
                                ],
                              ),
                              trailing: LanguageController.isRTL
                                  ? Icon(
                                      Icons.chevron_right,
                                      color: theme.outlineVariant,
                                    )
                                  : Icon(
                                      Icons.chevron_left,
                                      color: theme.outlineVariant,
                                    ),
                            ),
                            SettingsTile.navigation(
                              title: Row(
                                children: [
                                  Radio(
                                      value: 'en',
                                      groupValue: language,
                                      onChanged: (value) {
                                        setState(() {
                                          language = value;
                                          LanguageController.setLanguage(value);
                                        });
                                      }),
                                  const Text('English')
                                ],
                              ),
                              trailing: language == 'ar'
                                  ? Icon(
                                      Icons.chevron_right,
                                      color: theme.outlineVariant,
                                    )
                                  : Icon(
                                      Icons.chevron_left,
                                      color: theme.outlineVariant,
                                    ),
                            ),
                          ])
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
