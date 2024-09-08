import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';

import 'font_constants.dart';

class AppTheme {
  static const sidePadding = 25;
  static const verticalPadding = 15;

  Future<ThemeData?> light() async {
    final lightThemeStr =
        await rootBundle.loadString('assets/themes/light_blue_theme.json');
    final lightThemeJson = jsonDecode(lightThemeStr);
    final theme = ThemeDecoder.decodeThemeData(lightThemeJson);
    return ThemeData(
        useMaterial3: true,
        colorScheme: theme!.colorScheme,
        fontFamily: arFontFamily);
  }

  Future<ThemeData?> dark() async {
    final darkThemeStr =
        await rootBundle.loadString('assets/themes/dark_blue_theme.json');
    final darkThemeJson = jsonDecode(darkThemeStr);
    final theme = ThemeDecoder.decodeThemeData(darkThemeJson);
    return ThemeData(
        useMaterial3: true,
        colorScheme: theme!.colorScheme,
        fontFamily: arFontFamily);
  }
}
