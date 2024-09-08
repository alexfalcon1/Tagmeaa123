import 'dart:convert';

import 'package:get/get.dart';
import 'package:tagmeea/models/Category.dart';
import 'package:tagmeea/models/waste_item.dart';

import '../../../models/user.dart';
import '../../../util/local_data.dart';
import '../../../util/util.dart';
import '../auth/network_url_constants.dart';

class CatalogController extends GetxController {
  late final RxList<WasteItem> wasteItemsList = <WasteItem>[].obs;
  final RxList<Category> categoryList = <Category>[].obs;

  late Map<String, String> _mainHeader;
  GetConnect connect = GetConnect();

  Future<Response> asyncCatalog() async {
    _mainHeader = {
      "Content-type": "application/json; charset=utf8",
      "Authorization": NetworkURL.apiKey
    };

    try {
      connect.allowAutoSignedCert = true;
      Response response = await connect.get(
        NetworkURL.baseUrl + NetworkURL.catalog,
        headers: _mainHeader,
      );

      Response handle = Util.handleResponse(response);

      if (handle.statusCode == 200) {
        List<dynamic> json = jsonDecode(handle.bodyString!)['data'];

        wasteItemsList.clear();

        for (Map<String, dynamic> item in json) {
          WasteItem wasteItem = WasteItem.fromJson(item);
          wasteItemsList.add(wasteItem);
        }
        wasteItemsList.refresh();
        update();
        return Response(statusCode: 200, body: wasteItemsList);
      } else {
        return const Response(statusCode: 201, body: null);
      }
    } catch (ex) {
      return Response(statusCode: 500, statusText: ex.toString());
    }
  }

  Future<Response> asyncCatalogByCategoryId(int catId) async {
    _mainHeader = {
      "Content-type": "application/json; charset=utf8",
      "Authorization": NetworkURL.apiKey
    };

    try {
      connect.allowAutoSignedCert = true;
      Response response = await connect.get(
        NetworkURL.baseUrl + NetworkURL.catalog,
        headers: _mainHeader,
      );

      Response handle = Util.handleResponse(response);

      if (handle.statusCode == 200) {
        List<dynamic> json = jsonDecode(handle.bodyString!)['data'];

        wasteItemsList.clear();

        for (Map<String, dynamic> item in json) {
          WasteItem wasteItem = WasteItem.fromJson(item);

          if (wasteItem.categoryId == catId) {
            wasteItemsList.add(wasteItem);
          }
        }
        update();
        wasteItemsList.refresh();
      }

      return handle;
    } catch (ex) {
      return Response(statusCode: 500, statusText: ex.toString());
    }
  }

  Future<Response> asyncCategories() async {
    _mainHeader = {
      "Content-type": "application/json; charset=utf8",
      "Authorization": NetworkURL.apiKey
    };

    try {
      connect.allowAutoSignedCert = true;
      Response response = await connect.get(
        NetworkURL.baseUrl + NetworkURL.categories,
        headers: _mainHeader,
      );

      Response handle = Util.handleResponse(response);

      if (handle.statusCode == 200) {
        List<dynamic> json = jsonDecode(handle.bodyString!)['data'];

        categoryList.clear();

        for (Map<String, dynamic> item in json) {
          Category category = Category.fromJson(item);
          categoryList.add(category);
        }
        categoryList.refresh();
        update();
        return Response(statusCode: 200, body: categoryList);
      } else {
        return const Response(statusCode: 201, body: null);
      }
    } catch (ex) {
      return Response(statusCode: 500, statusText: ex.toString());
    }
  }

  List<WasteItem> get catalogList {
    return [...wasteItemsList];
  }

  List<Category> get categories {
    return [...categoryList];
  }

  WasteItem getWasteItemById(int id) {
    return wasteItemsList.where((el) => el.id == id).toList()[0];
  }

  List<WasteItem> getWasteItemByCategoryId(int catId) {
    return wasteItemsList.where((el) => el.categoryId == catId).toList();
  }

  Future<Response> getNewAcceptedItems() async {
    try {
      User user = await LocalData.getUser;
      connect.allowAutoSignedCert = true;
      Response response = await connect.get(
          "${NetworkURL.baseUrl}${NetworkURL.newAcceptedItems}",
          contentType: 'json',
          headers: NetworkURL.mainHeader,
          query: {'id': user.id});

      //debugPrint('CatalogController :  ${user.id.toString()}');
      //debugPrint('CatalogController :  ${response.bodyString}');

      //Response handle = Util.handleResponse(response);
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.bodyString!);
        return Response(statusCode: 200, bodyString: 'success', body: json);
      }
      return Response(
          statusCode: 200, bodyString: 'success', body: response.bodyString);
    } catch (ex) {
      return Response(statusCode: 500, statusText: ex.toString());
    }
  }

}
