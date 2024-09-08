import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/border/gf_border.dart';
import 'package:getwidget/types/gf_border_type.dart';
import 'package:tagmeea/widget/helper_widgets.dart';

import '../../../theme/font_constants.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({super.key, required this.theme});

  final ColorScheme theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 0.h, horizontal: 20.w),
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
                  'no_data'.tr,
                  style: h4Style,
                ),
                spaceH_2X(),
                Image.asset(
                  "assets/img/no-data-icon-1.png",
                  width: 150.w,
                ),
                spaceH_2X(),
                Text(
                  'will_display_data_when_available'.tr,
                  style: h4Style,
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )),
    );
  }
}
