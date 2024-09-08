import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tagmeea/app/controller/wastes/catalog_controller.dart';
import 'package:tagmeea/app/view/pages/new_order_page.dart';
import 'package:tagmeea/app/view/pages/offline_screen.dart';
import 'package:tagmeea/localization/language_controller.dart';
import 'package:tagmeea/models/waste_item.dart';
import 'package:tagmeea/theme/app_theme.dart';
import 'package:tagmeea/widget/empty_data_widget.dart';

import '../../../models/Category.dart';
import '../../../theme/theme_manager.dart';
import '../../../widget/CategoryItemButton.dart';
import '../../../widget/ar_text.dart';
import '../../../widget/cached_network_image_Ex.dart';
import '../../../widget/helper_widgets.dart';
import '../../controller/auth/network_url_constants.dart';
import '../../controller/internet.dart';
import '../../controller/wastes/cart_state.dart';
import '../../controller/wastes/catalog_state.dart';

// ignore: must_be_immutable
class CatalogBrowser extends StatefulWidget {
  const CatalogBrowser({super.key});

  @override
  State<CatalogBrowser> createState() => _CatalogBrowserState();
}

class _CatalogBrowserState extends State<CatalogBrowser> {
  late StreamSubscription subscription;
  late StreamSubscription internetSubscription;
  bool hasInternet = false;

  final Internet internet = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    internet.valueChangedEvent.subscribe((args) {
      debugPrint("has internet? :${args?.changedValue.toString()}");
      setState(() {
        internet.hasConnection = args!.changedValue;
      });
    });

    // subscription = Connectivity().onConnectivityChanged.listen((result) {
    //   final hasInternet = result != ConnectivityResult.none;
    //   setState(() {
    //     this.hasInternet = hasInternet;
    //   });
    // });
    // internetSubscription =
    //     InternetConnectionChecker().onStatusChange.listen((status) {
    //   final hasInternet = status == InternetConnectionStatus.connected;
    //   print("InternetChecker(): $hasInternet");
    //   this.hasInternet = hasInternet;
    // });

    // Future.delayed(const Duration(seconds: 3), () {
    //   catalogController.asyncCategories();
    //   catalogController.asyncCatalog();
    //   print(catalogController.catalogList.toString());
    // });
  }

  late CatalogState catalogState;
  late Cart cart;
  late CatalogController catalogController;
  late ColorScheme theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    catalogState = Get.put(CatalogState());
    cart = Get.find();
    catalogController = Get.put(CatalogController());
  }

  @override
  Widget build(BuildContext context) {
    // final Internet internet = Get.put(Internet(), permanent: true);

    ThemeManager themeManager = Get.put(ThemeManager());
    theme = themeManager.colorScheme.value;

    catalogController.asyncCategories();
    catalogController.asyncCatalog();

    return Scaffold(
        body: FutureBuilder(
            future: InternetConnectionChecker().hasConnection,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                hasInternet = snapshot.data!;
                if (hasInternet) {
                  return onlineWidget();
                } else {
                  return OfflineWidget(
                    theme: theme,
                  );
                }
              } else {
                return Container();
              }
            }));
  }

  Widget onlineWidget() {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              color: theme.outlineVariant.withOpacity(0.3),
              height: 0.3.sh,
            ),
            Container(
              color: theme.background,
              height: 0.7.sh,
            )
          ],
        ),
        Column(
          children: [
            buildAppBar(theme, cart),
            spaceH(20.h),
            GetBuilder<CatalogController>(
              assignId: true,
              builder: (builder) {
                return BuildCategoriesList(
                  theme: theme,
                  catalogController: catalogController,
                  catalogState: catalogState,
                );
              },
            ),
            spaceH(40.h),
            BuildCategoryTitle(
              theme: theme,
              cart: cart,
              catalogState: catalogState,
            ),
            spaceH(20.h),
            GetBuilder<CatalogController>(
              assignId: true,
              builder: (logic) {
                return BuildListItems(
                  cart: cart,
                  theme: theme,
                  catalogController: catalogController,
                  catalogState: catalogState,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

Widget buildAppBar(ColorScheme theme, Cart cart) {
  return Padding(
    padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight * 1.5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Icon(FeatherIcons.chevronRight)),
        const Spacer(),
        GetBuilder<Cart>(
          assignId: true,
          builder: (builder) {
            return ArText(
              color: theme.primary,
              text: "${cart.totalPoints()} ${"points".tr}  / ${cart.totalMoney()}  ${"sr".tr}",
              fontSize: 16.sp,
            );
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.w),
          child: IconButton(
            padding: EdgeInsets.symmetric(vertical: AppTheme.verticalPadding.h),
            onPressed: () {
              Get.to(() => CartPage());
            },
            icon: GFIconBadge(
              counterChild: GFBadge(
                child: GetBuilder<Cart>(builder: (builder) {
                  return Text("${cart.items.length}");
                }),
              ),
              position: GFBadgePosition.topStart(top: -15.h),
              child: const Icon(FeatherIcons.shoppingCart),
            ),
          ),
        ),
      ],
    ),
  );
}

class BuildCategoriesList extends StatelessWidget {
  const BuildCategoriesList({
    super.key,
    required this.theme,
    required this.catalogController,
    required this.catalogState,
  });

  final CatalogController catalogController;
  final ColorScheme theme;
  final CatalogState catalogState;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: AppTheme.sidePadding.w),
      height: 155.h,
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: catalogController.categoryList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            Category category = catalogController.categoryList[index];
            return Padding(
              padding: EdgeInsets.only(left: AppTheme.verticalPadding.w),
              child: CategoryButton(
                theme: theme,
                catalogController: catalogController,
                index: index,
                active: (catalogState.selectedCategory == category),
                onPress: () {
                  int catId = category.id!;
                  catalogController.asyncCatalogByCategoryId(catId);
                  catalogState.selectedCategory = category;
                },
              ),
            );
          }),
    );
  }
}

