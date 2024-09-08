import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tagmeea/localization/language_controller.dart';
import 'package:tagmeea/widget/empty_data_widget.dart';
import 'package:tagmeea/widget/helper_widgets.dart';

import '../../../models/invoice_item.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/font_constants.dart';
import '../../../theme/theme_manager.dart';
import '../../../widget/loading_data_widget.dart';
import '../../controller/pickup_q_report.dart';
import 'history_item_details.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> with TickerProviderStateMixin {
  late ColorScheme theme;
  bool _isLoading = false;
  late List<InvoiceItem> invoiceItems = [];
  final status = ['status_open', 'status_progress', 'status_complete'];

  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  Future loadData() async {
    setState(() {
      _isLoading = true;
    });

    Response data = await RecycleController().getInvoicesAsync();
    if (data.statusCode == 200) {
      invoiceItems = data.body;

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    ThemeManager themeManager = Get.put(ThemeManager());
    theme = themeManager.colorScheme.value;
    //UserController userController = Get.find<UserController>();

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
              )),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
        ),
        child: Column(children: [
          AppBar(
            backgroundColor: Colors.transparent,
            title: Text("my_orders".tr),
          ),
          SizedBox(
            height: 40,
            child: TabBar(
              indicator: BoxDecoration(
                  color: theme.secondaryContainer,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8.r)),
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: theme.secondary,
              indicatorColor: Colors.transparent,
              indicatorWeight: 2,
              dividerColor: Colors.transparent,
              onTap: (index) {
                setState(() {});
              },
              tabs: [
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: Tab(
                      icon: Image.asset('assets/img/status/pending.png'),
                      height: 25.h,
                    )),
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                    child: Tab(
                      icon: Image.asset('assets/img/status/truck.png'),
                      height: 40.h,
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                    ),
                    child: Tab(
                      icon: Image.asset('assets/img/status/complete2.png'),
                      height: 25.h,
                    )),
              ],
            ),
          ),
          spaceH_1X(),
          Text(
            status[_tabController.index].tr,
            style: h3Style,
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              tabView(status: 'open'),
              tabView(status: 'progress'),
              tabView(status: 'complete'),
            ]),
          ),
        ]),
      ),
    ]));
  }

  Widget tabView({String? status}) {
    return RefreshIndicator(
      onRefresh: () {
        return loadData();
      },
      child: (_isLoading)
          ? LoadingDataWidget(theme: theme)
          : invoiceItems.isNotEmpty?
      ListView.builder(
              itemCount: invoiceItems.length,
              itemBuilder: (ctx, index) {
                if (invoiceItems[index].status == status) {
                  return Column(
                    children: [
                      ItemButton(theme: theme, item: invoiceItems[index]),
                      spaceH_1X(),
                    ],
                  );
                }
                return Container();
              }) :
      EmptyDataWidget(theme: theme),
    );
  }
}

class ItemButton extends StatelessWidget {
  const ItemButton({
    super.key,
    required this.theme,
    required this.item,
  });

  final ColorScheme theme;
  final InvoiceItem item;

  @override
  Widget build(BuildContext context) {
    final bool isRTL = LanguageController.isRTL;

    return Container(
      height: 107.h,
      decoration: BoxDecoration(
        color: AppColors.warning.withAlpha(20),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.warning, width: 1),
      ),
      child: MaterialButton(
        onPressed: () {
          Get.to(() => HistoryItemDetails(shipment: item));
        },
        splashColor: AppColors.warning.withAlpha(50),
        hoverColor: AppColors.warning.withAlpha(50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100.w,
                    child: item.status == "complete"
                        ? Column(
                            children: [
                              Text(
                                "${item.totalMoney}",
                                style: h2Style.copyWith(
                                    fontFamily: 'Anton',
                                    color: AppColors.success),
                              ),
                              Text(
                                "sr".tr,
                                style: h5Style.copyWith(
                                    fontFamily: 'Anton',
                                    color: AppColors.success),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${item.totalPoints}",
                                style: h3Style.copyWith(
                                    fontFamily: 'Anton',

                                    color: AppColors.danger),
                              ),
                              Text(
                                "points".tr,
                                style: h5Style.copyWith(
                                    fontFamily: 'Anton',
                                    color: AppColors.danger),
                              ),
                            ],
                          )),
                SizedBox(
                  width: 100.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(FeatherIcons.calendar),
                      Text(
                        DateFormat.yMMMd().format(item.createdAt!),
                        style: TextStyle(color: theme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 80.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        clipBehavior: Clip.none,
                        width: 50.r,
                        height: 50.r,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              scale: 1,
                              alignment: Alignment(isRTL ? -1 : 1, 0),
                              image: item.status == "open"
                                  ? const AssetImage(
                                      'assets/img/status/pending.png')
                                  : item.status == "progress"
                                      ? const AssetImage(
                                          'assets/img/status/truck.png')
                                      : item.status == "complete"
                                          ? const AssetImage(
                                              'assets/img/status/complete2.png')
                                          : const AssetImage(
                                              'assets/img/status/bottle.png')),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
