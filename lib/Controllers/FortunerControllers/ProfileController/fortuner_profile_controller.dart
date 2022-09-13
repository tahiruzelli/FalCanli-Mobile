import 'package:falcanli/Globals/Constans/storage_keys.dart';
import 'package:falcanli/Globals/Constans/urls.dart';
import 'package:falcanli/Globals/Utils/booleans.dart';
import 'package:falcanli/Globals/Widgets/custom_snackbar.dart';
import 'package:falcanli/Globals/global_vars.dart';
import 'package:falcanli/Repository/User/ProfileRepository/user_profile_repository.dart';
import 'package:falcanli/View/UserViews/LoginView/user_login_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../Models/user.dart';

class FortunerProfileController extends GetxController {
  UserProfileRepository profileRepository = UserProfileRepository();

  RxBool isProfileDatasLoading = false.obs;

  User? user;

  Future getUserDatas() async {
    String? userId = GetStorage().read(userIdKey);
    if (userId == null) {
      onLogoutButtonPressed();
      errorSnackBar("Bir hata oluştu, otomatik çıkış yapılıyor.");
    } else {
      isProfileDatasLoading.value = true;
      profileRepository.getProfileDatas(userId).then((value) {
        if (isHttpOK(value['statusCode'])) {
          user = User.fromJson(value['result']);
          userImage = user?.photo ?? emptyUser;
          isProfileDatasLoading.value = false;
        } else {
          warningSnackBar(value['message']);
          isProfileDatasLoading.value = false;
        }
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  void onLogoutButtonPressed() {
    GetStorage().remove(jwtTokenKey);
    GetStorage().remove(userDataKey);
    GetStorage().remove(userIdKey);
    GetStorage().remove(isUserKey);
    Get.offAll(UserLoginView());
  }
}
