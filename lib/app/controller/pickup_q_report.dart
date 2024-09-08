import 'dart:convert';

import 'package:get/get.dart';
import 'package:tagmeea/models/recycled_item.dart';
import 'package:tagmeea/models/user.dart';
import 'package:tagmeea/util/local_data.dart';

import '../../models/invoice_item.dart';
import '../../util/util.dart';
import 'auth/network_url_constants.dart';

class RecycleController extends GetxController {
  late double totalMoney;
  late double totalPoints;
  late Map<String, String> _mainHeader;
  GetConnect connect = GetConnect();

  @override
  void onInit() {
    super.onInit();
    totalMoney = 0.0;
    totalPoints = 0.0;
  }

  Future<Response> getInvoicesAsync() async {
    late List<InvoiceItem> invoiceItems = [];

    try {
      User user = await LocalData.getUser;
      connect.allowAutoSignedCert = true;
      Response response = await connect.get(
        "${NetworkURL.baseUrl}${NetworkURL.getHistory}",
        contentType: "json",
        headers: NetworkURL.mainHeader,
        query: {"user_id": user.id},
      );

      Response handle = Util.handleResponse(response);

      if (handle.statusCode == 200) {
        List<dynamic> json = jsonDecode(handle.bodyString!)['data'];
        for (Map<String, dynamic> item in json) {
          invoiceItems.add(InvoiceItem.fromJson(item));
        }
      }
      return Response(statusCode: 200, body: invoiceItems);
    } catch (ex) {
      return Response(statusCode: 500, statusText: ex.toString());
    }
  }

  Future<Response> getPickupListAsync() async {
    late List<RecycledItem> recycledItems = [];

    try {
      User user = await LocalData.getUser;
      //print(user.id);
      connect.allowAutoSignedCert = true;
      Response response = await connect.get(
        "${NetworkURL.baseUrl}${NetworkURL.getHistory}",
        contentType: "json",
        headers: NetworkURL.mainHeader,
        query: {"user_id": user.id},
      );

      Response handle = Util.handleResponse(response);

      if (handle.statusCode == 200) {
        List<dynamic> json = jsonDecode(handle.bodyString!)['data'];

        for (Map<String, dynamic> item in json) {
          recycledItems.add(RecycledItem.fromJson(item));
        }
      }

      return Response(statusCode: 200, body: recycledItems);
    } catch (ex) {
      return Response(statusCode: 500, statusText: ex.toString());
    }
  }

  Future<Response> getShipmentDetails(BigInt id) async {
    late List<RecycledItem> recycledItems = [];
    try {
      User user = await LocalData.getUser;
      print("${NetworkURL.baseUrl}${NetworkURL.getCartDetails}");
      connect.allowAutoSignedCert = true;
      Response response = await connect.get(
        "${NetworkURL.baseUrl}${NetworkURL.getCartDetails}",
        contentType: "json",
        headers: NetworkURL.mainHeader,
        query: {"user_id": user.id, "cart_id": "$id"},
      );

      Response handle = Util.handleResponse(response);

      if (handle.statusCode == 200) {
        List<dynamic> json = jsonDecode(handle.bodyString!)['data'];

        for (Map<String, dynamic> item in json) {
          recycledItems.add(RecycledItem.fromJson(item));
        }

      }
      return Response(statusCode: 200, body: recycledItems);
    } catch (ex) {
      return Response(statusCode: 500, statusText: ex.toString());
    }
  }

  Future<Response> getUserHistoryTotals() async {
    try {
      User user = await LocalData.getUser;
      connect.allowAutoSignedCert = true;

      Response response = await connect.get(
        "${NetworkURL.baseUrl}${NetworkURL.getUserHistoryTotals}",
        contentType: "json",
        headers: NetworkURL.mainHeader,
        query: {"user_id": user.id},
      );

      Response handle = Util.handleResponse(response);

      if (handle.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(handle.bodyString!)['data'];
        return Response(statusCode: 200, body: json);
      } else {
        return const Response(statusCode: 201, body: null);
      }
    } catch (ex) {
      return Response(statusCode: 500, statusText: ex.toString());
    }
  }
}
