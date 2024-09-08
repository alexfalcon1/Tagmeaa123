import 'dart:convert';

import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:tagmeea/app/controller/wastes/cart_state.dart';
import 'package:tagmeea/app/controller/wastes/catalog_controller.dart';
import 'package:tagmeea/app/controller/wastes/catalog_state.dart';
import 'package:tagmeea/app/view/pages/catalog_browser.dart';
import 'package:tagmeea/theme/app_colors.dart';
import 'package:tagmeea/theme/font_constants.dart';
import 'package:tagmeea/util/media_query.dart';
import 'package:tagmeea/widget/CategoryItemButton.dart';
import 'package:tagmeea/widget/ar_text.dart';
import 'package:tagmeea/widget/cached_network_image_Ex.dart';

import '../../../localization/language_controller.dart';
import '../../../theme/theme_manager.dart';
import '../../../util/util.dart';
import '../../../widget/dialogs.dart';
import '../../../widget/empty_data_widget.dart';
import '../../../widget/helper_widgets.dart';
import '../../controller/auth/network_url_constants.dart';
import 'confirm_screen.dart';

// ignore: must_be_immutable
class CartPage extends GetView {
  CartPage({super.key});

  late CatalogState catalogState;

  late CatalogController catalogController;
  late ColorScheme theme;
  late String? language;

