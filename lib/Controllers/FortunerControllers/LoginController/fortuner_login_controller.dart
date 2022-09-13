import 'package:falcanli/Repository/User/LoginRepository/login_repository.dart';
import 'package:falcanli/View/FortunerViews/MainView/fortuner_main_view.dart';
import 'package:falcanli/View/UserViews/LoginView/user_login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../../../Globals/Constans/storage_keys.dart';
import '../../../Globals/Utils/booleans.dart';
import '../../../Globals/Widgets/custom_snackbar.dart';
import '../../../Globals/global_vars.dart';

class FortunerLoginController extends GetxController {
  LoginRepository loginRepository = LoginRepository();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isLoginLoading = false.obs;

  void onUserLoginButtonPressed() {
    emailController.clear();
    passwordController.clear();
    Get.off(UserLoginView());
  }

  void onFortunerLoginButtonPressed() {
    if (!GetUtils.isEmail(emailController.text)) {
      warningSnackBar("E mail formatınız hatalı");
    } else if (passwordController.text.length < 8) {
      warningSnackBar("Şifreniz 8 karakterden küçük olamaz");
    } else {
      isLoginLoading.value = true;
      loginRepository
          .login(emailController.text, passwordController.text)
          .then((value) {
        isLoginLoading.value = false;
        if (isHttpOK(value['statusCode'])) {
          Get.offAll(FortunerMainView());
          jwtToken = value['result'];
          Map<String, dynamic> payload = Jwt.parseJwt(jwtToken ?? "");
          GetStorage().write(userIdKey, payload['userid']);
          GetStorage().write(jwtTokenKey, jwtToken);
          GetStorage().write(isUserKey, !payload['isFortuneTeller']);
        } else {
          warningSnackBar(value['message']);
        }
      });
    }
  }
}
