import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tagmeea/util/qrscanneroverlay.dart';

class MobileScannerView extends StatelessWidget {
  const MobileScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Container()),
        Expanded(
          flex: 4,
          child: MobileScanner(onDetect: (barCode) {
            Get.defaultDialog(
                title: 'Result', content: Text(barCode.toString()));
          }, overlay: QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5),),),
        ),
        Expanded(child: Container()),
      ],
    );
  }
}
