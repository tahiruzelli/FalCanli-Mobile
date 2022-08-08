import 'package:falcanli/Repository/htttp_service.dart';
import '../../../Globals/Constans/urls.dart';
import '../../../Globals/global_vars.dart';

abstract class IFortunerMainRepository {
  Future setAvailable(String id);
  Future setNotAvailable(String id);
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
}
