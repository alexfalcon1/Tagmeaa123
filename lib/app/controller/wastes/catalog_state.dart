import 'package:get/get.dart';
import 'package:tagmeea/models/Category.dart';

class CatalogState extends GetxController {
  static final RxInt _selectedId = 0.obs;
  final Rx<Category> _selectedCategory = Category().obs;

  get selectedId => _selectedId.value;

  set selectedId(id) {
    _selectedId.value = id;
    update();
  }

  Category get selectedCategory => _selectedCategory.value;
  set selectedCategory(Category cat) {
    _selectedCategory.value = cat;
    update();
  }
}
