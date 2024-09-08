import 'package:dio/dio.dart';
import 'package:tagmeea/app/controller/user_controller.dart';
import '../../models/user.dart';
import '../../util/local_data.dart';
import 'auth/network_url_constants.dart';

class AvatarController {
  Future<Response> upload(String path) async {
    User user = await LocalData.getUser;

    try {
      final FormData form = FormData.fromMap(
          {'file': await MultipartFile.fromFile(path, filename: 'image')});

      Response response = await Dio().post(
          "${NetworkURL.baseUrl}${NetworkURL.uploadImage}",
          data: form,
          options: Options(headers: NetworkURL.mainHeaderUploadImage),
          queryParameters: {'id': user.id}
      );

      //debugPrint('upload avatar : $response');

      if (response.statusCode==200)
        {
          user.avatar = response.data['avatar_url'];
          await UserController().saveUser(user);
          UserController().user = user;
        }

      //debugPrint('after upload : $response');
      return response;

    } catch (ex) {
      return Response(data: ex.toString(),requestOptions: RequestOptions(), statusCode: 500);
    }
  }
}
