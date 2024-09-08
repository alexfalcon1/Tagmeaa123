import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:tagmeea/app/controller/auth/auth.dart';

import '../../../widget/app_icon_buttons.dart';
import '../../../widget/helper_widgets.dart';
import '../../controller/button_type_enum.dart';

class UserAccountSettings extends StatefulWidget {
  const UserAccountSettings({super.key});

  @override
  State<UserAccountSettings> createState() => _UserAccountSettingsState();
}

class _UserAccountSettingsState extends State<UserAccountSettings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevationIconButtonEx(
            label: 'sign_out'.tr,
            reversed: true,
            enabled: true,
            btnColor: BtnColorEnum.success,
            iconData: FeatherIcons.logOut,
            onPressed: () {
              Get.offAllNamed('/login');
            }),
        spaceH_1X(),
        ElevationIconButtonEx(
            label: 'delete_account'.tr,
            reversed: false,
            enabled: true,
            btnColor: BtnColorEnum.danger,
            iconData: FeatherIcons.trash,
            onPressed: () {
              //Get.offAllNamed('/login');
              Auth().signOut();
            }),
        spaceH_1X(),
      ],
    );
  }
}
