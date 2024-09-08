import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/border/gf_border.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_border_type.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tagmeea/widget/helper_widgets.dart';

import '../../../theme/font_constants.dart';
import '../../../theme/theme_manager.dart';
import '../../controller/internet.dart';
import '../../controller/user_controller.dart';
import 'offline_screen.dart';

class ViewQRCode extends StatelessWidget {
  ViewQRCode({super.key, required this.qrData});

  final String qrData;
  final Internet internet = Get.find();
  final ThemeManager themeManager = Get.put(ThemeManager(), permanent: true);

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = ThemeManager().colorScheme.value;

    return Scaffold(
      body: GetBuilder<Internet>(builder: (context) {
        if (internet.hasConnection) {
          return OnlineWidget(
            theme: theme,
            qrData: qrData,
          );
        } else {
          return OfflineWidget(theme: theme);
        }
      }),
    );
  }
}

class OnlineWidget extends StatelessWidget {
  const OnlineWidget({super.key, required this.theme, required this.qrData});
  final ColorScheme theme;
  final String qrData;

  @override
  Widget build(BuildContext context) {
    UserController current = Get.put(UserController());

    return Center(
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 100.h, horizontal: 50.w),
          width: 1.sw,
          child: GFBorder(
            color: theme.surfaceVariant,
            strokeWidth: 2,
            dashedLine: const [
              5,
              5,
            ],
            radius: const Radius.circular(18),
            type: GFBorderType.rRect,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'shipment_code'.tr,
                  style: h4Style,
                ),
                spaceH(40.h),
                GFBorder(
                  color: theme.surfaceVariant,
                  strokeWidth: 2,
                  dashedLine: const [
                    10,
                    5,
                  ],
                  radius: const Radius.circular(18),
                  type: GFBorderType.rRect,
                  child: QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
                spaceH(40.h),
                GFButton(
                  onPressed: () async {
                    current.user = await UserController().getUser();
                    Get.back();
                  },
                  text: "go_back".tr,
                  textStyle: h5Style.copyWith(color: theme.onBackground),
                  blockButton: true,
                  colorScheme: theme,
                  size: GFSize.LARGE,
                  color: theme.secondaryContainer,
                  shape: GFButtonShape.pills,
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          )),
    );
  }
}
