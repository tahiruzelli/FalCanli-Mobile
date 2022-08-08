import 'dart:convert';

import '../../../Globals/Constans/urls.dart';
import '../../htttp_service.dart';

abstract class ILoginRepository {
  Future login(String email, String password);
}

class LoginRepository implements ILoginRepository {
  @override
  Future login(String email, String password) async {
    Map body = {
      "email": email,
      "password": password,
    };
    var jsonBody = const JsonEncoder().convert(body);
    var response = await RestConnector(
      baseUrl + loginUrl,
      "",
      data: jsonBody,
      requestType: RequestType.post,
    ).getData();
    return response;
  }
}
