import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagmeea/theme/app_colors.dart';

import '../../../theme/color_constants.dart';
import '../../../theme/font_constants.dart';
import '../app/controller/button_type_enum.dart';
import 'helper_widgets.dart';

class ElevationIconButtonEx extends StatelessWidget {
  const ElevationIconButtonEx(
      {super.key,
      required this.label,
      required this.btnColor,
      required this.onPressed,
      this.size,
      this.iconData,
      this.enabled = true,
      this.reversed = false});

  final String label;
  final BtnColorEnum btnColor;
  final Function() onPressed;
  final Size? size;
  final IconData? iconData;
  final bool? reversed;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    ButtonStyle? styleFrom;
    Color foreColor;
    Color backColor;

    switch (btnColor) {
      case BtnColorEnum.primary:
        foreColor = kOnPrimary;
        backColor = AppColors.primary;
        break;

      case BtnColorEnum.secondary:
        foreColor = kOnSecondaryContainer;
        backColor = AppColors.secondary;
        break;

      case BtnColorEnum.success:
        foreColor = kOnPrimary;
        backColor = AppColors.success;
        break;

      case BtnColorEnum.info:
        foreColor = kOnPrimary;
        backColor = AppColors.info;
        break;

      case BtnColorEnum.warning:
        foreColor = kOnPrimary;
        backColor = AppColors.warning;
        break;

      case BtnColorEnum.danger:
        foreColor = kOnPrimary;
        backColor = AppColors.danger;
        break;
      case BtnColorEnum.normal:
        foreColor = kSurfaceVariant;
        backColor = AppColors.primary;
        break;
      case BtnColorEnum.disabled:
        foreColor = kOutline;
        backColor = kOnSecondary;
        break;
      default:
        foreColor = kOnPrimaryContainer;
        backColor = kPrimaryContainer;
        break;
    }

    styleFrom = ElevatedButton.styleFrom(
      foregroundColor: foreColor,
      backgroundColor: backColor,
      fixedSize: size,
      elevation: 0,
    );

    var styleDisabled = ElevatedButton.styleFrom(
      foregroundColor: kSurface,
      backgroundColor: kSurfaceVariant,
      fixedSize: size,
      elevation: 0,
    );

    List<Widget> el = [
      Icon(iconData),
      spaceW(20),
      Container(
        padding: EdgeInsets.only(top: 5.h),
        child: Text(label,
            style: TextStyle(fontFamily: arFontFamily, fontSize: 17.sp)),
      ),
    ];

    return SizedBox(
      height: 50.h,
      child: ElevatedButton(
          onPressed: enabled! ? onPressed : () {},
          style: enabled! ? styleFrom : styleDisabled,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: reversed! ? el.reversed.toList() : el,
          )),
    );
  }
}