  @override
  Widget build(BuildContext context) {
    ThemeManager themeManager = Get.find();
    ColorScheme theme = themeManager.colorScheme.value;

    catalogController = Get.find();
    Cart cart = Get.find();
    language = LanguageController.getLanguage();

    if (catalogController.catalogList.isEmpty) {
      catalogController.asyncCatalog();
    }
    catalogController.asyncCategories();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          TextButton(
            child: Icon(
              FeatherIcons.plus,
              color: AppColors.danger,
            ),
            onPressed: () {
              Get.to(() => const CatalogBrowser());
            },
          ),
          TextButton(
            child: const Icon(FeatherIcons.trash2),
            onPressed: () {
              cart.clear();
            },
          ),
        ],
        leading: TextButton(
          child: const Icon(FeatherIcons.chevronRight),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'my_cart'.tr,
          style: h5Style,
        ),
      ),
      body: GetBuilder<Cart>(builder: (controller) {
        return Column(
          children: [
            SizedBox(
              height: 0.65.sh,
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: cart.items.isNotEmpty
                        ? cart.items
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(8.0).w,
                                  child: CartItemEx(
                                    cart: cart,
                                    item: e,
                                    theme: theme,
                                    lang: language ?? 'ar',
                                  ),
                                ))
                            .toList()
                        : [
                            EmptyDataWidget(theme: theme),
                          ]),
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  GFButton(
                    onPressed: () {
                      Cart()
                          .transfer(cart.items, double.parse(cart.totalMoney()),
                              cart.totalPoints())
                          .then((res) {
                        if (res.statusCode == Util.responseOK) {
                          Map<String, dynamic> data =
                              jsonDecode(res.bodyString!);
                          cart.clear();
                          Get.delete<Cart>();
                          Get.offAll(() => ConfirmCart(
                                qrData: data['cart_id'].toString(),
                              ));
                        } else {
                          Dialogs.showErrorMessage('connection_error'.tr);
                        }
                      });
                    },
                    text: "confirm_request".tr,
                    textStyle: h5Style.copyWith(color: theme.onBackground),
                    blockButton: true,
                    colorScheme: theme,
                    size: GFSize.LARGE,
                    color: theme.secondaryContainer,
                    shape: GFButtonShape.pills,
                    padding: EdgeInsets.zero,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 18.0),
                    child: SizedBox(
                      width: 1.sw,
                      child: GFBorder(
                        color: theme.surfaceVariant,
                        strokeWidth: 2,
                        dashedLine: const [
                          5,
                          5,
                        ],
                        radius: const Radius.circular(18),
                        type: GFBorderType.rRect,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'total'.tr,
                              style: h4Style,
                            ),
                            Text(
                              "${cart.totalPoints()} ${'points'.tr} = ${cart.totalMoney()} ${'sr'.tr} ",
                              style: h3Style.copyWith(color: theme.primary),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class CartItemEx extends StatelessWidget {
  const CartItemEx({
    super.key,
    required this.item,
    required this.cart,
    required this.theme,
    required this.lang,
  });

  final Cart cart;
  final ColorScheme theme;
  final CartItem item;
  final String lang;

  @override
  Widget build(BuildContext context) {
    String? itemName =
        lang == 'ar' ? item.wasteItem.nameAr : item.wasteItem.nameEn;
    String? unitName =
        lang == 'ar' ? item.wasteItem.unitNameAr : item.wasteItem.unitNameEn;
    return SizedBox(
      width: 1.sw,
      height: 100.h,
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(10),
              onPressed: (ct) {
                cart.removeAt(item.index);
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'حذف',
            ),
          ],
        ),
        child: Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(8).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CachedNetworkImageEx(
                  imageUrl:
                      "${NetworkURL.baseUrl}${NetworkURL.catalogIcons}/${item.wasteItem.image}",
                  width: 60.w,
                  height: 60.h,
                ),
                SizedBox(
                    width: 100.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(itemName!),
                        Text("${item.wasteItem.points!} نقاط / ${unitName!} "),
                      ],
                    )),
                SizedBox(
                  width: 110.w,
                  child: Row(
                    children: [
                      CartStepperInt(
                        size: 30.w,
                        elevation: 0,
                        style: CartStepperStyle(
                            activeBackgroundColor: Colors.transparent,
                            activeForegroundColor: theme.secondary),
                        value: item.count,
                        axis: Axis.horizontal,
                        didChangeCount: (count) {
                          if (count == 0) {
                            cart.removeAt(item.index);
                          } else {
                            cart.updateCount(item.index, count);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CatalogGridView extends StatelessWidget {
  const CatalogGridView({
    super.key,
    required this.catalogController,
    required this.theme,
    required this.catalogState,
    required this.screenInfo,
    required this.lang,
  });

  final CatalogController catalogController;
  final ColorScheme theme;
  final CatalogState catalogState;
  final ScreenInfo screenInfo;
  final String lang;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CatalogController>(
        builder: (b) => Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  Container(
                    height: ScreenUtil().statusBarHeight,
                  ),
                  SizedBox(
                    height: 0.15.sh,
                    child: ListView.builder(
                        itemCount: catalogController.categoryList.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: false,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: CategoryButton(
                              theme: theme,
                              catalogController: catalogController,
                              index: index,
                              active: (catalogState.selectedCategory ==
                                  catalogController.categoryList[index]),
                              onPress: () {
                                int catId =
                                    catalogController.categoryList[index].id!;
                                catalogController
                                    .asyncCatalogByCategoryId(catId);
                                catalogState.selectedCategory =
                                    catalogController.categoryList[index];
                              },
                            ),
                          );
                        }),
                  ),
                  spaceH(20.h),
                  Container(
                    color: Colors.transparent,
                    height: 0.60.sh,
                    child: GetBuilder<CatalogController>(builder: (context) {
                      return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 4 / 1,
                            crossAxisSpacing: screenInfo.setWidth(10),
                            mainAxisSpacing: screenInfo.setWidth(10),
                          ),
                          itemCount: catalogController.catalogList.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return Obx(() {
                              return CategoryItemButton(
                                  buttonText: "",
                                  title: catalogController
                                          .catalogList[index].nameAr ??
                                      '',
                                  description: "description",
                                  subTitle:
                                      "${catalogController.catalogList[index].points} نقطة / ${catalogController.catalogList[index].unitNameEn}",
                                  key: Key(
                                      "${catalogController.catalogList[index].id}"),
                                  theme: theme,
                                  active:
                                      catalogController.catalogList[index].id ==
                                              catalogState.selectedId
                                          ? true
                                          : false,
                                  onTap: () {
                                    catalogState.selectedId = catalogController
                                        .catalogList[index].id!;
                                  },
                                  imageSrc:
                                      "${NetworkURL.baseUrl}${NetworkURL.catalogIcons}/${catalogController.catalogList[index].image}");
                            });
                          });
                    }),
                  ),
                ],
              ),
            ));
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    super.key,
    required this.theme,
    required this.catalogController,
    required this.index,
    this.active = false,
    required this.onPress,
  });

  final ColorScheme theme;
  final CatalogController catalogController;
  final int index;
  final bool active;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: active ? theme.secondaryContainer : theme.surface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: theme.primary.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: -3,
              offset: Offset.fromDirection(1.6, 10),
            )
          ]),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        onPressed: onPress,
        child: Padding(
          padding: const EdgeInsets.all(8.0).r,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GFAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                shape: GFAvatarShape.circle,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CachedNetworkImageEx(
                    imageUrl:
                        "${NetworkURL.baseUrl}${NetworkURL.catalogIcons}/${catalogController.categoryList[index].image}",
                    height: 70.h,
                    width: 70.h,
                  ),
                ),
              ),
              spaceH(10.h),
              ArText(
                text: LanguageController.getCategoryName(
                    catalogController.categoryList[index]),
                fontSize: 12.sp,
              )
            ],
          ),
        ),
      ),
    );
  }
}
