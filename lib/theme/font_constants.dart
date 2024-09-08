import 'package:flutter/material.dart';
import 'package:tagmeea/theme/app_colors.dart';

const double kNormalTextSize = 16;
const double kHeader1 = 36;
const double kHeader2 = 30;
const double kHeader3 = 24;
const double kHeader4 = 20;
const double kHeader5 = 18;
const double kHeader6 = 16;
const arFontFamily = 'Tajawal';
const TextStyle normalStyle =
    TextStyle(fontFamily: arFontFamily, fontSize: kNormalTextSize);
const TextStyle h1Style =
    TextStyle(fontFamily: arFontFamily, fontSize: kHeader1);
const TextStyle h2Style =
    TextStyle(fontFamily: arFontFamily, fontSize: kHeader2);
const TextStyle h3Style =
    TextStyle(fontFamily: arFontFamily, fontSize: kHeader3);
const TextStyle h4Style =
    TextStyle(fontFamily: arFontFamily, fontSize: kHeader4);
const TextStyle h5Style =
    TextStyle(fontFamily: arFontFamily, fontSize: kHeader5);
const TextStyle h6Style =
    TextStyle(fontFamily: arFontFamily, fontSize: kHeader6);
final TextStyle errorStyle = normalStyle.copyWith(color: AppColors.danger);
