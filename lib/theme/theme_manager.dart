import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tagmeea/theme/app_theme.dart';

class ThemeManager extends GetxController {

  late ThemeData? lightTheme = ThemeData();
  late ThemeData? darkTheme = ThemeData();

  RxBool changed = true.obs;

  final Rx<ThemeMode> _themeMode = Rx<ThemeMode>(ThemeMode.light);
  late final Rx<ThemeData> _themeData = Rx<ThemeData>(lightTheme!);
  late final Rx<ColorScheme> _colorScheme = Rx<ColorScheme>(lightTheme!.colorScheme);


  @override
  void onInit() async {
    // TODO: implement onInit
    lightTheme = await AppTheme().light();
    darkTheme = await AppTheme().dark();
    _colorScheme.value = lightTheme!.colorScheme;
    themeData.value = lightTheme!;
    super.onInit();
  }

  Rx<ThemeMode> get themeMode => _themeMode;
  Rx<ThemeData> get themeData => _themeData;
  Rx<ColorScheme> get colorScheme => _colorScheme;

  setTheme(String theme) async {
    if (theme == 'light') {
      _themeMode.value = ThemeMode.light;
      _themeData.value = lightTheme!;
      _colorScheme.value = lightTheme!.colorScheme;
    }

    if (theme == 'dark') {
      _themeMode.value = ThemeMode.dark;
      _themeData.value = darkTheme!;
      _colorScheme.value = darkTheme!.colorScheme;
    }
    update();
  }


}
