import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../models/user.dart';
import '../../util/local_data.dart';
import 'auth/network_url_constants.dart';

class ImageUploadProvider extends GetConnect {
  Future<Response> uploadImage(String path) async {
    try {
      User user = await LocalData.getUser;

      final FormData formData=FormData({});

      formData.files.add(MapEntry('file', MultipartFile(File(path), filename: 'image')));

      final Response response = await post(
          "${NetworkURL.baseUrl}${NetworkURL.uploadImage}", formData,
          headers: NetworkURL.mainHeaderUploadImage, query: {'id': user.id});

      debugPrint(response.bodyString);

      if (response.status.hasError) {
        return Future.error(response.body);
      } else {
        return response.body(response.body);
      }
    } catch (ex) {
      return Future.error(ex.toString());
    }
  }
}
