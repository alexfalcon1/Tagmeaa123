import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:enhanced_future_builder/enhanced_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tagmeea/app/controller/auth/network_url_constants.dart';
import 'package:tagmeea/app/controller/avatar_controller.dart';
import 'package:tagmeea/app/view/pages/page_template_3.dart';
import 'package:tagmeea/widget/helper_widgets.dart';

import '../../../models/user.dart';
import '../../../theme/theme_manager.dart';
import '../../../widget/app_buttons.dart';
import '../../controller/user_controller.dart';
import '../../services/notification_service.dart';

class UserAvatar extends StatefulWidget {
  const UserAvatar({super.key});

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  UserController userController = Get.find<UserController>();

  late User user;

  initData() async {
    user = await UserController().getUser();
  }

  @override
  void initState() {
    // TODO: implement initState
    initData();
    super.initState();
  }

  File? _selectedImage;

  Future _imageFilePicker() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;

    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeManager themeManager = Get.put(ThemeManager());
    final ColorScheme theme = themeManager.colorScheme.value;
    final String avatarUrl = NetworkURL.baseUrl+NetworkURL.avatarUrl;


    return PageTemplate3(
      pageTitle: 'user_image'.tr,
      contents: Column(
        children: [
          EnhancedFutureBuilder(
            future: initData(),
            whenDone: (_) {
              debugPrint(avatarUrl+user.avatar!);
              if (_selectedImage == null) {
                return GFAvatar(
                    radius: 80.h,
                    backgroundColor: theme.secondaryContainer,
                    backgroundImage: NetworkImage(avatarUrl+user.avatar!),
                );
              } else {
                return GFAvatar(
                    radius: 80.h,
                    backgroundColor: theme.secondaryContainer,
                    backgroundImage: FileImage(_selectedImage!));
              }
            },
            whenNotDone: Container(),
            whenWaiting: const CircularProgressIndicator(),
            rememberFutureResult: false,
          ),
          spaceH_1X(),
          ElevationButtonEx(
            text: "change_image".tr,
            foreColor: themeManager.colorScheme().onPrimary,
            backColor: themeManager.colorScheme().primary,
            size: Size(230.w, 50.h),
            onPressed: () {
              _imageFilePicker();
            },
            icon: const Icon(
              Icons.upload_sharp,
              color: Colors.white,
            ),
          ),
          spaceH_1X(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder<UserController>(builder: (_) {
                return ElevationButtonEx(
                  text: "save_image".tr,
                  foreColor: themeManager.colorScheme().onSecondary,
                  backColor: themeManager.colorScheme().secondary,
                  size: Size(230.w, 50.h),
                  onPressed: () async {
                    final dio.Response result =
                        await AvatarController().upload(_selectedImage!.path);
                    if (result.statusCode == 200) {
                      Get.snackbar('avatar'.tr, 'avatar_saved'.tr);
                      user.avatar = result.data['avatar_url'];
                      userController.saveUser(user);
                      userController.user= user;
                    } else {
                      Get.defaultDialog(
                          title: 'error'.tr,
                          content: Text(result.data.toString()));
                    }
                  },
                  icon: const Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                );


                return GFButton(
                  colorScheme: theme,
                  color: theme.secondary,
                  onPressed: () async {
                    final dio.Response result =
                        await AvatarController().upload(_selectedImage!.path);
                    if (result.statusCode == 200) {
                      Get.snackbar('avatar'.tr, 'avatar_saved'.tr);
                      user.avatar = result.data['avatar_url'];
                      userController.saveUser(user);
                      userController.user= user;
                      debugPrint(user.avatar);
                    } else {
                      Get.defaultDialog(
                          title: 'error'.tr,
                          content: Text(result.data.toString()));
                    }
                  },
                  text: "save_image".tr,
                  icon: const Icon(
                    Icons.save_outlined,
                    color: Colors.white,
                  ),
                  size: GFSize.LARGE,
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
