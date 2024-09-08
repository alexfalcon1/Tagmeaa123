import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:tagmeea/app/controller/button_type_enum.dart';
import 'package:tagmeea/app/controller/registration_type_controller.dart';
import 'package:tagmeea/app/view/auth/register_basic.dart';

import '/app/view/page_template_overlay.dart';
import '/theme/font_constants.dart';
import '../../../theme/theme_manager.dart';
import '../../../widget/app_icon_buttons.dart';
import '../../../widget/ar_text.dart';
import '../../../widget/helper_widgets.dart';

class RegisterPlanPage extends StatelessWidget {
  const RegisterPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    RegistrationTypeController registrationType =
        Get.put(RegistrationTypeController());

    ThemeManager themeManager = Get.put(ThemeManager());
    ColorScheme theme = themeManager.colorScheme.value;

    return PageTemplateOverlay(
      content: SizedBox(
        width: double.infinity,
        child: Obx(
          () {
            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                spaceH(50),
                Image.asset(
                  'assets/img/register-type.png',
                  height: getSi().setHeight(250),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getSi().setWidth(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ArText(
                        text: 'اختر نوع التسجيل',
                        fontSize: kHeader3,
                        fontBold: true,
                      ),
                      spaceH_1X(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RegisterTypeItem(
                            title: 'أفراد',
                            theme: theme,
                            assetPath: 'assets/img/person.png',
                            active: registrationType.selected ==
                                    RegistrationTypeEnum.individual
                                ? true
                                : false,
                            onTap: () {
                              registrationType.selected =
                                  RegistrationTypeEnum.individual;
                            },
                          ),
                          RegisterTypeItem(
                            title: 'شركات حكومية',
                            theme: theme,
                            assetPath: 'assets/img/business-man.png',
                            active: registrationType.selected ==
                                    RegistrationTypeEnum.government
                                ? true
                                : false,
                            onTap: () {
                              registrationType.selected =
                                  RegistrationTypeEnum.government;
                            },
                          )
                        ],
                      ),
                      spaceH_1X(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RegisterTypeItem(
                            title: 'شبه حكومي',
                            theme: theme,
                            assetPath: 'assets/img/company.png',
                            active: registrationType.selected ==
                                    RegistrationTypeEnum.semiGovernment
                                ? true
                                : false,
                            onTap: () {
                              registrationType.selected =
                                  RegistrationTypeEnum.semiGovernment;
                            },
                          ),
                          RegisterTypeItem(
                            title: 'سائق',
                            theme: theme,
                            assetPath: 'assets/img/truck.png',
                            active: registrationType.selected ==
                                    RegistrationTypeEnum.pilot
                                ? true
                                : false,
                            onTap: () {
                              registrationType.selected =
                                  RegistrationTypeEnum.pilot;
                            },
                          )
                        ],
                      ),
                      spaceH_1X(),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                              child: ElevationIconButtonEx(
                                  label: 'التالي',
                                  btnColor: BtnColorEnum.primary,
                                  iconData: FeatherIcons.chevronRight,
                                  onPressed: () {
                                    Get.to(() => const RegisterBasic());
                                  })),
                          spaceW_1X(),
                          Expanded(
                              child: ElevationIconButtonEx(
                                  label: 'رجوع',
                                  reversed: true,
                                  btnColor: BtnColorEnum.secondary,
                                  iconData: FeatherIcons.chevronLeft,
                                  onPressed: () {})),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class RegisterTypeItem extends StatelessWidget {
  const RegisterTypeItem(
      {super.key,
      required this.theme,
      this.active = false,
      required this.title,
      required this.assetPath,
      this.onTap});

  final ColorScheme theme;
  final bool? active;
  final String title;
  final Function()? onTap;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(getSi().setWidth(10)),
        width: getSi().setWidth(158),
        height: getSi().setHeight(164),
        decoration: BoxDecoration(
          color: theme.primaryContainer.withAlpha(15),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: active! ? theme.primary : theme.surfaceVariant,
            width: active! ? 1 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              assetPath,
              width: getSi().setWidth(80),
              height: getSi().setHeight(80),
            ),
            ArText(
              text: title,
              fontSize: kHeader6,
              fontBold: true,
            ),
            Container(
              width: getSi().setWidth(25),
              height: getSi().setHeight(25),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.primary,
                  width: active! ? 7 : 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
