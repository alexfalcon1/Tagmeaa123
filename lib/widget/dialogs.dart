import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tagmeea/theme/app_colors.dart';
import 'package:tagmeea/theme/font_constants.dart';

import 'helper_widgets.dart';

class Dialogs {
  static showErrorMessage(String msg) {
    Get.dialog(
      Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text(
            'خطأ',
            style: h2Style,
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                size: 28,
                Icons.warning,
                color: AppColors.warning,
              ),
              spaceW(5),
              Text(
                msg,
                style: normalStyle,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text(
                "إغلاق",
                style: normalStyle,
              ),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }
}
