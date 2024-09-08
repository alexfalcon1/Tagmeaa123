import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tagmeea/app/controller/pickup_q_report.dart';
import 'package:tagmeea/app/view/page_template_overlay.dart';
import 'package:tagmeea/app/view/pages/view_qr_screen.dart';
import 'package:tagmeea/localization/language_controller.dart';
import 'package:tagmeea/widget/ar_text.dart';

import '../../../models/invoice_item.dart';
import '../../../models/recycled_item.dart';
import '../../../theme/theme_manager.dart';
import '../../../widget/HistoryItemButton.dart';
import '../../../widget/loading_data_widget.dart';
import '../../controller/auth/network_url_constants.dart';

class HistoryItemDetails extends StatelessWidget {
  const HistoryItemDetails({super.key, required this.shipment});

  final InvoiceItem shipment;

  @override
  Widget build(BuildContext context) {
    ThemeManager themeManager = Get.put(ThemeManager());
    ColorScheme theme = themeManager.colorScheme.value;
    var dateFormat = DateFormat.yMMMd().format((shipment.createdAt!));
    var isAr = LanguageController.isRTL;

    return PageTemplateOverlay(
      content: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            title: ArText(
              text: 'تفاصيل شحنة رقم ${shipment.id}',
            ),
            actions: [
              shipment.status == 'open'
                  ? IconButton(
                      onPressed: () {
                        Get.to(() => ViewQRCode(
                              qrData: shipment.id.toString(),
                            ));
                      },
                      icon: const Icon(Icons.qr_code))
                  : Container(),
            ],
          ),
          ArText(
            text: dateFormat,
          ),
          shipment.status == 'progress'
              ? SizedBox(
                  width: 1.sw,
                  child: Image.asset(
                    'assets/img/truck_on_road.png',
                    height: 150.h,
                  ),
                )
              : Container(),
          shipment.status == 'complete'
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      child: SizedBox(
                          width: 170.w,
                          height: 100.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: Text(
                                shipment.totalMoney.toString(),
                                style: TextStyle(
                                    fontFamily: 'Anton', fontSize: 40.sp),
                              )),
                              const Center(
                                child: ArText(
                                  text: 'ريال',
                                ),
                              ),
                            ],
                          )),
                    ),
                    Card(
                      child: SizedBox(
                          width: 170.w,
                          height: 100.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: Text(shipment.totalPoints.toString(),
                                      style: TextStyle(
                                          fontFamily: 'Anton',
                                          fontSize: 40.sp))),
                              const Center(
                                child: ArText(
                                  text: 'نقطة',
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      child: SizedBox(
                          width: 170.w,
                          height: 100.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: Text(shipment.totalPoints.toString(),
                                      style: TextStyle(
                                          fontFamily: 'Anton',
                                          fontSize: 40.sp))),
                              const Center(
                                child: ArText(
                                  text: 'نقطة',
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
          FutureBuilder(
              future: RecycleController().getShipmentDetails(shipment.id!),
              builder: (BuildContext context, AsyncSnapshot<Response> snapshot)
              {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingDataWidget(theme: theme);
                }

                if (snapshot.hasData) {

                  if (snapshot.data?.statusCode == 200) {

                    final List<RecycledItem> recycledItems = snapshot.data?.body;

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.w, vertical: 20.h),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ArText(
                                  text: 'الصنف',
                                ),
                                ArText(
                                  text: 'الكمية',
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: recycledItems
                                .map((item) => Column(
                                      children: [
                                        HistoryItemButton(
                                            buttonText: "${item.quantity}",
                                            title:
                                            isAr? "${item.itemNameAr}":"${item.itemNameEn}",
                                            description:
                                            isAr? "${item.categoryNameAr}":"${item.categoryNameEn}",
                                            subTitle:
                                            isAr? "${item.points} نقطة" : "${item.points} points",
                                            key: Key("${item.itemId}"),
                                            theme: theme,
                                            active: false,
                                            onTap: () {},
                                            imageSrc:
                                            "${NetworkURL.baseUrl}${NetworkURL.catalogIcons}/${item.image}"),
                                        const Divider(),
                                      ],
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ErrorWidget(snapshot.error.toString());
                  }
                } else if (snapshot.hasError) {
                  return ErrorWidget(snapshot.error.toString());
                } else {
                  return LoadingDataWidget(theme: theme);
                }
              }),
        ],
      ),
    );
  }
}
