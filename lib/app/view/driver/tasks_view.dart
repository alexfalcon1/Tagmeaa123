import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tagmeea/app/controller/pickup_q_report.dart';
import 'package:tagmeea/app/controller/task_controller.dart';
import 'package:tagmeea/app/view/mobile_scanner.dart';
import 'package:tagmeea/app/view/pages/history_item_details.dart';
import 'package:tagmeea/models/Task.dart';
import 'package:tagmeea/models/recycled_item.dart';
import 'package:tagmeea/widget/loading_data_widget.dart';

import '../../../localization/language_controller.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/theme_manager.dart';
import '../../../widget/helper_widgets.dart';
import '../../controller/user_controller.dart';
import '../pages/cart_item_confirm.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  late ColorScheme theme;
  bool _isLoading = false;
  late List<Task> tasks = [];

  Future loadData() async {
    setState(() {
      _isLoading = true;
    });

    Response data = await TaskController().getTasksAsync();
    if (data.statusCode == 200) {
      tasks = data.body;
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
    ColorScheme theme = themeManager.colorScheme.value;
    UserController userController = Get.find();
    String subscriptionType = userController.user.subscription!;

    return LoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Colors.white.withOpacity(0.8),
      overlayWholeScreen: true,
      overlayWidgetBuilder: (_) {return const Center(
        child: CircularProgressIndicator(),
      );},
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: 100.sw,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/img/bg.jpg'),
                      fit: BoxFit.cover)),
              child: Container(),
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
                    title: Text("my_tasks".tr),
                    actions: [
                      IconButton(
                        onPressed: () {
                          //barcodeScanner
                          Get.to(const MobileScannerView());
                        },
                        icon: const Icon(Icons.qr_code),
                      ),
                    ],
                  ),
                  Expanded(child: tasksView(theme: theme, context: context))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void barcodeScanner() async {
    var status = await Permission.camera.status;
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
    ].request();
    print(statuses[Permission.camera]);

    String barcodeScanRes = '';
    try {
      String scanQRCode = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Close", true, ScanMode.QR);
      if (!mounted) return;

      AlertDialog(
        title: const Text('Scan'),
        content: Text('Order # ID: $scanQRCode'),
      );

      await Get.defaultDialog(
          title: 'Scan', content: Text('Order # ID: $scanQRCode'));
    } on PlatformException {
      print("Error. failed to get platform version");
    }
  }

  Widget tasksView(
      {required ColorScheme theme, required BuildContext context}) {
    return RefreshIndicator(
      onRefresh: () {
        return loadData();
      },
      child: (_isLoading)
          ? LoadingDataWidget(theme: theme)
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                if (tasks[index].status == 'progress') {
                  return Column(
                    children: [
                      ItemButton(
                        theme: theme,
                        task: tasks[index],
                        context: context,
                        onComplete: () {
                          setState(() {
                            loadData();
                          });
                        },
                      ),
                      spaceH_1X(),
                    ],
                  );
                } else {
                  return Container();
                }
              }),
    );
  }
}

class ItemButton extends StatelessWidget {
  const ItemButton({
    super.key,
    required this.theme,
    required this.task,
    required this.context,
    required this.onComplete,
  });

  final ColorScheme theme;
  final Task task;
  final BuildContext context;
  final Function() onComplete;

  @override
  Widget build(BuildContext context) {
    final bool isRTL = LanguageController.isRTL;

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

                Response response = await TaskController()
                    .setTaskCompleteAsync(BigInt.from(task.id));
                await Future.delayed(const Duration(seconds: 3));

                if (response.statusCode == 200) {
                  onComplete();
                }
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
            onPressed: () async {
              debugPrint('Cart ID : ${task.cartId}');
              Response result =  await RecycleController().getShipmentDetails(BigInt.parse(task.cartId.toString()));

              Get.to(()=> CartItemDetails(recycledItems: result.body, taskID: BigInt.parse(task.id.toString())));
            },
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
                          Text('#_${task.cartId}')
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(task.subscriberName),
                          Text(task.pickupAddress.toString())
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}
