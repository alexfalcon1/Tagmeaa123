import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tagmeea/app/controller/auth/network_url_constants.dart';
import 'package:tagmeea/models/Task.dart';
import 'package:tagmeea/util/local_data.dart';

import '../../models/user.dart';
import '../../util/util.dart';

class TaskController extends GetxController {
  late Map<String, String> _mainHeader;
  GetConnect connect = GetConnect();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    connect.allowAutoSignedCert = true;
  }

  Future<Response> getTasksAsync() async {
    List<Task> tasks = [];
    try {
      User user = await LocalData.getUser;
      connect.allowAutoSignedCert = true;
      Response response = await connect.get(
          "${NetworkURL.baseUrl}${NetworkURL.getTasks}",
          contentType: 'json',
          headers: NetworkURL.mainHeader,
          query: {'id': user.id});

      Response handle = Util.handleResponse(response);

      if (handle.statusCode == 200) {
        List<dynamic> json = jsonDecode(handle.bodyString!)['tasks'];
        for (Map<String, dynamic> item in json) {
          tasks.add(Task.fromJson(item));
        }
      }
      return Response(statusCode: 200, body: tasks);
    } catch (ex) {
      return Response(statusCode: 500, statusText: ex.toString());
    }
  }

  Future<Response> setTaskCompleteAsync(BigInt taskId) async {

    FormData formData= FormData({'task_id':taskId.toString()});
    //formData.fields.add(MapEntry('task_id', taskId.toString()));

    try {
      connect.allowAutoSignedCert = true;
      Response response = await connect.post(
          "${NetworkURL.baseUrl}${NetworkURL.completeTask}",
          formData,
          headers: NetworkURL.mainHeader,
          query: {'task_id':taskId.toString()}
          );

      Response handle = Util.handleResponse(response);
      if (handle.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(handle.bodyString!);
        return Response(statusCode: 200, bodyString: 'success', body: json);
      }

      return Response(
          statusCode: 201, bodyString: response.bodyString, body: 'error');
    } catch (ex) {
      return Response(statusCode: 500, statusText: ex.toString());
    }
  }

  Future<Response> getUnreadTasksCount() async {
    try {
      User user = await LocalData.getUser;
      connect.allowAutoSignedCert = true;
      Response response = await connect.get(
          "${NetworkURL.baseUrl}${NetworkURL.unreadTasks}",
          contentType: 'json',
          headers: NetworkURL.mainHeader,
          query: {'id': user.id});

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
