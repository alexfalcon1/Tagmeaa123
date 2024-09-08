import 'package:flutter/material.dart';
import 'package:tagmeea/theme/font_constants.dart';

class AppTheme2 {
  static const sidePadding = 25;
  static const verticalPadding = 15;
  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF2D6B28),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFAEF4A0),
    onPrimaryContainer: Color(0xFF002201),
    secondary: Color(0xFF696000),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFF4E565),
    onSecondaryContainer: Color(0xFF1F1C00),
    tertiary: Color(0xFF715C00),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFFE17B),
    onTertiaryContainer: Color(0xFF231B00),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFF8FDFF),
    onBackground: Color(0xFF001F25),
    surface: Color(0xFFF8FDFF),
    onSurface: Color(0xFF001F25),
    surfaceVariant: Color(0xFFDFE4D8),
    onSurfaceVariant: Color(0xFF42493F),
    outline: Color(0xFF73796E),
    onInverseSurface: Color(0xFFD6F6FF),
    inverseSurface: Color(0xFF00363F),
    inversePrimary: Color(0xFF93D786),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF2D6B28),
    outlineVariant: Color(0xFFC2C8BC),
    scrim: Color(0xFF000000),
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF93D786),
    onPrimary: Color(0xFF003A04),
    primaryContainer: Color(0xFF115211),
    onPrimaryContainer: Color(0xFFAEF4A0),
    secondary: Color(0xFFD7C94C),
    onSecondary: Color(0xFF363100),
    secondaryContainer: Color(0xFF4F4800),
    onSecondaryContainer: Color(0xFFF4E565),
    tertiary: Color(0xFFE6C449),
    onTertiary: Color(0xFF3B2F00),
    tertiaryContainer: Color(0xFF564500),
    onTertiaryContainer: Color(0xFFFFE17B),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF001F25),
    onBackground: Color(0xFFA6EEFF),
    surface: Color(0xFF001F25),
    onSurface: Color(0xFFA6EEFF),
    surfaceVariant: Color(0xFF42493F),
    onSurfaceVariant: Color(0xFFC2C8BC),
    outline: Color(0xFF8C9388),
    onInverseSurface: Color(0xFF001F25),
    inverseSurface: Color(0xFFA6EEFF),
    inversePrimary: Color(0xFF2D6B28),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF93D786),
    outlineVariant: Color(0xFF42493F),
    scrim: Color(0xFF000000),
  );

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      fontFamily: arFontFamily);
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      fontFamily: arFontFamily);
}
