import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tagmeea/app/view/pages/page_template_3.dart';
import 'package:tagmeea/widget/empty_data_widget.dart';

import '../../../localization/language_controller.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/theme_manager.dart';
import '../../../widget/helper_widgets.dart';
import '../../../widget/loading_data_widget.dart';
import '../../controller/wastes/catalog_controller.dart';

class MyNotifications extends StatefulWidget {
  const MyNotifications({super.key});

  @override
  State<MyNotifications> createState() => _MyNotificationsState();
}

class _MyNotificationsState extends State<MyNotifications> {

  late ColorScheme theme;
  bool _isLoading = false;
  late List<dynamic> notificationItems;

  Future loadData() async {
    setState(() {
      _isLoading = true;
    });

    Response data = await CatalogController().getNewAcceptedItems();

    if (data.statusCode == 200) {
      notificationItems = data.body['data']??[];

      setState(() {
        _isLoading = false;
      });

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {

    ThemeManager themeManager = Get.put(ThemeManager());
    theme = themeManager.colorScheme.value;

    return PageTemplate3(
      pageTitle: 'notifications'.tr,
        contents: RefreshIndicator(
        onRefresh: (){return loadData();},
        child: (_isLoading)
            ? LoadingDataWidget(theme: theme)
            : notificationItems.isNotEmpty ?
        ListView.builder(
            shrinkWrap: true,
            itemCount: notificationItems.length,
            itemBuilder: (ctx, index) {
              var item = notificationItems[index];
              //debugPrint(cart_id.toString());
                return Column(
                  children: [
                    ItemButton(theme: theme, item: item, context: context, onComplete: (){}),
                    spaceH_1X(),
                  ],
                );
            }):
        EmptyDataWidget(theme: theme),
      )
    );
  }
}

class ItemButton extends StatelessWidget {
  const ItemButton({
    super.key,
    required this.theme,
    required this.item,
    required this.context,
    required this.onComplete,
  });

  final ColorScheme theme;
  final Map<String,dynamic>item;
  final BuildContext context;
  final Function() onComplete;

  @override
  Widget build(BuildContext context) {
    final bool isRTL = LanguageController.isRTL;
    var createdAt = DateFormat.yMMMd().format(DateTime.parse(item["updated_at"]));
    var cartId = item['data']['cart_id'];

    return Slidable(
      // Specify a key if the Slidable is dismissible.
        key: const ValueKey(0),

        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // A pane can dismiss the Slidable.
          dismissible: DismissiblePane(onDismissed: () {}),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (ct) async {
                context.loaderOverlay.show();
                context.loaderOverlay.hide();
              },
              backgroundColor: AppColors.success,
              foregroundColor: Colors.white,
              icon: Icons.check,
              label: 'تم الاستلام',
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.warning.withAlpha(20),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.warning, width: 1),
          ),
          child: MaterialButton(
            onPressed: () async {},
            splashColor: AppColors.warning.withAlpha(50),
            hoverColor: AppColors.warning.withAlpha(50),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('رقم الطلب'),
                          Text('#_$cartId')
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text( createdAt.toString()),
                          const Text('اعتماد الطلب')
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}
