import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tagmeea/app/controller/user_controller.dart';
import 'package:tagmeea/models/waste_item.dart';

import '../../../models/user.dart';
import '../../../util/util.dart';
import '../auth/network_url_constants.dart';

class CartItem {
  WasteItem wasteItem = WasteItem();
  int count = 0;
  int index = 0;

  CartItem(WasteItem item, int i, int idx) {
    wasteItem = item;
    count = i;
    index = idx;
  }

  @override
  String toString() {
    return "[id: ${wasteItem.id} name:${wasteItem.nameAr} count: $count index: $index]";
  }
}

class Cart extends GetxController {
  final RxList<CartItem> _items = <CartItem>[].obs;

  List<CartItem> get items => _items;

  add(WasteItem wasteItem, int count) {
    var foundItem = find(wasteItem.id!);

    if (foundItem != null) {
      //items[foundItem.index].count = foundItem.count + 1;
      updateCount(foundItem.index, foundItem.count + 1);
      update();
    } else {
      CartItem cartItem = CartItem(wasteItem, count, items.length);
      _items.add(cartItem);
    }
    refresh();
    update();
  }

  find(int wasteItemId) {
    List<CartItem> foundItems =
        items.where((el) => el.wasteItem.id == wasteItemId).toList();
    if (foundItems.isNotEmpty) {
      return foundItems[0];
    }
    return null;
  }

  updateCount(int index, int count) {
    _items[index].count = count;
    update();
  }

  removeAt(int index) {
    _items.removeAt(index);
    update();
  }

  clear() {
    _items.clear();
    update();
  }

  removeByItemId(int id) {
    List<CartItem> tmpItems = _items;
    tmpItems.map((el) {
      if (el.wasteItem.id == id) {
        _items.remove(el);
      }
    });
  }

  double totalPoints() {
    double total = 0;

    for (var e in _items) {
      total += double.parse(e.wasteItem.points!) * e.count.toDouble();
    }
    return total;
  }

  String totalMoney() {
    double total = 0;
    total = totalPoints() * 0.05;
    var f = NumberFormat('0.0#');
    return f.format(total).toString();
  }

  @override
  toString() {
    String itemStr = '';
    itemStr = _items
        .map((el) =>
            "[id: ${el.wasteItem.id} name:${el.wasteItem.nameAr} count: ${el.count} index: ${el.index}]")
        .toString();
    return itemStr;
  }

  Future<Response> transfer(
      List<CartItem> items, double totalMoney, double totalPoints) async {
    Map<String, String> mainHeader = {
      "Content-type": "application/json; charset=utf8",
      "Authorization": NetworkURL.apiKey
    };

    List<Map<String, dynamic>> data = [];
    User user = await UserController().getUser();

    data = items.map((e) {
      return {
        "user_id": user.id,
        "item_id": e.wasteItem.id,
        "count": e.count,
        "total_points": totalPoints,
        "total_money": totalMoney,
        "points_per_unit": e.wasteItem.points
      };
    }).toList();

    GetConnect connect = GetConnect();
    try {
      connect.allowAutoSignedCert = true;

      Response response = await connect.post(
        NetworkURL.baseUrl + NetworkURL.postCart,
        data,
        contentType: "json",
        headers: mainHeader,
      );
      print(response.bodyString);

      Response handle = Util.handleResponse(response);

      return handle;
    } catch (ex) {
      return Response(statusCode: 500, statusText: ex.toString());
    }
  }
}
