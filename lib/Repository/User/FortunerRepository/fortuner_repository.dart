import 'dart:convert';

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
}
