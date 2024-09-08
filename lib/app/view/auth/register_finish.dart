import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_no_internet_widget/flutter_no_internet_widget.dart';
import 'package:get/get.dart';

import '../../../models/registration.dart';
import '../../../theme/font_constants.dart';
import '../../../widget/app_icon_buttons.dart';
import '../../../widget/helper_widgets.dart';
import '../../controller/button_type_enum.dart';
import '../page_template_overlay.dart';

class RegisterFinish extends StatelessWidget {
  const RegisterFinish({super.key});

  @override
  Widget build(BuildContext context) {
    return InternetWidget(
      offline: FullScreenWidget(
        child: offlineScreen(),
      ),
      online: onlineScreen(),
      loadingWidget: const Center(child: Text('جاري التحميل')),
      // ignore: avoid_print
      whenOffline: () => print('No Internet'),
      // ignore: avoid_print
      whenOnline: () => print('Connected to internet'),
      lookupUrl: "www.google.com",
    );
  }

  Widget onlineScreen() {
    Registration newReg = Get.put(Registration());
    return PageTemplateOverlay(
      content: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: getSi().setWidth(20)),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                spaceH(150),
                Image.asset('assets/img/handshake.png',
                    width: getSi().setWidth(90)),
                spaceH_1X(),
                Text("${newReg.user.name}", style: h3Style),
                spaceH_1X(),
                const Text("تم الاشتراك بنجاح", style: h3Style),
                spaceH_2X(),
                const Text("يمكنك الانتقال لصفحة الدخول", style: h3Style),
                spaceH_2X(),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                        child: ElevationIconButtonEx(
                            label: 'رجوع',
                            reversed: true,
                            enabled: true,
                            btnColor: BtnColorEnum.primary,
                            iconData: FeatherIcons.chevronLeft,
                            onPressed: () {
                              Get.offAllNamed('/login');
                            })),
                  ],
                ),
                spaceH_2X(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget offlineScreen() {
    return PageTemplateOverlay(
      content: const Center(
        child: SizedBox(
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'انقطع الاتصال ...',
                style: h3Style,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
