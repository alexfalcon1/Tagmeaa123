import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tagmeea/app/controller/user_controller.dart';

import '../../../models/user.dart';
import '../../../util/local_data.dart';
import '../../../widget/app_icon_buttons.dart';
import '../../../widget/helper_widgets.dart';
import '../../../widget/validation_text_form_field.dart';
import '../../controller/button_type_enum.dart';

class UserEmailSettings extends StatefulWidget {
  const UserEmailSettings({super.key});

  @override
  State<UserEmailSettings> createState() => _UserEmailSettingsState();
}

class _UserEmailSettingsState extends State<UserEmailSettings> {
  String email = '';

  Future<User> getUser() async {
    User user = await LocalData.getUser;
    email = user.email!;
    return user;
  }

  @override
  Widget build(BuildContext context) {
    UserController currentUser = Get.find<UserController>();

    return FutureBuilder<User>(
        future: getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.toString());
            final User user = snapshot.data!;
            return Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 15.h)),

                ValidationTextFormField(
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  icon: FeatherIcons.atSign,
                  oldValue: user.email,
                  name: "email",
                  labelText: "email_account".tr,
                  secured: false,
                  onSuccess: (val) {
                    email = val!;
                    print("email : $val");
                  },
                  onError: (err) {},
                  regexValidation: const {FzPattern.email: 'البريد غير صحيح'},
                  rules: const {
                    'required': 'حقل مطلوب',
                  },
                ),
                Column(
                  children: [
                    spaceH_2X(),
                    ElevationIconButtonEx(
                        label: 'save'.tr,
                        reversed: true,
                        enabled: true,
                        btnColor: BtnColorEnum.success,
                        iconData: FeatherIcons.save,
                        onPressed: () {
                          context.loaderOverlay.show();
                          currentUser
                              .updateEmailAddress( email)
                              .then(
                                (response) {
                              if(response.statusCode==200)
                                {
                                  User user = User.fromJson(response.body);
                                  currentUser.saveUser(user);
                                  Get.snackbar("save".tr, "saved_email".tr);
                                }
                              context.loaderOverlay.hide();
                            },
                          );
                        }),
                    spaceH_1X(),
                  ],
                ),
              ],
            );
          } else {
            return Container();
          }
        });
  }
}
