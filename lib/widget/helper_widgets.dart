import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tagmeea/theme/font_constants.dart';
import 'package:tagmeea/util/media_query.dart';

ScreenInfo getScreenInfo() {
  ScreenInfo si = ScreenInfo();
  return si;
}

ScreenInfo getSi() => ScreenInfo();

Widget spaceH(double h) {
  return SizedBox(
    height: getScreenInfo().setHeight(h),
  );
}

Widget spaceW(double w) {
  return SizedBox(
    width: getScreenInfo().setWidth(w),
  );
}

Widget spaceH_1X() {
  return SizedBox(
    height: getScreenInfo().setHeight(20),
  );
}

Widget spaceH_2X() {
  return SizedBox(
    height: getScreenInfo().setHeight(40),
  );
}

Widget spaceW_1X() {
  return SizedBox(
    width: getScreenInfo().setWidth(20),
  );
}

Widget spaceW_2X() {
  return SizedBox(
    width: getScreenInfo().setWidth(40),
  );
}

Future<dynamic> loaderOverlay(Future<dynamic> Function() asyncFunction) async {
  return await Get.showOverlay(
      asyncFunction: asyncFunction,
      loadingWidget: const Center(
        child: CircularProgressIndicator(),
      ),
      opacity: 0.5);
}

bool isValidEmail(String email) {
  final bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  return emailValid;
}

class RememberMe extends StatefulWidget {
  const RememberMe({super.key, required this.onChanged(e)});

  final Function onChanged;

  @override
  State<RememberMe> createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          splashRadius: 10,
          value: _value,
          onChanged: (e) {
            setState(() {
              _value = e;
              widget.onChanged(e);
            });
          },
        ),
        spaceW(20),
        Text(
          'remember_me'.tr,
          style: normalStyle,
        ),
      ],
    );
  }
}
