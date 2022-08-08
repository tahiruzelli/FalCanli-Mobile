import 'dart:convert';

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
  });
}

class RegisterRepository implements IRegisterRepository {
  @override
  Future register(
      {required String name,
      required String lastName,
      required String password,
      required String email,
      required String birthday,
      required String gender}) async {
    Map body = {
      "name": name,
      "lastname": lastName,
      "password": password,
      "email": email,
      "birthday": birthday,
      "gender": gender,
    };
    var jsonBody = const JsonEncoder().convert(body);
    var response = await RestConnector(
      baseUrl + userUrl,
      "",
      data: jsonBody,
      requestType: RequestType.post,
    ).getData();
    return response;
  }
}
