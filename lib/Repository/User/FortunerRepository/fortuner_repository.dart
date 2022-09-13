import 'dart:convert';
import 'dart:io';

import 'package:falcanli/Globals/Constans/storage_keys.dart';
import 'package:falcanli/Globals/global_vars.dart';

import '../../../Globals/Constans/urls.dart';
import '../../htttp_service.dart';

abstract class IFortunerRepository {
  Future getFortuner({
    required bool tarot,
    required bool kahve,
    required bool dogumharitasi,
    required bool astroloji,
  });
  Future getComments(String fortuneTellerId);
  Future startConversation({
    required String fortunerTellerId,
    required String userId,
    required String conversationType,
    File? photo1,
    File? photo2,
    File? photo3,
  });
}

class FortunerRepository implements IFortunerRepository {
  @override
  Future getFortuner({
    required bool tarot,
    required bool kahve,
    required bool dogumharitasi,
    required bool astroloji,
  }) async {
    var response = await RestConnector(
      baseUrl + getFortunerListUrl + "/$tarot/$kahve/$dogumharitasi/$astroloji",
      jwtToken!,
      requestType: RequestType.get,
    ).getData();
    return response;
  }

  @override
  Future getComments(String fortuneTellerId) async {
    var response = await RestConnector(
      baseUrl + getCommentsUrl + fortuneTellerId,
      jwtToken!,
      requestType: RequestType.get,
    ).getData();
    return response;
  }

  @override
  Future startConversation({
    required String fortunerTellerId,
    required String userId,
    required String conversationType,
    File? photo1,
    File? photo2,
    File? photo3,
  }) async {
    Map body;
    if (photo1 == null) {
      body = {
        "fortuneTellerId": fortunerTellerId,
        "userid": userId,
        "conversationType": conversationType
      };
    } else {
      body = {
        "fortuneTellerId": fortunerTellerId,
        "userid": userId,
        "conversationType": conversationType,
        "photo1": photo1,
        "photo2": photo2,
        "photo3": photo3
      };
    }
    var jsonBody = const JsonEncoder().convert(body);
    var response = await RestConnector(
      baseUrl + conversationUrl,
      jwtToken!,
      data: jsonBody,
      requestType: RequestType.post,
    ).getData();
    return response;
  }
}
