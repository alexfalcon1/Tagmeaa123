import 'package:get/get.dart';
import 'package:tagmeea/app/controller/internet.dart';

import '../../../theme/theme_manager.dart';
import '../user_controller.dart';
import '../wastes/cart_state.dart';
import '../wastes/catalog_controller.dart';
import '../wastes/catalog_state.dart';
import 'getx_network_manager.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Cart cart = Get.put(Cart(), permanent: true);
    cart.update();

    UserController user = Get.put(UserController(), permanent: true);
    user.update();

    Internet internet = Get.put(Internet(), permanent: true);
    internet.update();

    ThemeManager themeManager = Get.put(ThemeManager(), permanent: true);
    themeManager.update();

    Get.lazyPut(() => GetXNetworkManager(), fenix: true);
    Get.lazyPut(() => CatalogState(), fenix: true);
    Get.lazyPut(() => CatalogController(), fenix: true);
    Get.lazyPut(() => Internet());

  }
}
