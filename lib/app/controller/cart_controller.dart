import 'package:get/get.dart';

class CartController extends GetConnect{

  late Map<String, String> _mainHeader;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    allowAutoSignedCert = true;
  }

}