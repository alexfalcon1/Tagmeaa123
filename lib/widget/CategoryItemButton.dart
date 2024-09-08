import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:tagmeea/theme/app_colors.dart';
import 'package:tagmeea/widget/cached_network_image_Ex.dart';
import 'package:tagmeea/widget/helper_widgets.dart';

import '../theme/app_theme.dart';
import '../theme/font_constants.dart';
import 'ar_text.dart';

class CategoryItemButton extends StatelessWidget {
  const CategoryItemButton(
      {super.key,
      required this.theme,
      this.active = false,
      required this.title,
      required this.subTitle,
      required this.imageSrc,
      required this.description,
      required this.buttonText,
      this.onTap});

  final ColorScheme theme;
  final bool? active;
  final String title;
  final String description;
  final String subTitle;
  final Function()? onTap;
  final String imageSrc;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.verticalPadding.h),
      padding: EdgeInsets.symmetric(
          horizontal: AppTheme.sidePadding.w, vertical: 8.h),
      width: 1.sw,
      height: 110.h,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 8.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: theme.outlineVariant.withOpacity(0.2)),
            child: CachedNetworkImageEx(
              imageUrl: imageSrc,
              width: 70.h,
              height: 70.h,
            ),
          ),
          spaceW(20.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ArText(
                text: title,
                fontSize: kHeader6,
                fontBold: true,
              ),
              ArText(
                text: description == '' ? title : description,
                fontSize: 12.sp,
                fontBold: true,
                color: theme.onBackground.withAlpha(125),
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.warning,
                    borderRadius: BorderRadius.circular(8.h)),
                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.h),
                child: ArText(
                  text: subTitle,
                  fontSize: 10.sp,
                  fontBold: true,
                ),
              )
            ],
          ),
          spaceW(20.w),
          const Spacer(),
          GFButton(
            elevation: 12,
            colorScheme: theme,
            color: theme.primary,
            textStyle: h6Style,
            onPressed: onTap,
            text: buttonText,
          )
        ],
      ),
    );
  }
}
