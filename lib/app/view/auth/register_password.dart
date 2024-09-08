import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:get/get.dart';
import 'package:tagmeea/app/view/auth/register_finish.dart';
import 'package:tagmeea/widget/dialogs.dart';

import '../../../models/registration.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/font_constants.dart';
import '../../../widget/app_icon_buttons.dart';
import '../../../widget/helper_widgets.dart';
import '../../../widget/validation_text_form_field.dart';
import '../../controller/auth/sign_up.dart';
import '../../controller/button_type_enum.dart';
import '../page_template_overlay.dart';

class RegisterPassword extends StatefulWidget {
  const RegisterPassword({super.key});

  @override
  State<RegisterPassword> createState() => _RegisterPasswordState();
}

class _RegisterPasswordState extends State<RegisterPassword> {
  Registration newReg = Get.put(Registration());

  bool _password1HasError = true;
  bool _password2HasError = true;

  @override
  void initState() {
    // TODO: implement initState
    formIsValid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplateOverlay(
      content: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: getSi().setWidth(20)),
          child: SizedBox(
            width: double.infinity,
            child: Column(children: [
              spaceH_2X(),
              Image.asset(newReg.user.assetPath!, width: getSi().setWidth(90)),
              spaceH_2X(),
              Text("إشتراك ${newReg.user.registerPlan}", style: h3Style),
              spaceH_2X(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("رمز الدخول",
                      style: h3Style.copyWith(color: AppColors.primary)),
                ],
              ),
              spaceH_2X(),
              ValidationTextFormField(
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                icon: FeatherIcons.lock,
                name: "password",
                labelText: "كلمة المرور",
                secured: true,
                onSuccess: (val) {
                  newReg.user.password = val;
                  setState(() {
                    _password1HasError = false;
                  });
                },
                onError: (err) {
                  setState(() {
                    _password1HasError = true;
                  });
                },
                regexValidation: const {
                  FzPattern.passwordEasy: 'كلمة المرور لا تقل عن ٨ حروف'
                },
                rules: const {
                  'required': 'حقل مطلوب',
                  "min|8": "كلمة المرور لا تقل عن ٨ حروف",
                },
              ),
              ValidationTextFormField(
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                icon: FeatherIcons.lock,
                name: "password2",
                labelText: "تأكيد كلمة المرور",
                secured: true,
                onSuccess: (val) {
                  setState(() {
                    _password2HasError = false;
                  });
                },
                onError: (err) {
                  setState(() {
                    _password2HasError = true;
                  });
                },
                minLength: 3,
                regexValidation: const {
                  FzPattern.passwordEasy:
                      'كلمة المرور لا تقل عن ٨ حروف لا تحتوي علي مسافات'
                },
                rules: {
                  'required': 'حقل مطلوب',
                  "min|8": "كلمة المرور لا تقل عن ٨ حروف",
                  "match|${newReg.user.password}": "كلمة المرور غير متطابقة"
                },
              ),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                      child: ElevationIconButtonEx(
                          label: 'إنهاء',
                          btnColor: BtnColorEnum.primary,
                          enabled: formIsValid(),
                          iconData: FeatherIcons.chevronRight,
                          onPressed: () {
                            if (formIsValid()) {
                              //displayDebugRegisterInfo();
                              SignUp()
                                  .create(
                                      newReg.user.name!,
                                      newReg.user.password!,
                                      newReg.user.email!,
                                      newReg.user.registerPlan!,
                                      newReg.user.address!,
                                      newReg.user.phone!)
                                  .then((Response res) {
                                if (res.statusCode == 200) {
                                  Get.to(() => const RegisterFinish());
                                } else {
                                  Dialogs.showErrorMessage(res.statusText!);
                                }
                              });
                            }
                          })),
                  spaceW_1X(),
                  Expanded(
                      child: ElevationIconButtonEx(
                          label: 'رجوع',
                          reversed: true,
                          enabled: true,
                          btnColor: BtnColorEnum.secondary,
                          iconData: FeatherIcons.chevronLeft,
                          onPressed: () {
                            Get.back();
                          })),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }

  bool formIsValid() => !_password1HasError && !_password2HasError;

  displayDebugRegisterInfo() {
    Get.defaultDialog(
        title: "Debug",
        content: Column(
          children: [
            Text("Register:${newReg.user.registerPlan}"),
            Text("Name:${newReg.user.name}"),
            Text("Email:${newReg.user.email}"),
            Text("Phone:${newReg.user.phone}"),
            Text("Address:${newReg.user.address}"),
            Text("Password:${newReg.user.password}"),
          ],
        ),
        radius: 10);
  }
}
