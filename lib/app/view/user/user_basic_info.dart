import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
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

class UpdateBasicUserInfo extends StatefulWidget {
  const UpdateBasicUserInfo({super.key});

  @override
  State<UpdateBasicUserInfo> createState() => _UpdateBasicUserInfoState();
}

class _UpdateBasicUserInfoState extends State<UpdateBasicUserInfo> {
  String name = '';
  String phone = '';
  String address = '';

  Future<User> getUser() async {
    User user = await LocalData.getUser;

    user.name == 'username';
    //
    // user.phone==null? '0000':user.phone!;
    //
    // user.address==null? 'user_address':'user_address';

    print('Name  : ${user.name}');

    name = user.name!;
    phone = user.phone!;
    address = user.address!;

    return user;
  }

  @override
  Widget build(BuildContext context) {
    UserController current = Get.find<UserController>();

    return FutureBuilder<User>(
      future: getUser(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasData) {
          final User myUser = snapshot.data!;
          return Column(
            children: [
              ValidationTextFormField(
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                icon: FeatherIcons.user,
                name: "name",
                labelText: "name".tr,
                oldValue: myUser.name ?? '',
                secured: false,
                onSuccess: (val) {
                  name = val!;
                  // nameHasError = false;
                },
                onError: (err) {
                  setState(() {
                    // nameHasError = true;
                  });
                },
                minLength: 3,
                regexValidation: const {},
                rules: const {
                  'required': 'حقل مطلوب',
                  'min|3': 'الحقل لا يقل عن ٣ حروف'
                },
              ),
              ValidationTextFormField(
                textInputType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                icon: FeatherIcons.atSign,
                oldValue: myUser.phone ?? '',
                name: "phone",
                labelText: "phone_number".tr,
                secured: false,
                onSuccess: (val) {
                  phone = val!;
                  //_phoneHasError = false;
                },
                onError: (err) {},
                regexValidation: const {FzPattern.phone: 'الرقم غير صحيح'},
                rules: const {
                  'required': 'حقل مطلوب',
                  "min|10": "لا يقل عن ١٠ حروف",
                },
              ),
              ValidationTextFormField(
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                icon: FeatherIcons.home,
                name: "address",
                oldValue: myUser.address ?? '',
                //newReg.user.address,
                labelText: "address".tr,
                secured: false,
                onSuccess: (val) {
                  address = val!;
                },
                onError: (err) {},
                minLength: 3,
                regexValidation: const {},
                rules: const {
                  'required': 'حقل مطلوب',
                  'min|10': 'الحقل لا يقل عن ١٠ حروف'
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
                        current.updateBasicInfo(name, address, phone).then(
                          (response) async {
                            if (response.statusCode == 200) {
                              User user = User.fromJson(response.body);
                              current.saveUser(user);
                              Get.snackbar("save".tr, "basic_info".tr);
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
          return Container(
            child: const Text('** No Data **'),
          );
        }
      },
    );
  }
}
