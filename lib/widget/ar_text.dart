import 'package:flutter/material.dart';

class ArText extends StatelessWidget {
  const ArText(
      {super.key,
      this.text = 'Placeholder',
      this.fontSize = 18,
      this.fontBold = false,
      this.color = Colors.black,
      this.islink = false,
      this.onPressed});

  final String text;
  final double fontSize;
  final bool fontBold;
  final Color color;
  final bool islink;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      color: color,
      fontFamily: 'Tajawal',
      fontSize: fontSize,
      fontWeight: fontBold ? FontWeight.w500 : FontWeight.normal,
    );

    if (!islink) {
      return Text(text, style: textStyle);
    } else {
      return TextButton(
        onPressed: onPressed!,
        child: Text(text, style: textStyle),
      );
    }
  }
}
