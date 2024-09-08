import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagmeea/widget/helper_widgets.dart';


class SettingsTemplatePage extends StatefulWidget {
  const SettingsTemplatePage(
      {super.key, required this.contents, required this.title});
  final Widget contents;
  final String title;

  @override
  State<SettingsTemplatePage> createState() => _SettingsTemplatePageState();
}

class _SettingsTemplatePageState extends State<SettingsTemplatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: 100.sw,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/fullbg.png'),
                    fit: BoxFit.cover)),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    title: Text(widget.title),
                  ),
                  spaceH_1X(),
                  Expanded(
                      child: SingleChildScrollView(child: widget.contents)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
