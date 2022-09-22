import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../Globals/Constans/urls.dart';
import '../../htttp_service.dart';

abstract class IRegisterRepository {
  Future register({
    required String name,
    required String lastName,
    required String password,
    required String email,
    required String birthday,
    required String gender,
    required File file,
  });
}

class RegisterRepository implements IRegisterRepository {
  @override
  Future register({
    required String name,
    required String lastName,
    required String password,
    required String email,
    required String birthday,
    required String gender,
    required File file,
  }) async {
    var images = await MultipartFile.fromFile(file.path,
        filename: file.path.split('/').last);
    var body = FormData.fromMap({
      "name": name,
      "lastname": lastName,
      "password": password,
      "email": email,
      "birthday": birthday,
      "gender": gender,
      "file": images,
    });
    var response = await RestConnector(
      baseUrl + userUrl,
      "",
      data: body,
      requestType: RequestType.media,
    ).getData();
    return response;
  }
}
