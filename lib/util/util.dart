import 'package:dialog_loader/dialog_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Util {
  static late DialogLoader _dialogLoader;

  static get responseOK => 200;

  static Response handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return Response(
            statusCode: 200,
            body: response.bodyString!,
            bodyString: response.bodyString!,
            statusText: "ok");
      case 401:
        return const Response(
            statusCode: 401,
            body: {"result": "error"},
            bodyString: "result: error",
            statusText: "Unauthorized");
      default:
        return const Response(
            statusCode: 201,
            body: {"result": "server data error"},
            bodyString: "result: server data error",
            statusText: 'خطأ في الاتصال بالخادم');
    }
  }
}

class ScreenLoader {
  static late DialogLoader _dialogLoader;

  Future<void> show(BuildContext context) async {
    _dialogLoader = DialogLoader(context: context);
    _dialogLoader.show(
      theme: LoaderTheme.dialogDefault,
      title: Text("Loading".tr),
      leftIcon: const CircularProgressIndicator(),
    );
  }

  void update(String title, IconData leftIcon,
      {Color colors = Colors.black87}) {
    _dialogLoader.update(
      title: Text(
        title,
        style: TextStyle(color: colors),
      ),
      leftIcon: Icon(
        leftIcon,
        color: colors,
      ),
      autoClose: false,
      barrierDismissible: true,
    );
  }

  void hide() {
    _dialogLoader.close();
  }
}
