import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:json_theme/json_theme.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tagmeea/app/controller/network/app_bindings.dart';
import 'package:tagmeea/app/view/auth/login.dart';
import 'package:tagmeea/app/view/pages/catalog_browser.dart';
import 'package:tagmeea/app/view/driver/tasks_view.dart';
import 'package:tagmeea/app/view/pages/welcome.dart';
import 'package:tagmeea/localization/language_controller.dart';
import 'package:tagmeea/theme/app_theme.dart';
import 'package:tagmeea/widget/loading_data_overlay.dart';

import 'app/services/notification_service.dart';
import 'app/view/auth/register_plan.dart';
import 'app/view/home.dart';
import 'app/view/page_navigation_template.dart';
import 'app/view/pages/new_order_page.dart';
import 'app/view/pages/orders.dart';
import 'app/view/pages/profile.dart';
import 'localization/language.dart';
import 'theme/theme_manager.dart';

// Fix bad certificate for development
// -1
SharedPreferences? sharedPref;

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  // -2
  HttpOverrides.global = PostHttpOverrides();

  // Start
  ThemeManager themeManager = ThemeManager();
  //themeManager.setCurrentTheme('light');

  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();

  // fluter_local_notification
  //NotificationService().initNotification();

  // awesome notification
  NotificationService.initializeNotification();

  //background services . operation not 100%, will fix
  //initializeService();
  //FlutterBackgroundService().invoke('setAsBackground');

  //theme loader
  final lightTheme = await AppTheme().light();

  final darkTheme = await AppTheme().dark();

  runApp(MainApp( lightTheme: lightTheme, darkTheme: darkTheme,));
}

  class MainApp extends StatelessWidget {
    const MainApp({super.key, required this.lightTheme, required this.darkTheme});
    static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    final ThemeData? lightTheme;
    final ThemeData? darkTheme;

    @override
    Widget build(BuildContext context) {

      ThemeManager themeManager = Get.put(ThemeManager());
      themeManager.setTheme('light');

      return ScreenUtilInit(
          designSize: const Size(393, 852),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return GlobalLoaderOverlay(
              useDefaultLoading: false,
              overlayColor: Colors.white.withOpacity(0.8),
              overlayWholeScreen: false,
              overlayWidgetBuilder: (_) {return Center(
                child: LoadingDataOverlay(theme: lightTheme!.colorScheme), //CircularProgressIndicator(),
              );},
              child: GetMaterialApp(
                debugShowCheckedModeBanner: false,
                home: const Home(),
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: ThemeMode.light,
                locale: Locale(LanguageController.defaultLanguage()),
                translations: Languages(),
                initialBinding: AppBindings(),
                initialRoute: '/',
                getPages: [
                  GetPage(name: '/', page: () => const Home()),
                  GetPage(name: '/home_page', page: () => PageNavigationTemplate()),
                  GetPage(name: '/login', page: () => const LoginPage()),
                  GetPage(name: '/register', page: () => const RegisterPlanPage()),
                  GetPage(name: '/new_order', page: () => CartPage()),
                  GetPage(
                      name: '/catalog_browser', page: () => const CatalogBrowser()),
                  GetPage(name: '/settings', page: () => const MyProfile()),
                  GetPage(name: '/orders', page: () => const MyOrders()),
                  GetPage(name: '/welcome', page: () => const WelcomePage()),
                  GetPage(name: '/tasks_view', page: () => const TasksView()),
                ],
              ),
            );
          });
    }
  }

