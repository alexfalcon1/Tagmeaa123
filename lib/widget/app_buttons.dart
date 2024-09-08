import 'package:flutter/material.dart';

import '/widget/helper_widgets.dart';
import '../../../theme/color_constants.dart';
import '../../../theme/font_constants.dart';
import '../app/controller/button_type_enum.dart';

class ElevationButtonEx extends StatelessWidget {
  const ElevationButtonEx(
      {super.key,
      required this.text,
      required this.foreColor,
      required this.backColor,
      required this.onPressed,
      this.size,
      this.imageFile,
      this.icon});

  final String text;
  final Function() onPressed;
  final Size? size;
  final String? imageFile;
  final Icon? icon;
  final Color foreColor;
  final Color backColor;

  @override
  Widget build(BuildContext context) {
    ButtonStyle? styleFrom;

      styleFrom = ElevatedButton.styleFrom(
      foregroundColor: foreColor,
      backgroundColor: backColor,
      fixedSize: size,
      elevation: 0,
    );

    if (imageFile != null) {
      return ElevatedButton(
        onPressed: onPressed,
        style: styleFrom,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: const TextStyle(fontFamily: arFontFamily)),
              spaceW(20),
              Image.asset(
                imageFile!,
                height: getSi().setHeight(32),
              ),

            ],
          ),
        ),

      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        style: styleFrom,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(fontFamily: arFontFamily),
                ),
              spaceW(20),
              icon!
            ],
          ),
        ),
      );
    }


  }
}