class BuildCategoryTitle extends StatelessWidget {
  const BuildCategoryTitle({
    super.key,
    required this.cart,
    required this.theme,
    required this.catalogState,
  });

  final ColorScheme theme;
  final CatalogState catalogState;
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 8.h, horizontal: AppTheme.sidePadding.w),
      width: 1.sw,
      height: 40.h,
      child: Row(
        children: [
          Icon(
            FeatherIcons.feather,
            color: theme.inversePrimary,
          ),
          spaceW(5.w),
          GetBuilder<CatalogState>(builder: (builder) {
            return ArText(
              text:
              LanguageController.isRTL ?
              catalogState.selectedCategory.nameAr ?? "الكل" :
              catalogState.selectedCategory.nameEn ?? "All",
              fontSize: 20.sp,
            );
          }),
        ],
      ),
    );
  }
}

class BuildListItems extends StatelessWidget {
  const BuildListItems(
      {super.key,
      required this.catalogController,
      required this.theme,
      required this.catalogState,
      required this.cart});

  final CatalogController catalogController;
  final ColorScheme theme;
  final CatalogState catalogState;
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    String? itemName;
    String? unitName;
    String? categoryName;

    return Expanded(
      child: GetBuilder<CatalogController>(builder: (context) {
         return catalogController.catalogList.isNotEmpty?
         ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: catalogController.catalogList.length,
            itemBuilder: (BuildContext ctx, index) {
              WasteItem wasteItem = catalogController.catalogList[index];

              itemName = LanguageController.isRTL ? wasteItem.nameAr : wasteItem.nameEn;
              unitName = LanguageController.isRTL ? wasteItem.unitNameAr : wasteItem.unitNameEn;
              categoryName = LanguageController.isRTL ? wasteItem.categoryNameAr : wasteItem.categoryNameEn;

              return CategoryItemButton(
                  buttonText: "${wasteItem.points} + ",
                  title: itemName!,
                  description: "",
                  subTitle: "${wasteItem.points} ${"points".tr}/${unitName!}",
                  key: Key("${wasteItem.id}"),
                  theme: theme,
                  active:
                      wasteItem.id == catalogState.selectedId ? true : false,
                  onTap: () {
                    catalogState.selectedId = wasteItem.id!;
                    cart.add(wasteItem, 1);
                  },
                  imageSrc:
                      "${NetworkURL.baseUrl}${NetworkURL.catalogIcons}/${wasteItem.image}");
            }):
         EmptyDataWidget(theme: theme);
      }),
    );
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
