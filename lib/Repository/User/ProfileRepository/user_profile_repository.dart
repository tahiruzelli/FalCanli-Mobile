import '../../../Globals/Constans/urls.dart';
import '../../../Globals/global_vars.dart';
import '../../htttp_service.dart';

abstract class IUserProfileRepository {
  Future getProfileDatas(String userId);
  Future getUserCredit(String userId);
}

class UserProfileRepository implements IUserProfileRepository {
  @override
  Future getProfileDatas(String userId) async {
    var response = await RestConnector(
      baseUrl + userUrl + "/" + userId,
      jwtToken!,
      requestType: RequestType.get,
    ).getData();
    return response;
  }

  @override
  Future getUserCredit(String userId) async {
    var response = await RestConnector(
      baseUrl + getUserCreditUrl + userId,
      jwtToken!,
      requestType: RequestType.get,
    ).getData();
    return response;
  }
}
