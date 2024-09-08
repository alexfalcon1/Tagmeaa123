import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tagmeea/theme/font_constants.dart';

import '../theme/theme_manager.dart';
import 'helper_widgets.dart';

class ArTextFormField extends StatelessWidget {
  const ArTextFormField(
      {super.key,
      this.icon,
      this.hintText,
      this.controller,
      this.secured = false});

  final IconData? icon;
  final String? hintText;
  final TextEditingController? controller;
  final bool? secured;

  @override
  Widget build(BuildContext context) {
    ThemeManager themeManager = Get.put(ThemeManager());
    ColorScheme theme = themeManager.colorScheme.value;

    return Container(
      decoration: BoxDecoration(
          color: theme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: theme.surfaceVariant)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: getSi().setHeight(5), horizontal: getSi().setWidth(20)),
        child: Row(
          children: [
            Icon(
              icon,
              color: theme.surfaceVariant,
            ),
            spaceW(20),
            Expanded(
              child: TextFormField(
                obscureText: secured!,
                controller: controller,
                style: const TextStyle(fontFamily: arFontFamily),
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: hintText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
