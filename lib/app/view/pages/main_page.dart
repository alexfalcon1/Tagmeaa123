import 'package:enhanced_future_builder/enhanced_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/components/badge/gf_icon_badge.dart';
import 'package:getwidget/position/gf_badge_position.dart';
import 'package:intl/intl.dart';
import 'package:tagmeea/app/controller/pickup_q_report.dart';
import 'package:tagmeea/app/controller/user_controller.dart';
import 'package:tagmeea/app/view/pages/orders.dart';
import 'package:tagmeea/models/invoice_item.dart';
import 'package:tagmeea/widget/empty_data_widget.dart';

import '../../controller/auth/network_url_constants.dart';
import '/widget/helper_widgets.dart';
import '../../../localization/language_controller.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/font_constants.dart';
import '../../../theme/theme_manager.dart';
import '../../../widget/cached_network_image_Ex.dart';
import '../../../widget/error_data_widget.dart';
import '../../../widget/loading_data_widget.dart';
import '../../controller/internet.dart';
import '../../controller/wastes/cart_state.dart';
import 'new_order_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late ValueNotifier<double> valueNotifier;
  late String totalMoney = '0';
  late String totalPoints = '0';
  int progressValue = 75;

  @override
  initState() {
    super.initState();
    valueNotifier = ValueNotifier(75.0);
    calculateTotal();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  Future calculateTotal() async {
    var data = await RecycleController().getUserHistoryTotals();
    if (data.statusCode == 200) {
      Map<String, dynamic> item = data.body;
      var f = NumberFormat('0.0#');
      f.format(item['total_money']).toString();
      totalMoney = f.format(item['total_money']);
      totalPoints = item['total_points'].toString();
    }

    // Future.delayed(const Duration(seconds: 1), () async {
    // });
  }

  @override
  Widget build(BuildContext context) {
    Cart cart = Get.find();
    UserController auth = Get.find();
    ThemeManager themeManager = Get.find();
    //print(auth.user.name);

    final Internet internet = Get.find();
    internet.valueChangedEvent.subscribe((args) {
      //debugPrint("has internet? :${internet.hasConnection}");
    });

    //auth.user = widget.user;
    ColorScheme theme = themeManager.colorScheme.value;
    final String avatarUrl = NetworkURL.baseUrl + NetworkURL.avatarUrl;

    return Scaffold(
        body: Stack(children: [
      Container(
        height: 1.sh,
        decoration: BoxDecoration(
          color: theme.outlineVariant.withOpacity(0.3),
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/img/fullbg.png',
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
        ),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(() {
                      String imagePath =
                          (auth.user.avatar != null) ? auth.user.avatar! : '';

                      if (imagePath != '') {
                        return Container(
                          width: 50.r,
                          height: 50.r,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: theme.primaryContainer,
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: CachedNetworkImageEx(
                            imageUrl: avatarUrl + auth.user.avatar!,
                            width: 50,
                            height: 50,
                          ),
                        );
                      } else {
                        return const SizedBox(
                          width: 1,
                          height: 1,
                        );
                      }
                    }),
                    spaceW_1X(),
                    Obx(() {
                      String shortName =
                          (auth.user.name != null) ? auth.user.name! : '';
                      shortName = shortName.split(' ')[0];
                      return Text(
                        "${"welcome".tr} $shortName",
                        style: h5Style,
                      );
                    }),
                  ],
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Get.to(() => CartPage());
                  },
                  icon: GetBuilder<Cart>(builder: (logic) {
                    return GFIconBadge(
                      counterChild: (cart.items.isNotEmpty)
                          ? GFBadge(
                              child: Text("${cart.items.length}"),
                            )
                          : Container(),
                      position: GFBadgePosition.topStart(top: -15.h),
                      child: const Icon(FeatherIcons.shoppingCart),
                    );
                  }),
                ),
              ],
            ),
            // Progress bar
            spaceH_1X(),
            Container(
              height: 126.h,
              decoration: BoxDecoration(
                  color: theme.background,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: theme.surface, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: theme.surfaceVariant,
                      spreadRadius: 1,
                      blurRadius: 5,
                    )
                  ]),
              child: Padding(
                padding: EdgeInsets.all(20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/img/walletpng.png'),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            EnhancedFutureBuilder(
                              future: calculateTotal(),
                              rememberFutureResult: false,
                              whenDone: (dynamic data) {
                                return RichText(
                                  text: TextSpan(
                                      text: ' ${'you_have'.tr} ',
                                      style: TextStyle(
                                          fontFamily: "Tajawal",
                                          fontSize: 14.sp,
                                          color: AppColors.primary),
                                      children: [
                                        TextSpan(
                                          text: totalMoney,
                                          style: TextStyle(
                                              fontFamily: "Anton",
                                              fontSize: 40.sp,
                                              color: AppColors.danger),
                                        ),
                                        TextSpan(
                                            text: ' ${'sr'.tr} ',
                                            style: TextStyle(fontSize: 14.sp)),
                                      ]),
                                );
                              },
                              whenNotDone: const Center(
                                  child: CircularProgressIndicator()),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   width: 0.2.sw,
                    //   child: Stack(
                    //     alignment: Alignment.center,
                    //     children: [
                    //       SimpleCircularProgressBar(
                    //         size: 80,
                    //         progressStrokeWidth: 8,
                    //         backStrokeWidth: 10,
                    //         progressColors: [theme.primary.withAlpha(240)],
                    //         backColor: theme.primaryContainer,
                    //         animationDuration: 0,
                    //         valueNotifier: valueNotifier,
                    //         mergeMode: true,
                    //         onGetText: (double value) {
                    //           progressValue = value.toInt();
                    //           return const Text('');
                    //         },
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 8, left: 5),
                    //         child: Text(
                    //           "${progressValue.toInt()}%",
                    //           style: TextStyle(
                    //               fontSize: 20,
                    //               fontWeight: FontWeight.bold,
                    //               color: theme.primary.withAlpha(200)),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            spaceH_1X(),
            // Block 2 - navigate to all history
            MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Get.to(() => CartPage());
              },
              child: SizedBox(
                height: 105.h,
                width: 1.sw,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 88.h,
                      decoration: BoxDecoration(
                        color: theme.background,
                        gradient: LinearGradient(colors: [
                          theme.primary,
                          Colors.blue.shade200,
                          theme.primaryContainer
                        ], transform: const GradientRotation(2.1)),
                        borderRadius: BorderRadius.circular(18.r),
                        border: Border.all(color: theme.surface, width: 1),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.w, left: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'browse_all_orders'.tr,
                                    style: TextStyle(
                                        color: theme.background,
                                        fontSize: kHeader6),
                                  ),
                                  Text(
                                    'Press here'.tr,
                                    style: TextStyle(
                                        color: theme.background,
                                        fontSize: kHeader4,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    LanguageController.isRTL
                        ? Positioned(
                            left: 20,
                            bottom: 5,
                            child: Image.asset(
                              'assets/img/water-bottle.png',
                              height: 100.h,
                            ),
                          )
                        : Positioned(
                            right: 20,
                            bottom: 5,
                            child: Image.asset(
                              'assets/img/water-bottle.png',
                              height: 100.h,
                            ),
                          ),
                  ],
                ),
              ),
            ),
            // List of pickups
            spaceH_1X(),
            FutureBuilder<Response>(
                future: RecycleController().getInvoicesAsync(),
                builder: (BuildContext ctx, AsyncSnapshot<Response> snapshot) {
                  if (snapshot.hasData) {
                    Response? result = snapshot.data;

                    if (result?.statusCode == 200) {
                      List<InvoiceItem> invoiceItems = result?.body;
                      return HistoryItems(theme: theme, items: invoiceItems);
                    } else {
                      return ErrorDataWidget(theme: theme);
                    }
                  } else {
                    return EmptyDataWidget(theme: theme);
                  }
                }),
          ],
        ),
      )
    ]));
  }
}

class HistoryItems extends StatelessWidget {
  const HistoryItems({super.key, required this.theme, required this.items});

  final ColorScheme theme;
  final List<InvoiceItem> items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: items.where((el) => el.status == 'open').map((item) {
            return Column(
              children: [
                ItemButton(theme: theme, item: item),
                spaceH_1X(),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
