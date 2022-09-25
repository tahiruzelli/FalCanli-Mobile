import 'dart:convert';

import 'package:falcanli/Repository/htttp_service.dart';
import '../../../Globals/Constans/urls.dart';
import '../../../Globals/global_vars.dart';

abstract class IFortunerMainRepository {
  Future setAvailable(String id);
  Future setNotAvailable(String id);
  Future acceptMeet({
    required String fortunerId,
    required String userId,
    required String conversationId,
  });
  Future declineMeet({
    required String fortunerId,
    required String userId,
    required String conversationId,
  });
  Future getFortunerDataWithUserId(String id);
}

class FortunerMainRepository implements IFortunerMainRepository {
  @override
  Future setAvailable(String id) async {
    var response = await RestConnector(
      baseUrl + setAvaibleUrl + id,
      jwtToken!,
      requestType: RequestType.pathch,
    ).getData();
    return response;
  }

  @override
  Future setNotAvailable(String id) async {
    var response = await RestConnector(
      baseUrl + setNotAvaibleUrl + id,
      jwtToken!,
      requestType: RequestType.pathch,
    ).getData();
    return response;
  }

  @override
  Future acceptMeet({
    required String fortunerId,
    required String userId,
    required String conversationId,
  }) async {
    Map body = {
      "status": "görüşmede",
    };
    var jsonBody = const JsonEncoder().convert(body);
    var response = await RestConnector(
      baseUrl + conversationUrl + "/" + conversationId,
      jwtToken!,
      data: jsonBody,
      requestType: RequestType.pathch,
    ).getData();
    return response;
  }

  @override
  Future declineMeet({
    required String fortunerId,
    required String userId,
    required String conversationId,
  }) async {
    Map body = {
      "fortuneTellerId": fortunerId,
      "userid": userId,
      "status": "reddedildi",
    };
    var jsonBody = const JsonEncoder().convert(body);
    var response = await RestConnector(
      baseUrl + conversationUrl + "/" + conversationId,
      jwtToken!,
      data: jsonBody,
      requestType: RequestType.pathch,
    ).getData();
    return response;
  }

  @override
  Future getFortunerDataWithUserId(String id) async {
    var response = await RestConnector(
      baseUrl + "fortune-teller/getFortuneTellerWithUserId/" + id,
      jwtToken!,
      data: "",
      requestType: RequestType.get,
    ).getData();
    return response;
  }
}
