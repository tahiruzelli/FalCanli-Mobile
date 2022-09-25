import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
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
  Future endConversation(String conversationId);
  Future rateCall(
      {required String conversationId,
      required int point,
      required String comment});
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
    var body;
    var jsonBody;
    if (photo1 == null) {
      body = {
        "fortuneTellerId": fortunerTellerId,
        "userid": userId,
        "conversationType": conversationType
      };
      jsonBody = const JsonEncoder().convert(body);
    } else {
      var image1 = await MultipartFile.fromFile(photo1.path,
          filename: photo1.path.split('/').last);
      var image2 = await MultipartFile.fromFile(photo2!.path,
          filename: photo2.path.split('/').last);
      var image3 = await MultipartFile.fromFile(photo3!.path,
          filename: photo3.path.split('/').last);
      body = FormData.fromMap({
        "fortuneTellerId": fortunerTellerId,
        "userid": userId,
        "conversationType": conversationType,
        "files": [
          image1,
          image2,
          image3,
        ],
      });
    }

    var response = await RestConnector(
      baseUrl + conversationUrl,
      jwtToken!,
      data: photo1 == null ? jsonBody : body,
      requestType: photo1 == null ? RequestType.post : RequestType.media,
    ).getData();
    return response;
  }

  @override
  Future endConversation(String conversationId) async {
    Map body = {
      "status": "görüşme tamamlandı",
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
  Future rateCall(
      {required String conversationId,
      required int point,
      required String comment}) async {
    Map body = {
      "point": point,
      "comment": comment,
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
}
