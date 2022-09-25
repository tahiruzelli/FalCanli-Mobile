import 'dart:convert';

import 'package:falcanli/Globals/global_vars.dart';

import '../../../Globals/Constans/urls.dart';
import '../../htttp_service.dart';

abstract class IUserCreditRepository {
  Future getCredit({required int amount, required String userId});
  Future spendCredit(
      {required int amount,
      required String userId,
      required String fortuneTellerId});
}

class UserCreditRepository implements IUserCreditRepository {
  @override
  Future getCredit({required int amount, required String userId}) async {
    Map body = {
      "amount": amount,
      "userid": userId,
      "type": "yükleme",
    };
    var jsonBody = const JsonEncoder().convert(body);
    var response = await RestConnector(
      baseUrl + userCreditUrl,
      jwtToken!,
      data: jsonBody,
      requestType: RequestType.post,
    ).getData();
    return response;
  }

  @override
  Future spendCredit(
      {required int amount,
      required String userId,
      required String fortuneTellerId}) async {
    Map body = {
      "amount": amount,
      "userid": userId,
      "type": "harcama",
      "fortuneTellerId": fortuneTellerId,
    };
    var jsonBody = const JsonEncoder().convert(body);
    var response = await RestConnector(
      baseUrl + userCreditUrl,
      jwtToken!,
      data: jsonBody,
      requestType: RequestType.post,
    ).getData();
    return response;
  }
}
