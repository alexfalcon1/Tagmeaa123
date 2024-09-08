import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tagmeea/app/controller/pickup_q_report.dart';
import 'package:tagmeea/app/view/page_template_overlay.dart';
import 'package:tagmeea/localization/language_controller.dart';
import 'package:tagmeea/widget/ar_text.dart';

import '../../../models/recycled_item.dart';
import '../../../theme/theme_manager.dart';
import '../../../widget/HistoryItemButton.dart';
import '../../../widget/loading_data_widget.dart';
import '../../controller/auth/network_url_constants.dart';
import '../../controller/task_controller.dart';

class CartItemDetails extends StatelessWidget {
  const CartItemDetails({super.key, required this.recycledItems, required this.taskID});

  final List<RecycledItem> recycledItems;
  final BigInt taskID;

  @override
  Widget build(BuildContext context) {
    ThemeManager themeManager = Get.put(ThemeManager());
    ColorScheme theme = themeManager.colorScheme.value;
    var isAr = LanguageController.isRTL;
    final shipment = recycledItems[0];

    final thisContext = context;

    var dateFormat =
        DateFormat.yMMMd().format(DateTime.parse(shipment.createdAt!));

    return PageTemplateOverlay(
      content: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            title: ArText(
              text: '${'shipment_details'.tr} ${'code'.tr} : ${shipment.cartId}',
            ),
            actions: [
              IconButton(
                onPressed: () {
                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.noHeader,
                      animType: AnimType.rightSlide,
                      title: 'confirm'.tr,
                      desc: 'confirmed'.tr,
                      btnCancelText: 'cancel'.tr,
                      btnOkText: 'ok'.tr,
                      btnCancelOnPress: () {},
                      btnOkOnPress: () async {

                        thisContext.loaderOverlay.show();

                        Response response = await TaskController()
                            .setTaskCompleteAsync(taskID);
                        await Future.delayed(const Duration(seconds: 3));

                        if (context.mounted)
                          {
                            context.loaderOverlay.hide();
                          }

                        //printInfo(info: response.bodyString!);
                        if (response.statusCode == 200) {
                          Get.back();
                        }
                        else{

                          if(context.mounted)
                            {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'error'.tr,
                                desc: 'connection_error'.tr,
                                btnCancelText: 'cancel'.tr,
                                btnCancelOnPress: () {},
                              ).show();
                            }

                        }}).show();
                },
                icon: const Icon(Icons.check),
              )
            ],
          ),
          ArText(
            text: dateFormat,
          ),
          Row(
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
                          style:
                              TextStyle(fontFamily: 'Anton', fontSize: 40.sp),
                        )),
                        Center(
                          child: ArText(
                            text: 'sr'.tr,
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
                                    fontFamily: 'Anton', fontSize: 40.sp))),
                        Center(
                          child: ArText(
                            text: 'point'.tr,
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
          FutureBuilder(
              future: RecycleController()
                  .getShipmentDetails(BigInt.parse(shipment.cartId.toString())),
              builder:
                  (BuildContext context, AsyncSnapshot<Response> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingDataWidget(theme: theme);
                }

                if (snapshot.hasData) {
                  if (snapshot.data?.statusCode == 200) {
                    final List<RecycledItem> recycledItems =
                        snapshot.data?.body;

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.w, vertical: 20.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ArText(
                                  text: 'item'.tr,
                                ),
                                ArText(
                                  text: 'quantity'.tr,
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
                                            title: isAr
                                                ? "${item.itemNameAr}"
                                                : "${item.itemNameEn}",
                                            description: isAr
                                                ? "${item.categoryNameAr}"
                                                : "${item.categoryNameEn}",
                                            subTitle: isAr
                                                ? "${item.points} نقطة "
                                                : "${item.points} points",
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
