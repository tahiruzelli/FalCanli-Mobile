import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Globals/Constans/storage_keys.dart';
import '../View/FortunerViews/MainView/fortuner_main_view.dart';
import '../View/UserViews/LoginView/user_login_view.dart';
import '../View/UserViews/MainView/user_main_view.dart';

class MainController extends GetxController {
  
  void pushPage() {
    if (GetStorage().read(jwtTokenKey) == null) {
      Get.offAll(UserLoginView());
    } else {
      //some one loginned
      bool? isUser = GetStorage().read(isUserKey);
      if (isUser == null) {
        //TODO auth error
      } else if (isUser) {
        Get.offAll(UserMainView());
      } else {
        Get.offAll(FortunerMainView());
      }
    }
  }


}
