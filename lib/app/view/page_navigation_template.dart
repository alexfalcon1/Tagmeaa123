import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:tagmeea/app/view/pages/main_page.dart';
import 'package:tagmeea/app/view/pages/my_notifications.dart';
import 'package:tagmeea/app/view/pages/orders.dart';
import 'package:tagmeea/app/view/pages/profile.dart';
import 'package:tagmeea/app/view/pages/welcome.dart';

import '../../theme/theme_manager.dart';
import '../controller/user_controller.dart';

// ignore: must_be_immutable
class PageNavigationTemplate extends StatefulWidget {
  PageNavigationTemplate({
    super.key,
    this.content,
  });

  Widget? content = Container(
    color: Colors.red,
    child: const Center(child: Text('empty')),
  );

  @override
  State<PageNavigationTemplate> createState() => _PageNavigationTemplateState();
}

class _PageNavigationTemplateState extends State<PageNavigationTemplate> {
  int _pageIndex = 0;

  UserController current = Get.put(UserController());

  final _pages = [
    const WelcomePage(),
    const MyOrders(),
    const MainPage(),
    const MyProfile(),
    const MyNotifications()
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    ThemeManager themeManager = Get.put(ThemeManager());
    ColorScheme theme = themeManager.colorScheme.value;

    return Scaffold(
        bottomNavigationBar: BottomBar(
          items: [
            BottomBarItem(
                icon: const Icon(FeatherIcons.home),
                activeColor: theme.primary),
            BottomBarItem(
                icon: const Icon(FeatherIcons.list),
                activeColor: theme.primary),
            BottomBarItem(
                icon: const Icon(FeatherIcons.truck),
                activeColor: theme.primary),
            BottomBarItem(
                icon: const Icon(FeatherIcons.settings),
                activeColor: theme.primary),
            BottomBarItem(
                icon: const Icon(FeatherIcons.bell),
                activeColor: theme.primary,
                ),
          ],
          onTap: (int i) {
            setState(() {
              _pageIndex = i;
            });
          },
          selectedIndex: _pageIndex,
        ),
        body: _pages[_pageIndex]);
  }
}
