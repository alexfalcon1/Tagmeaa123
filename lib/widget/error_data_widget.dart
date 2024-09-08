import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/border/gf_border.dart';
import 'package:getwidget/types/gf_border_type.dart';
import 'package:tagmeea/widget/helper_widgets.dart';

import '../../../theme/font_constants.dart';

class ErrorDataWidget extends StatelessWidget {
  const ErrorDataWidget({super.key, required this.theme});

  final ColorScheme theme;

  @override
  Widget build(BuildContext context) {
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
                const Text(
                  'جاري تحميل البيانات',
                  style: h4Style,
                ),
                spaceH_2X(),
                Image.asset("assets/img/connection-error.webp"),
                spaceH_2X(),
                const Text(
                  'من فضلك انتظر ...',
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
