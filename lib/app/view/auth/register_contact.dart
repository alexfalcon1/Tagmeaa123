import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:get/get.dart';
import 'package:tagmeea/app/view/auth/register_password.dart';

import '../../../models/registration.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/font_constants.dart';
import '../../../widget/app_icon_buttons.dart';
import '../../../widget/helper_widgets.dart';
import '../../../widget/validation_text_form_field.dart';
import '../../controller/button_type_enum.dart';
import '../page_template_overlay.dart';

class RegisterContact extends StatefulWidget {
  const RegisterContact({super.key});

  @override
  State<RegisterContact> createState() => _RegisterContactState();
}

class _RegisterContactState extends State<RegisterContact> {
  Registration newReg = Get.put(Registration());
  final _formKey = GlobalKey<FormBuilderState>();

  bool _addressHasError = true;
  bool _phoneHasError = true;

  @override
  void initState() {
    // TODO: implement initState
    formIsValid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplateOverlay(
      content: Obx(() => Padding(
            padding: EdgeInsets.symmetric(horizontal: getSi().setWidth(20)),
            child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    spaceH_2X(),
                    Image.asset(newReg.user.assetPath!,
                        width: getSi().setWidth(90)),
                    spaceH_2X(),
                    Text("إشتراك ${newReg.user.registerPlan}", style: h3Style),
                    spaceH_2X(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("بيانات الإتصال",
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
                            name: "phone",
                            labelText: "رقم الهاتف",
                            secured: false,
                            onSuccess: (val) {
                              newReg.user.phone = val;
                              setState(() {
                                _phoneHasError = false;
                              });
                            },
                            onError: (err) {
                              setState(() {
                                _phoneHasError = true;
                              });
                            },
                            regexValidation: const {
                              FzPattern.phone: 'الرقم غير صحيح'
                            },
                            rules: const {
                              'required': 'حقل مطلوب',
                              "min|10": "لا يقل عن ١٠ حروف",
                            },
                          ),
                          ValidationTextFormField(
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            icon: FeatherIcons.user,
                            name: "address",
                            oldValue: newReg.user.address,
                            labelText: "العنوان",
                            secured: false,
                            onSuccess: (val) {
                              newReg.user.address = val;
                              setState(() {
                                _addressHasError = false;
                              });
                            },
                            onError: (err) {
                              setState(() {
                                _addressHasError = true;
                              });
                            },
                            minLength: 3,
                            regexValidation: const {},
                            rules: const {
                              'required': 'حقل مطلوب',
                              'min|10': 'الحقل لا يقل عن ١٠ حروف'
                            },
                          ),
                          Flex(
                            direction: Axis.horizontal,
                            children: [
                              Expanded(
                                  child: ElevationIconButtonEx(
                                      label: 'التالي',
                                      btnColor: BtnColorEnum.primary,
                                      enabled: formIsValid(),
                                      iconData: FeatherIcons.chevronRight,
                                      onPressed: () {
                                        if (formIsValid()) {
                                          Get.to(
                                              () => const RegisterPassword());
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
          )),
    );
  }

  bool formIsValid() => !_phoneHasError && !_addressHasError;
}
