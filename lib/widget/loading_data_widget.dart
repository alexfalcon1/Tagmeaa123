import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/border/gf_border.dart';
import 'package:getwidget/types/gf_border_type.dart';
import 'package:tagmeea/widget/helper_widgets.dart';

import '../../../theme/font_constants.dart';

class LoadingDataWidget extends StatelessWidget {
  const LoadingDataWidget({super.key, required this.theme});

  final ColorScheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 50.w),
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
          ),
        ));
  }
}
