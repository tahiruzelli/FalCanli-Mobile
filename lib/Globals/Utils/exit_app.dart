import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../View/UserViews/LoginView/user_login_view.dart';
import '../Constans/storage_keys.dart';

void exitApp() {
  GetStorage().remove(jwtTokenKey);
  GetStorage().remove(userDataKey);
  GetStorage().remove(userIdKey);
  GetStorage().remove(isUserKey);
  Get.offAll(UserLoginView());
}
