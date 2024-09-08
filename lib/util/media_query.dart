import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenInfo {
  static const double _preferredWidth = 393; //1080;
  static const double _preferredHeight = 852; //1920;
  static double _pixelRatio = 0;
  static double _screenWidth = 0;
  static double _screenHeight = 0;
  static double _statusBarHeight = 0;
  static double _bottomBarHeight = 0;
  static const double _appBarHeight = 0;

  double appBarHeight = AppBar().preferredSize.height;

  ScreenInfo() {
    _pixelRatio = Get.mediaQuery.devicePixelRatio;
    _screenWidth = Get.mediaQuery.size.width;
    _screenHeight = Get.mediaQuery.size.height;
    _statusBarHeight = Get.mediaQuery.padding.top;
    _bottomBarHeight = Get.mediaQuery.padding.bottom;
  }

  MediaQueryData get mediaQueryData => Get.mediaQuery;

  double get pixelRatio => _pixelRatio;

  double get screenWidth => _screenWidth;

  double get screenHeight => _screenHeight;

  double get screenWidthDp => _screenWidth * pixelRatio;

  double get screenHeightDp => _screenHeight * pixelRatio;

  double get blockSizeHorizontal => screenWidth / 100;

  double get blockSizeVertical => screenHeight / 100;

  double get safeAreaVertical =>
      _screenHeight - _statusBarHeight - _bottomBarHeight - _appBarHeight;

  double get safeAreaHorizontal =>
      _screenWidth - mediaQueryData.padding.left - mediaQueryData.padding.right;

  double get scaleH => safeAreaVertical / _preferredHeight;

  double get scaleW => safeAreaHorizontal / _preferredWidth;

  double setHeight(double value) => scaleH * value;

  double setWidth(double value) => scaleW * value;

  double scaleWidth(double scale) {
    return safeAreaHorizontal * scale;
  }

  double scaleHeight(double scale) {
    return safeAreaVertical * scale;
  }

  double resFont(double size) {
    return setWidth(size);
  }
}
