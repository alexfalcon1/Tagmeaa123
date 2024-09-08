import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tagmeea/widget/helper_widgets.dart';

import '../../../theme/font_constants.dart';

class LoadingDataOverlay extends StatelessWidget {
  const LoadingDataOverlay({super.key, required this.theme});

  final ColorScheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 0.h, horizontal: 0.w),
        width: 1.sw,
        height: 1.sh,
        color: const Color.fromARGB(150, 255, 255, 255),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'loading'.tr,
              style: h4Style,
            ),
            spaceH_2X(),
            const CircularProgressIndicator(),
            spaceH_2X(),
            Text(
              'please_wait'.tr,
              style: h4Style,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }
}
