import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tagmeea/main.dart';

import '../models/Category.dart';
import '../models/waste_item.dart';

class LanguageController extends GetxController {
  static String? getLanguage() {
    return sharedPref?.getString('language');
  }

  static setLanguage(String? languageCode) async {
    Locale locale = Locale(languageCode!);
    await sharedPref?.setString('language', languageCode);
    Get.updateLocale(locale);
  }

  static defaultLanguage() {
    String? languageCode = sharedPref?.getString('language');

    languageCode ??= 'ar';
    sharedPref?.setString('language', languageCode);

    return languageCode;
  }

  static bool get isRTL => Get.locale?.languageCode == 'ar';

  static Map<String, dynamic> getWasteItemName(WasteItem item) {
    String? itemName;
    String? unitName;
    String? catName;

    if (getLanguage() == 'ar') {
      itemName = item.nameAr;
      unitName = item.unitNameAr;
      catName = item.categoryNameAr;
    } else {
      itemName = item.nameEn;
      unitName = item.unitNameEn;
      catName = item.categoryNameEn;
    }
    return jsonDecode('{"itemName" : "$itemName", '
        '"unitName": "$unitName", '
        '"categoryName": "$catName"'
        '}');
  }

  static String getCategoryName(Category item) {
    String catName = '';

    if (getLanguage() == 'ar') {
      catName = item.nameAr!;
    } else {
      catName = item.nameEn!;
    }
    return catName;
  }
}
