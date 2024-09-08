import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:get/get.dart';
import 'package:tagmeea/app/controller/auth/sign_up.dart';
import 'package:tagmeea/app/view/auth/register_contact.dart';
import 'package:tagmeea/theme/app_colors.dart';
import 'package:tagmeea/theme/font_constants.dart';
import 'package:tagmeea/widget/helper_widgets.dart';

import '/app/controller/registration_type_controller.dart';
import '/app/view/page_template_overlay.dart';
import '../../../models/registration.dart';
import '../../../widget/app_icon_buttons.dart';
import '../../../widget/validation_text_form_field.dart';
import '../../controller/button_type_enum.dart';

class RegisterBasic extends StatefulWidget {
  const RegisterBasic({super.key});

  @override
  State<RegisterBasic> createState() => _RegisterBasicState();
}

class _RegisterBasicState extends State<RegisterBasic> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool emailHasError = true;
  bool nameHasError = true;

  @override
  void initState() {
    // TODO: implement initState
    formIsValid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RegistrationTypeController registrationType =
        Get.put(RegistrationTypeController());

    Registration newReg = Get.put(Registration());

    String assetPath = '';

    switch (registrationType.selected) {
      case RegistrationTypeEnum.individual:
        assetPath = "assets/img/person.png";
        break;
      case RegistrationTypeEnum.government:
        // TODO: Handle this case.
        assetPath = "assets/img/business-man.png";
        break;
      case RegistrationTypeEnum.semiGovernment:
        // TODO: Handle this case.
        assetPath = "assets/img/company.png";
        break;
      case RegistrationTypeEnum.pilot:
        // TODO: Handle this case.
        assetPath = "assets/img/truck.png";
        break;
    }
    newReg.user.assetPath = assetPath;
    newReg.user.registerPlan = registrationType.selected.toArString;

    return PageTemplateOverlay(
      content: Obx(() {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: getSi().setWidth(20)),
          child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  spaceH_2X(),
                  Image.asset(assetPath, width: getSi().setWidth(90)),
                  spaceH_2X(),
                  Text("إشتراك ${registrationType.selected.toArString}",
                      style: h3Style),
                  spaceH_2X(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("بيانات أساسية",
                          style: h3Style.copyWith(color: AppColors.primary)),
                    ],
                  ),
                  FormBuilder(
                    key: _formKey,
                    onChanged: () {
                      _formKey.currentState!.save();
                    },
                    child: Column(
                      children: [
                        spaceH_2X(),
                        ValidationTextFormField(
                          textInputType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          icon: FeatherIcons.atSign,
                          name: "email",
                          labelText: "البريد الإليكتروني",
                          secured: false,
                          onSuccess: (val) {
                            setState(() {
                              newReg.user.email = val;
                              emailHasError = false;
                            });
                          },
                          onError: (err) {
                            setState(() {
                              emailHasError = true;
                            });
                          },
                          regexValidation: const {
                            FzPattern.email: 'البريد غير صحيح'
                          },
                          rules: const {
                            'required': 'حقل مطلوب',
                          },
                        ),
                        ValidationTextFormField(
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          icon: FeatherIcons.user,
                          name: "name",
                          labelText: "الاسم",
                          secured: false,
                          onSuccess: (val) {
                            setState(() {
                              newReg.user.name = val;
                              nameHasError = false;
                            });
                          },
                          onError: (err) {
                            setState(() {
                              nameHasError = true;
                            });
                          },
                          minLength: 3,
                          regexValidation: const {},
                          rules: const {
                            'required': 'حقل مطلوب',
                            'min|3': 'الحقل لا يقل عن ٣ حروف'
                          },
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                                child: ElevationIconButtonEx(
                                    label: 'التالي',
                                    btnColor: BtnColorEnum.primary,
                                    enabled: true,
                                    iconData: FeatherIcons.chevronRight,
                                    onPressed: () async {
                                      //await emailFound(newReg.user.email!);

                                      if (formIsValid()) {
                                        Get.to(() => const RegisterContact());
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
                      ],
                    ),
                  )
                ],
              )),
        );
      }),
    );
  }

  emailFound(String email) async {
    Response res = await SignUp().emailIsExist(email);

    debugPrint(res.statusText);
  }

  bool formIsValid() {
    // debugPrint(
    //     "$nameHasError : $emailHasError : ${(!nameHasError &&
    //         !emailHasError)}");
    return (!nameHasError && !emailHasError);
  }
}
